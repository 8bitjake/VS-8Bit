function onBeatHit()
    if(curBeat < 96 or curBeat >= 160) then return; end
    triggerEvent('Add Camera Zoom')
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