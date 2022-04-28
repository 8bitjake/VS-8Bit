currentDifficulty = 'its still fucked';

function onCreate()
    makeLuaText('songText','deez', 0, 2, 701);
    setTextAlignment('songText', 'left');
    setTextSize('songText', 15);
    setTextBorder('songText', 1, '000000');
    addLuaText('songText');
end

function onCreatePost()
    setProperty('timeBar.y', getProperty('timeBar.y') - 10);
    setProperty('timeTxt.y', getProperty('timeTxt.y') - 10);
end

function onUpdate(elapsed)
    currentDifficulty = getProperty('storyDifficultyText');
    setTextString('songText', songName .. ' (' .. currentDifficulty .. ") - VS. 8Bit v"..getPropertyFromClass('MainMenuState','vs8bitVersion')..' (Psych Engine v'..getPropertyFromClass('MainMenuState','psychEngineVersion')..')');
end