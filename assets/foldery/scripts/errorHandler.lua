local errors = {}
local canSummonErrors = false
local sounds = {"Windows Background","Windows Critical Stop","Windows Exclamation","Windows Foreground"}
local errorFrequency = 7
function summonError()
    local error = 'error' .. #errors + 1
    local offsets = {
        x = 0,
        y = 300
    }
    local width = screenWidth - offsets.x
    local height = 600
    makeLuaSprite(error, 'popups/' .. getRandomInt(1, 4), getRandomInt(0, width), getRandomInt(offsets.y, height))
    playSound('errors/'..sounds[getRandomInt(1, #sounds)], 0.5)

    table.insert(errors, error)
    setObjectCamera(error, 'other')
    addLuaSprite(error, true)
    setProperty(error..'.scale.x',0.9)
    setProperty(error..'.scale.y',0.9)
    setProperty(error .. '.alpha', 0)
    setProperty(error .. '.offset.y', offsets.y)
    setProperty(error .. '.offset.x', offsets.x)
    doTweenAlpha(error .. 'Alpha', error, 1, 0.25)
    doTweenX(error..'ScaleX',error..'.scale',1,0.25)
    doTweenY(error..'ScaleY',error..'.scale',1,0.25)

    -- debugPrint('error ' .. error .. ' summoned')
end

function onUpdatePost()
    for i = 0, #errors do
        if (mouseHits(errors[i]) and mouseClicked()) then
            --debugPrint('error ' .. errors[i] .. ' clicked')
            -- removeLuaSprite(e)
            doTweenAlpha(errors[i] .. 'AlphaEnd', errors[i], 0, 0.25)
            doTweenX(errors[i]..'ScaleXEnd',errors[i]..'.scale',0.9,0.25)
            doTweenY(errors[i]..'ScaleYEnd',errors[i]..'.scale',0.9,0.25)
        end
    end
end

function onTweenCompleted(t)
    for i = 1, #errors do
        if (t == errors[i] .. 'AlphaEnd') then
            removeLuaSprite(errors[i])
            table.remove(errors, i)
        end
        local width = 500
        if(t == errors[i]..'ScaleX') then
            setProperty(errors[i] .. '.width', width)
        end
        if(t == errors[i]..'ScaleY') then
            setProperty(errors[i] .. '.width', width)
        end
    end
end

function onEvent(t, v1, v2)
    if (t == 'Start Errors') then
        summonError()
        canSummonErrors = true
    end
    if (t == 'Stop Errors') then
        canSummonErrors = false
    end
    if (t == 'Set Error Frequency') then
        errorFrequency = v1
    end
end

function onBeatHit()
    if (canSummonErrors) and (getRandomInt(1, errorFrequency) == 1) then
        summonError()
    end
end

function onCreate()
    setPropertyFromClass('flixel.FlxG', 'mouse.visible', true)
end

function lerp(a, b, t)
    return a * (1 - t) + b * t
end