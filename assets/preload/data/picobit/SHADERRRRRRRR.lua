function onBeatHit()
    if(curBeat == 64)then
        addChromaticAbberationEffect('camGame',5)
        addChromaticAbberationEffect('camHUD',2.5)
        addChromaticAbberationEffect('camOther',1.25) -- yes, even the watermark gets in on the action
    end
end