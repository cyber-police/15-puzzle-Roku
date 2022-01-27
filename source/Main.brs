sub Main()
    showChannelSGScreen()
end sub

sub showChannelSGScreen()
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    scene = screen.CreateScene("MainScene")
    screen.show()

    scene.observeField("appExit", m.port)

    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)

        if(msgType = "roSGNodeEvent")
            if(msg.getField() = "appExit")
                screen.close()
            end if
        end if
    end while
end sub