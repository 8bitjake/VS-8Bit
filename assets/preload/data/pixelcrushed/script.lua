function onBeatHit()
    if(curBeat == 64)then
        addLuaScript('screenRotate')
        if flashingLights then
            addChromaticAbberationEffect('game')
            addChromaticAbberationEffect('hud')
        end
    end
end