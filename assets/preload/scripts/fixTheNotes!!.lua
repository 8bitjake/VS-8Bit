function onUpdate()
    setPropertyFromGroup('opponentStrums',0,'x',defaultOpponentStrumX0)
    setPropertyFromGroup('opponentStrums',0,'y',getPropertyFromGroup('opponentStrums',1,'y'))
end