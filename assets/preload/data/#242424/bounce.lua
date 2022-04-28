function onBeatHit()
    triggerEvent('Add Camera Zoom')
    if(curBeat < 240 or curBeat >= 304) then return; end
    local bounceStrength = 2.2222222222
    if(curBeat % 2 == 0) then
        setProperty('camGame.angle',bounceStrength/1.5)
        setProperty('camHUD.angle',-bounceStrength)
    else
        setProperty('camGame.angle',-bounceStrength/1.5)
        setProperty('camHUD.angle',bounceStrength)
    end
    doTweenAngle('camGameAngle','camGame',0,(60/bpm),'circOut')
    doTweenAngle('camHUDAngle','camHUD',0,(60/bpm),'circOut')
end