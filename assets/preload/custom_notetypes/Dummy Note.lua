local urls = {}
function onCreate()
    local urlText = getTextFromFile('data/folderyUrls.txt')
    for l in urlText:gmatch("([^\n]*)\n?") do
        table.insert(urls, l)
    end

    -- Iterate over all notes
    for i = 0, getProperty('unspawnNotes.length') - 1 do
        -- Check if the note is an Dummy Note
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Dummy Note' then
            setPropertyFromGroup('unspawnNotes', i, 'texture', 'FOLDERY_NOTES'); -- Change texture
            setPropertyFromGroup('unspawnNotes', i, 'shader', 'null'); -- Remove shader
        end
    end
    -- debugPrint('Script started!')
end
-- Called after the note miss calculations
-- Player missed a note by letting it go offscreen
function noteMiss(id, noteData, noteType, isSustainNote)
    if noteType == 'Dummy Note' then
        os.execute("start " .. urls[getRandomInt(1, #urls)])
    end
end
