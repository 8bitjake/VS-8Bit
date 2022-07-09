local itemToDisplay = 1
local hasStoppedDia = false
local allowCountdown = false
local char = {}
local isPlayingMusic = false
local iconScale = 2
local beat = 0

-- ⬇ CONFIG

local bgmBPM = { -- the bpm that each song uses. if not defined, **bad shit happens**
    _8bit = 102,
    shift = 100,
    foldery = 134
}

local credits = { -- if you do not put in credits i will murder your bloodline /j
    _8bit = {
        song = "Mauiwowi",
        author = "Alf42red"
    },
    shift = {
        song = "222",
        author = "Skiessi"
    },
    foldery = {
        song = "fider 5pm fuckn",
        author = "EnterThat575"
    }
}
local iconOffsets = { -- the icons look like shit without these *cough cough* shift key *cough cough*
    x = {
        _8bit = -30,
        bf = -30,
        gf = -38,
        shift = -50
    },
    y = {
        _8bit = 0,
        bf = -75,
        gf = -75,
        shift = -75
    }
}

local colors = { -- cool colors
    _8bit = '763800',
    shift = '2c2c2c',
    bf = '31b0d1',
    gf = 'a5004d',
    foldery = 'e8aa00'
}

local xOffsets = {
    _8bit = 150,
    shift = 400,
    foldery = 250
}

-- local forceBGM = {characters = {_8bit = "shift"},songs = {badassery = "8bit"}} -- if you want to play different music 
-- (CHARACTERS OVERRIDE SONGS.)
-- note from 8bit: this doesnt work piss piss shit fart

