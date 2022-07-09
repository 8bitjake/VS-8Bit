local config = {
    showDifficulty = true,
    timeBarScale = 1.25
}

function onCreatePost()
    local songText = songName
    if(config.showDifficulty)then
        songText = songText .. '\n('..getProperty('storyDifficultyText')..')'
    end
    makeLuaText('song', songText, 500, 388, 0)
    setTextAlignment('song', 'center')
    setTextSize('song', 20)
    addLuaText('song')
    screenCenter('song','x')
    if(not downscroll)then
        setProperty('song.y', getProperty('song.y') + 50)
    end
end

function onSongStart()
    --loadGraphic('timeBarBG','healthBar')
    setProperty('timeBarBG.scale.x',config.timeBarScale)
    setProperty('timeBar.visible',false)
    updateHitbox('timeBarBG')
    screenCenter('timeBarBG','x')
    makeLuaSprite('fakeBar','healthBar',getProperty('timeBar.x'),getProperty('timeBar.y'))
    makeGraphic('fakeBar',getProperty('timeBarBG.width'), getProperty('healthBar.height'), 'FFFFFF')
    setObjectCamera('fakeBar','hud')
    setObjectOrder('fakeBar',12)
    setObjectOrder('timeTxt',1000)
    setObjectOrder('timeBarBG',1)
    addLuaSprite('fakeBar')
    setProperty('fakeBar.offset.x',(getProperty('timeBarBG.width')/2)-5)
end

function onUpdatePost()
    local  timeElapsed = math.floor(getProperty('songTime')/1000)
    local  timeTotal = math.floor(getProperty('songLength')/1000)
    local timeElapsedFixed = string.format("%.2d:%.2d", timeElapsed/60%60, timeElapsed%60)
    local timeTotalFixed = string.format("%.2d:%.2d", timeTotal/60%60, timeTotal%60)
    screenCenter('timeBarBG','x')
    setProperty('fakeBar.scale.x',getProperty('songPercent'))
    setProperty('fakeBar.x',getProperty('timeBarBG.x')+(getProperty('songPercent')*(getProperty('timeBarBG.width')/2)))
    setTextString('timeTxt', timeElapsedFixed .. ' / ' .. timeTotalFixed)
end