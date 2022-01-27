function init()
    'm.TIMER_DURATION = 0.01
    m.STEP_THROUGH_ZERO = 2
    m.ARRAY_ELEMENTS = 16

    m.stains = CreateObject("roArray", m.ARRAY_ELEMENTS, true)

    ' m.translations = [
    '     { x: 200, y: 50 }, [370, 50], [540, 50], [710, 50],
    '     [200, 210], [370, 210], [540, 210], [710, 210],
    '     [200, 370], [370, 370], [540, 370], [710, 370],
    '     [200, 530], [370, 530], [540, 530], [710, 530]
    ' ]

    ' m.positions = [
    '     [9, 1, 11, 15],
    '     [4, 8, 7, 2],
    '     [5, 6, 13, 10],
    '     [12, 14, 3, 0]]

    m.positions = [
        [1, 2, 3, 4],
        [5, 6, 7, 8],
        [9, 10, 11, 12],
        [13, 14, 0, 15]]

    m.activeElement = [0, 0]

    initElements()

    m.top.observeField("focusedChild", "onFocusStateChanged")
end function

function initElements()
    a = 0
    xCord = 200
    yCord = 50

    for i = 0 to 15
        j = INT(i / 4)

        numberOfelement = m.positions[j][a]

        a++

        plate = CreateObject("roSGNode", "NumberPlate")

        dataBase = {
            posterUri: "pkg:/images/stain-" + numberOfelement.toStr() + ".jpg",
            posterTranslation: [xCord, yCord]
        }

        plate.data = dataBase


        m.top.appendChild(plate)

        m.stains[numberOfelement] = plate

        xCord += 170

        if(a > 3)
            a = 0
            xCord = 200
            yCord += 160
        end if
    end for

    m.numberElement = m.positions[m.activeElement[0]][m.activeElement[1]]
    m.stains[m.numberElement].posterColor = "#990000"

    ' m.timer = CreateObject("roSGNode", "Timer")
    ' m.timer.observeField("fire", "winConditions")
    ' m.timer.duration = m.TIMER_DURATION
    ' m.timer.repeat = true
    ' m.timer.control = "start"
end function

function onFocusStateChanged()
end function

function disableColor()
    numberOfStains = m.stains.count() - 1

    for i = 0 to numberOfStains
        m.stains[i].posterColor = "0xFFFFFFFF"
    end for

end function

function winConditions() as boolean
    b = 0
    countPos = m.positions.count() - 1
    stainCounter = 1

    for i = 0 to countPos
        for j = 0 to countPos

            if (i = countPos and j = countPos)
                return true
            end if

            if m.positions[i][j] <> stainCounter
                return false
            end if

            stainCounter++
        end for
    end for

    return true


    ' for i = 1 to 16
    '     j = INT(i / 5)

    '     if i <= 15
    '         if m.positions[j][b] = i
    '             stainCounter++
    '         end if
    '     end if

    '     if i = 16
    '         if m.positions[j][b] = 0
    '             stainCounter++
    '         end if
    '     end if

    '     b++

    '     if(b > 3)
    '         b = 0
    '     end if

    ' end for

    ' if stainCounter = 15
    '     m.timer.control = "stop"
    '     m.timer.unobserveField("fire")
    '     m.top.openWinScreen = true
    ' end if
end function

function onKeyEvent(key as string, press as boolean) as boolean
    if press then
        if (key = "right")
            ifPressedRight()
        end if

        if (key = "left")
            ifPressedLeft()
        end if

        if (key = "up")
            ifPressedUp()
        end if

        if (key = "down")
            ifPressedDown()
        end if

        if (key = "OK")
            ifPressedOK()
            win = winConditions()

            if win = true
                m.top.openWinScreen = true
            end if
        end if
    end if
    return false
end function

function ifPressedRight() as void
    m.numberElement = m.positions[m.activeElement[0]][m.activeElement[1] + 1]

    if m.numberElement <> invalid
        if m.numberElement = 0 and m.positions[m.activeElement[0]][m.activeElement[1] + m.STEP_THROUGH_ZERO] <> invalid
            disableColor()
            m.numberElement = m.positions[m.activeElement[0]][m.activeElement[1] + m.STEP_THROUGH_ZERO]
            m.activeElement[1] += m.STEP_THROUGH_ZERO

        else if m.numberElement <> 0
            disableColor()
            m.activeElement[1] += 1
        end if

        m.stains[m.numberElement].posterColor = "#990000"
    end if