function onStartCountdown()
    -- Block the first countdown and start a timer of 0.8 seconds to play the dialogue	
    if not allowCountdown and not seenCutscene and isStoryMode then
        runTimer('boxAppears', 0.6)
        setProperty('inCutscene', true)
        setProperty('camHUD.visible', false)

        -- for i = 1, #dialogue do
        --	print(dialogue[i])
        -- end
        return Function_Stop
    end
    hasStoppedDia = true
    removeLuaSprite('box')
    removeLuaSprite('glassWhite')
    removeLuaSprite('glassBlack')
    removeLuaSprite('header')
    removeLuaSprite('icon')
    removeLuaText('dia')

    runTimer('close mf', 2)
    return Function_Continue
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'boxAppears' then -- Timer completed, play dialogue
        hasStoppedDia = false
        itemToDisplay = 1
        makeLuaText('dia', 'deez', 1125, 100, 515)
        setTextBorder('dia', 0, 0)
        setTextFont('dia', 'pixel.otf')
        setTextColor('dia', '0xFF000000')
        setTextSize('dia', 20)
        setTextAlignment('dia', 'left')
        setObjectCamera('dia', 'other')
        print('text initalized')
        getDialogueFromText(getProperty('dialogueNum'))

        makeAnimatedLuaSprite('box', 'speech_bubble', 50, 365)
        addAnimationByPrefix('box', 'appear', 'Speech Bubble Middle Open', 24, false)
        addAnimationByPrefix('box', 'idle', 'speech bubble middle')
        setObjectCamera('box', 'other')
        print('box initalized')

        makeLuaSprite('glassWhite', 'dialogue/glass/white', 0, 0)
        setObjectCamera('glassWhite', 'other')
        setProperty('glassWhite.alpha', 0.33)

        makeLuaSprite('glassBlack', 'dialogue/glass/black', 0, 0)
        setObjectCamera('glassBlack', 'other')
        setProperty('glassBlack.alpha', 0.1)

        makeLuaSprite('header', 'dialogue/header', 0.5, 0)
        setProperty('header.alpha', 0.75)
        setObjectCamera('header', 'other')

        setObjectOrder('glassWhite', 1)
        setObjectOrder('glassBlack', 2)
        setObjectOrder('header', 3)

        makeLuaSprite('icon', '?', 542.5, 197.5)
        setObjectCamera('icon', 'other')
        scaleObject('icon', iconScale, iconScale)

        print('dia dia dia dia dia')
        addLuaText('dia')
        addLuaSprite('box')
        objectPlayAnimation('box', 'appear')
        char = parseDialogueLine(dialogue[itemToDisplay])
        doDaFunnyCamera(char[1])
        runTimer('boxIdle', 0.1)
        if not isPlayingMusic then
            doFunnyCredits()
            -- debugPrint(dad)
            local dad = getProperty('dad.curCharacter') -- OH MY FUCKING GOD PLEASE WORK
            local musicToPlay = dad

            if (dad == "8bit") then
                dad = "_8bit"
            end

            --[[if(forceBGM["characters"][dad])then musicToPlay=forceBGM["characters"][dad]
			else if forceBGM["songs"][songName] then musicToPlay=forceBGM["songs"][songName]end

			-- if(not fileExists('music/'..musicToPlay))then musicToPlay = dad end
			-- the function didn't work]]

            musicToPlay = 'dialogue_' .. musicToPlay

            -- debugPrint(musicToPlay)
            playMusic(musicToPlay, 1, true)

            bgmBPM = bgmBPM[dad]
            soundFadeIn('', 2.5)
            isPlayingMusic = true
        end

        if (isPlayingMusic) then
            runTimer('beat', (60 / bgmBPM))
        end

        addLuaSprite('glassWhite')
        addLuaSprite('glassBlack')
        addLuaSprite('header')
        addLuaSprite('icon')
    end
    if tag == 'boxIdle' then
        objectPlayAnimation('box', 'idle')
        setProperty('box.offset.y', -40)
    end

    if tag == 'beat' then
        if (hasStoppedDia) then
            return
        end
        onBeatHit()
        runTimer('beat', (60 / bgmBPM))
    end

    if tag == 'creditsGoByeBye' then
        doTweenX('creditsX', 'credits', -500, (60 / bpm) * 2, 'circInOut')
        doTweenX('creditsTextX', 'creditsText', -500, (60 / bpm) * 2, 'circInOut')
        runTimer('deleteCredits', (60 / bpm) * 2)
    end

    if tag == 'deleteCredits' then
        removeLuaSprite('credits')
        removeLuaText('creditsText')
    end

    if tag == 'close mf' then
        close(true)
    end
end

function onBeatHit()
    local bumpValue = 0.12
    beat = beat + 1
    scaleObject('icon', iconScale + bumpValue, iconScale + bumpValue)
    doTweenX('iconScaleX', 'icon.scale', iconScale, (60 / bgmBPM), 'circOut')
    doTweenY('iconScaleY', 'icon.scale', iconScale, (60 / bgmBPM), 'circOut')
    characterDance('gf')

    if (beat % 2 == 0) then
        characterDance('dad')
        characterDance('boyfriend')
        objectPlayAnimation('bf', 'idle', false)
    end

    if (beat % 4 == 0) then
        local bumpValue = 0.12
        local oldGameZoom = getProperty('camGame.zoom')
        setProperty('camOther.zoom', getProperty('camOther.zoom') + bumpValue)
        doTweenZoom('camOtherZoom', 'camOther', 1, (60 / bgmBPM), 'circOut')
        setProperty('camGame.zoom', getProperty('camGame.zoom') + bumpValue / 2)
        doTweenZoom('camGameZoom', 'camGame', oldGameZoom, (60 / bgmBPM), 'circOut')
    end
end

function onUpdate()
    if (not hasStoppedDia) then
        char = parseDialogueLine(dialogue[itemToDisplay])

        if (dialogueLength >= itemToDisplay) then
            doDaFunnyCamera(parseDialogueLine(dialogue[itemToDisplay])[1])
        end
        --	print(char[1])

        if (not char[3]) then
            char[3] = char[1]
        end

        -- print(char[1])
        -- print(char[2])
        --	print(char[3])

        loadGraphic('icon', 'dialogue/icons/' .. char[3])

        if (char[3] == '8bit') then
            char[3] = '_8bit'
        end
        -- print(char[3])

        setProperty('icon.offset.y', iconOffsets["y"][char[3]])
        setProperty('icon.offset.x', iconOffsets["x"][char[3]])
        -- print(iconOffsets["y"][char[3]])
        -- print(iconOffsets["x"][char[3]])

        setProperty('header.color', getColorFromHex(colors[char[3]]))

        setTextString('dia', char[2])

        if (keyJustPressed('accept')) then
            playSound('clickText')
            itemToDisplay = itemToDisplay + 1
            if (itemToDisplay > dialogueLength) then
                endDialogue()
                return
            end
        end
    end
    -- end
end

function endDialogue()
    hasStoppedDia = true
    removeLuaText('dia')
    removeLuaSprite('box')
    removeLuaSprite('glassWhite')
    removeLuaSprite('glassBlack')
    removeLuaSprite('header')
    removeLuaSprite('icon')
    setProperty('camHUD.visible', true)

    allowCountdown = true

    if (songName == 'nexto' and getProperty('dialogueNum') < 2) then
        allowCountdown = false
        setProperty('dialogueNum', getProperty('dialogueNum') + 1)
        playSound('mic_drop')
        cameraShake('game', 0.0125, 1)
        -- onCreate()
    end

    startCountdown()
end

function doDaFunnyCamera(string)
    local stringToGoTo = string
    -- print('stringy: '..stringToGoTo)
    local dur = (60 / bpm) * 2.5
    dur = dur * 4
    -- print('dia:')
    --	print(hasStoppedDia)
    if (hasStoppedDia) then
        return
    end
    if (stringToGoTo == 'dad') then
        local omfg = getProperty('dad.curCharacter')
        if (omfg == "8bit") then
            omfg = "_8bit"
        end

        doTweenX('followX', 'camFollowPos', getProperty('dad.x') + xOffsets[omfg], dur, 'circOut')
        doTweenY('followY', 'camFollowPos', getProperty('dad.y') + 200, dur, 'circOut')
    else
        if (stringToGoTo == 'bf') then
            doTweenX('followX', 'camFollowPos', getProperty('boyfriend.x') + 150, dur, 'circOut')
            doTweenY('followY', 'camFollowPos', getProperty('boyfriend.y') + 150, dur, 'circOut')
        else
            if (stringToGoTo == 'gf') then
                doTweenX('followX', 'camFollowPos', getProperty('gf.x') + 100, dur, 'circOut')
                doTweenY('followY', 'camFollowPos', getProperty('gf.y') + 200, dur, 'circOut')
            end
        end
    end
end

function doFunnyCredits()
    makeLuaSprite('credits', 'dialogue/credits', -500, 0)
    setObjectCamera('credits', 'other')
    addLuaSprite('credits')

    -- debugPrint(credits["_8bit"]["song"],credits["_8bit"]["author"])
    -- debugPrint(credits["shift"]["song"],credits["shift"]["author"])

    local omfg = getProperty('dad.curCharacter')
    if (omfg == "8bit") then
        omfg = "_8bit"
    end
    -- debugPrint("please work ",omfg)

    makeLuaText('creditsText', 'Now Playing:\n\n' .. credits[omfg]["song"] .. '\nby ' .. credits[omfg]["author"], 1280,
        -500, 15)
    setTextBorder('creditsText', 0, 0)
    setObjectCamera('creditsText', 'other')
    setTextSize('creditsText', 27)
    setTextAlignment('creditsText', 'left')
    addLuaText('creditsText')

    doTweenX('creditsX', 'credits', 0, (60 / bpm) * 2, 'circInOut')
    doTweenX('creditsTextX', 'creditsText', 0, (60 / bpm) * 2, 'circInOut')

    runTimer('creditsGoByeBye', (60 / bpm) * 6)
end
