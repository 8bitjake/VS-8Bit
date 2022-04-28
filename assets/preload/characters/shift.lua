function opponentNoteHit(id, noteData, noteType, isSustainNote)
	if getProperty('health') > 0.03 then
	setProperty('health', getProperty('health') - 0.023);
	end
end

function onCreatePost()
	for i=0,4,1 do
		setPropertyFromGroup('opponentStrums', i, 'texture', 'SHIFT_KEY_NOTES_ASSETS')
		setPropertyFromGroup('opponentStrums', i, 'shader', 'null')
	end
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'SHIFT_KEY_NOTES_ASSETS'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'shader', 'null');
		end
	end
end