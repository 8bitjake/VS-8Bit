function onUpdate()
    setPropertyFromGroup('opponentStrums',0,'x',defaultOpponentStrumX0)
    if(songName == 'puddles') then return; end
    setPropertyFromGroup('opponentStrums',0,'y',getPropertyFromGroup('opponentStrums',1,'y'))
end