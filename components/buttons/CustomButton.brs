function init()
    m.ELEMENT_WIDTH = 200
    m.ELEMENT_HEIGHT = 50

    m.BACKGROUND_COLOR = "#ffffff"
    m.BACKGROUND_COLOR2 = "#990000"

    m.BUTTON_TEXT_COLOR = "#000000"

    m.top.observeField("focusedChild", "onFocusedStateChanged")

    initElements()
end function

function initElements()
    m.buttonText = m.top.findNode("buttonText")
    m.buttonText.width = m.ELEMENT_WIDTH
    m.buttonText.height = m.ELEMENT_HEIGHT
    m.buttonText.color = m.BUTTON_TEXT_COLOR
    m.buttonText.horizAlign = "center"
    m.buttonText.vertAlign = "center"

    m.background = m.top.findNode("background")
    m.background.width = m.ELEMENT_WIDTH
    m.background.height = m.ELEMENT_HEIGHT
    m.background.color = m.BACKGROUND_COLOR
end function

function onFocusedStateChanged()
    if (m.top.hasFocus())
        m.background.color = m.BACKGROUND_COLOR2
    else
        m.background.color = m.BACKGROUND_COLOR
    end if
end function

function onButtonName()
    m.buttonText.text = m.top.buttonName
end function