function onIconBop()
    if curBeat % 2 == 1 then
        veryCoolScale = 0-veryCoolScale
        veryCoolAngle = 0-veryCoolAngle
    end
    scaleObject('iconP1',1+veryCoolScale)
    scaleObject('iconP2',1+veryCoolScale)


    setProperty('iconP1.angle',getProperty('iconP1.angle')-veryCoolAngle)
    setProperty('iconP2.angle',getProperty('iconP2.angle')+veryCoolAngle)

    doTweenAngle('icon1Angle','iconP1',0,tweenTime,'circOut')
    doTweenAngle('icon2Angle','iconP2',0,tweenTime,'circOut')
    return Function_Stop;
end

function onUpdate()
    veryCoolAngle = getProperty('health')*10
    veryCoolScale = getProperty('health')*0.2
    tweenTime = (60/bpm)
end