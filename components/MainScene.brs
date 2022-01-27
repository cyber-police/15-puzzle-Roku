function init()
    createGameScreen()
end function

function createGameScreen()
    m.gamescreen = CreateObject("roSGNode", "GameScreen")
    m.gamescreen.observeField("openWinScreen", "createWinScreen")
    m.top.appendChild(m.gamescreen)
    m.gamescreen.setFocus(true)
end function

function createWinScreen()
    m.winscreen = CreateObject("roSGNode", "WinScreen")
    m.winscreen.observeField("restart", "onRestart")
    m.winscreen.observeField("exit", "onExit")
    m.top.appendChild(m.winscreen)
    m.winscreen.setFocus(true)
end function

function removeGameScreen()
    m.gamescreen.unobserveField("openWinScreen")
    m.top.removeChild(m.gamescreen)
    m.gamescreen = invalid
end function

function onRestart()
    removeWinScreen()
    removeGameScreen()
    createGameScreen()
    m.gamescreen.setFocus(true)
end function

function removeWinScreen()
    m.winscreen.unobserveField("restart")
    m.winscreen.unobserveField("exit")
    m.top.removeChild(m.winscreen)
    m.winscreen = invalid
end function

function onExit()
    m.top.appExit = true
end function