function onBeatHit()
    if(curBeat < 64) then return; end
    local bounceStrength = 12
    local cameraBounces = {0.015,0.03}
    cameraBounces[1] = cameraBounces[1]*(bounceStrength/2)
    cameraBounces[2] = cameraBounces[2]*(bounceStrength/2)
    triggerEvent('Add Camera Zoom',cameraBounces[1],cameraBounces[2])

    if(curBeat % 2 == 0) then
        setProperty('camGame.angle',bounceStrength/3)
        setProperty('camHUD.angle',-bounceStrength/2)
    else
        setProperty('camGame.angle',-bounceStrength/3)
        setProperty('camHUD.angle',bounceStrength/2)
    end
    doTweenAngle('camGameAngle','camGame',0,(60/bpm),'circOut')
    doTweenAngle('camHUDAngle','camHUD',0,(60/bpm),'circOut')
end