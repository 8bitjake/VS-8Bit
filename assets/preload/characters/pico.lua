function onBeatHit()
    if(curStep < 50)then
        characterPlayAnim('bf','idle-start')
    end
end
function onCountdownTick(counter)
	onBeatHit()
end