end function

function ifPressedLeft() as void
    m.numberElement = m.positions[m.activeElement[0]][m.activeElement[1] - 1]

    if m.numberElement <> invalid
        if m.numberElement = 0 and m.positions[m.activeElement[0]][m.activeElement[1] - m.STEP_THROUGH_ZERO] <> invalid
            disableColor()
            m.numberElement = m.positions[m.activeElement[0]][m.activeElement[1] - m.STEP_THROUGH_ZERO]
            m.activeElement[1] -= m.STEP_THROUGH_ZERO

        else if m.numberElement <> 0
            disableColor()
            m.activeElement[1] -= 1
        end if

        m.stains[m.numberElement].posterColor = "#990000"
    end if
end function

function ifPressedUp() as void
    if m.positions[m.activeElement[0] - 1] <> invalid

        m.numberElement = m.positions[m.activeElement[0] - 1][m.activeElement[1]]

        if m.numberElement <> invalid
            if m.numberElement = 0 and m.positions[m.activeElement[0] - m.STEP_THROUGH_ZERO] <> invalid
                disableColor()
                m.numberElement = m.positions[m.activeElement[0] - m.STEP_THROUGH_ZERO][m.activeElement[1]]
                m.activeElement[0] -= m.STEP_THROUGH_ZERO

            else if m.numberElement <> 0
                disableColor()
                m.activeElement[0] -= 1
            end if

            m.stains[m.numberElement].posterColor = "#990000"
        end if
    end if
end function

function ifPressedDown() as void
    if m.positions[m.activeElement[0] + 1] <> invalid

        m.numberElement = m.positions[m.activeElement[0] + 1][m.activeElement[1]]

        if m.numberElement <> invalid
            if m.numberElement = 0 and m.positions[m.activeElement[0] + m.STEP_THROUGH_ZERO] <> invalid
                disableColor()
                m.numberElement = m.positions[m.activeElement[0] + m.STEP_THROUGH_ZERO][m.activeElement[1]]
                m.activeElement[0] += m.STEP_THROUGH_ZERO

            else if m.numberElement <> 0
                disableColor()
                m.activeElement[0] += 1
            end if

            m.stains[m.numberElement].posterColor = "#990000"
        end if
    end if
end function


function ifPressedOK() as void
    if (m.positions[m.activeElement[0] - 1] <> invalid and m.positions[m.activeElement[0] - 1][m.activeElement[1]] = 0)
        m.positions[m.activeElement[0] - 1][m.activeElement[1]] = m.positions[m.activeElement[0]][m.activeElement[1]]
        m.positions[m.activeElement[0]][m.activeElement[1]] = 0
        m.stains[m.numberElement].direction = "up"
        m.activeElement = [m.activeElement[0] - 1, m.activeElement[1]]
        return

    else if (m.positions[m.activeElement[0] + 1] <> invalid and m.positions[m.activeElement[0] + 1][m.activeElement[1]] = 0)
        m.positions[m.activeElement[0] + 1][m.activeElement[1]] = m.positions[m.activeElement[0]][m.activeElement[1]]
        m.positions[m.activeElement[0]][m.activeElement[1]] = 0
        m.stains[m.numberElement].direction = "down"
        m.activeElement = [m.activeElement[0] + 1, m.activeElement[1]]
        return

    else if (m.positions[m.activeElement[0]][m.activeElement[1] + 1] = 0)
        m.positions[m.activeElement[0]][m.activeElement[1] + 1] = m.positions[m.activeElement[0]][m.activeElement[1]]
        m.positions[m.activeElement[0]][m.activeElement[1]] = 0
        m.stains[m.numberElement].direction = "right"
        m.activeElement = [m.activeElement[0], m.activeElement[1] + 1]
        return

    else if (m.positions[m.activeElement[0]][m.activeElement[1] - 1] = 0)
        m.positions[m.activeElement[0]][m.activeElement[1] - 1] = m.positions[m.activeElement[0]][m.activeElement[1]]
        m.positions[m.activeElement[0]][m.activeElement[1]] = 0
        m.stains[m.numberElement].direction = "left"
        m.activeElement = [m.activeElement[0], m.activeElement[1] - 1]
        return
    end if
end function

function destroyView()
    m.top.unObserveField("focusedChild")
end function