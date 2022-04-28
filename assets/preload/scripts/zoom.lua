isFirstNote = false;

function onCountdownTick(counter)
    spb = (60 / bpm);
	if counter == 0 then
        doTweenZoom('hudZoom','camHUD',1.5,spb*2,'circIn')
       doTweenAlpha('hudAlpha','camHUD',0,spb*2,'circIn')
        doTweenZoom('gameZoom','camGame',getProperty('defaultCamZoom')*1.4,spb*2,'circInOut')
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if not isFirstNote then
    doTweenZoom('hudZoom','camHUD',1,spb*2,'circOut')
    doTweenAlpha('hudAlpha','camHUD',1,spb*2,'circOut')
    isFirstNote = true;
    end
end