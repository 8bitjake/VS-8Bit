local timer = 0
local angle = 0
local angleValue = 1
function onUpdate(elapsed)
    local timer2 = timer-15
    local daBase = defaultPlayerStrumY0 + 150
    local daValue1 = daBase+(math.sin((timer*0.001)*50))*30
    local daValue2 = daBase+(math.sin((timer2*0.001)*50))*30
    daValue1 = daValue1 - 150
    daValue2 = daValue2 - 150
    setPropertyFromGroup('playerStrums',0,'y',daValue1)
    setPropertyFromGroup('playerStrums',1,'y',daValue2)
    setPropertyFromGroup('playerStrums',2,'y',daValue1)
    setPropertyFromGroup('playerStrums',3,'y',daValue2)

    setPropertyFromGroup('opponentStrums',0,'y',daValue1)
    setPropertyFromGroup('opponentStrums',1,'y',daValue2)
    setPropertyFromGroup('opponentStrums',2,'y',daValue1)
    setPropertyFromGroup('opponentStrums',3,'y',daValue2)
    timer = timer + 1

    setProperty('camHUD.angle',angle)

    if(getProperty('health') < 0)then
        setProperty('health',0)
    end
end