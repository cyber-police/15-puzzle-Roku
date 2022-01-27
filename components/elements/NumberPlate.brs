function init()
    m.STEP_L_R = 170
    m.STEP_U_D = 160

    initElements()
end function

function initElements()
    m.poster = m.top.findNode("posterPlate")
end function

function onUpdate()
    data = m.top.data

    m.poster.translation = data.posterTranslation
    m.poster.uri = data.posterUri
end function

function onUpdateColor()
    m.poster.blendColor = m.top.posterColor
end function

function onUpdateDirection()
    if (m.top.direction = "up")
        m.poster.translation = [m.poster.translation[0], m.poster.translation[1] - m.STEP_U_D]

    else if (m.top.direction = "down")
        m.poster.translation = [m.poster.translation[0], m.poster.translation[1] + m.STEP_U_D]

    else if (m.top.direction = "right")
        m.poster.translation = [m.poster.translation[0] + m.STEP_L_R, m.poster.translation[1]]

    else if (m.top.direction = "left")
        m.poster.translation = [m.poster.translation[0] - m.STEP_L_R, m.poster.translation[1]]
    end if
end function