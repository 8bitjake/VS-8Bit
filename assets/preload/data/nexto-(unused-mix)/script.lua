function onCreatePost()
    setProperty('dad.visible',false)
    setProperty('iconP2.visible',false)
end

function onUpdate()
    setProperty('health',2)
    for i=0,4,1 do
		setPropertyFromGroup('opponentStrums', i, 'x', -400)
	end
end