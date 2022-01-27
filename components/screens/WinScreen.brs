function init()
    m.DESCRIPTION_TRANSLATION = [345, 245]

    m.BACKGROUND_TRANSLATION = [295, 230]
    m.BACKGROUND_TRANSLATION2 = [305, 240]
    m.BACKGROUND_OPACITY = 0.5

    m.ELEMENT_WIDTH = 700
    m.ELEMENT_HEIGHT = 200

    m.ELEMENT_WIDTH2 = 680
    m.ELEMENT_HEIGHT2 = 180

    m.SCREEN_WIDTH = 1920
    m.SCREEN_HEIGHT = 1080
    m.BACKGROUND_COLOR = "#808080"
    m.BACKGROUND_COLOR2 = "#FFFFFF"
    m.BACKGROUND_FULL_COLOR = "#000000"

    m.text_won = "YOU WON!!!"
    m.text_color = "#990000"

    m.BUTTON_TRANSLATION = [530, 280]
    m.BUTTONS_SPACING = [0]

    m.RESTART_LABEL = "RESTART"
    m.EXIT_LABEL = "EXIT"

    m.CHANGE_TRANSLATION = 20


    m.top.observeField("focusedChild", "onFocusStateChanged")
    initElements()
end function

function initElements()
    m.backgroundfull = m.top.findNode("background_full")
    m.backgroundfull.width = m.SCREEN_WIDTH
    m.backgroundfull.height = m.SCREEN_HEIGHT
    m.backgroundfull.color = m.BACKGROUND_FULL_COLOR
    m.backgroundfull.opacity = m.BACKGROUND_OPACITY

    m.background = m.top.findNode("background")
    m.background.translation = m.BACKGROUND_TRANSLATION
    m.background.width = m.ELEMENT_WIDTH
    m.background.height = m.ELEMENT_HEIGHT
    m.background.color = m.BACKGROUND_COLOR
    m.background.opacity = m.BACKGROUND_OPACITY

    m.background2 = m.top.findNode("background2")
    m.background2.translation = m.BACKGROUND_TRANSLATION2
    m.background2.width = m.ELEMENT_WIDTH2
    m.background2.height = m.ELEMENT_HEIGHT2
    m.background2.color = m.BACKGROUND_COLOR2

    m.buttonsGroup = m.top.findNode("buttonsGroup")
    m.buttonsGroup.layoutDirection = "vert"
    m.buttonsGroup.itemspacings = m.BUTTONS_SPACING
    m.buttonsGroup.translation = m.BUTTON_TRANSLATION

    m.restartButton = m.top.findNode("restartButton")
    m.restartButton.buttonName = m.RESTART_LABEL

    m.exitButton = m.top.findNode("exitButton")
    m.exitButton.buttonName = m.EXIT_LABEL
end function

function onFocusStateChanged()
    if (m.top.hasFocus())
        m.restartButton.setFocus(true)
    end if
end function

function onKeyEvent(key as string, press as boolean) as boolean
    if press
        if(key = "back")
            return true
        end if

        if (key = "down")
            if (m.restartButton.hasFocus())
                m.exitButton.setFocus(true)
            end if
        end if

        if (key = "up")
            if (m.exitButton.hasFocus())
                m.restartButton.setFocus(true)
            end if
        end if

        if (key = "OK")
            if (m.exitButton.hasFocus())
                m.top.exit = true
            else if (m.restartButton.hasFocus())
                m.top.restart = true
            end if
        end if
    end if
end function

function destroyView()
    m.top.unObserveField("focusedChild")
end function