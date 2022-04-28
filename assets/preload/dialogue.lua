local itemToDisplay = 1
local hasStoppedDia = false
local allowCountdown = false
local char = {}
local isPlayingMusic = false
local bgmBPM = 102
local iconScale = 1.5
local iconOffsets = {x = {_8bit = -30,bf = -30,gf = -38},y = {_8bit = 0,bf = -75,gf = -75}}

function onCreate()
	hasStoppedDia = false
	itemToDisplay = 1
	makeLuaText('dia','deez',1125,100,515)
	setTextBorder('dia',0,0)
	setTextFont('dia','pixel.otf')
	setTextColor('dia','0xFF000000')
	setTextSize('dia',20)
	setTextAlignment('dia','left')
	setObjectCamera('dia','other')
	print('text initalized')
	getDialogueFromText(getProperty('dialogueNum'));

	makeAnimatedLuaSprite('box','speech_bubble',50,365)
	addAnimationByPrefix('box','appear','Speech Bubble Middle Open',24,false)
	addAnimationByPrefix('box','idle','speech bubble middle')
	setObjectCamera('box','other')
	print('box initalized')

	makeLuaSprite('glassWhite','dialogue/newDialogue/glass/white',0,0)
	setObjectCamera('glassWhite','other')
	setProperty('glassWhite.alpha',0.33)
	
	makeLuaSprite('glassBlack','dialogue/newDialogue/glass/black',0,0)
	setObjectCamera('glassBlack','other')
	setProperty('glassBlack.alpha',0.1)

	

	makeLuaSprite('header','dialogue/newDialogue/header',0.5,0)
	setObjectCamera('header','other')

	setObjectOrder('glassWhite',1)
	setObjectOrder('glassBlack',2)
	setObjectOrder('header',3)

	makeLuaSprite('icon','?',542.5,197.5)
	setObjectCamera('icon','other')
	scaleObject('icon',iconScale,iconScale)
end

function onStartCountdown()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue	
	if not allowCountdown and not seenCutscene and isStoryMode then
		runTimer('boxAppears', 0.6)
		setProperty('inCutscene',true)
		setProperty('camHUD.visible',false)

		--for i = 1, #dialogue do
		--	print(dialogue[i])
		--end

		if(not songName == 'puddles') then addLuaScript('fixTheArrowThing') end
		return Function_Stop;
	end
	hasStoppedDia = true
	removeLuaSprite('box')
	removeLuaSprite('glassWhite')
	removeLuaSprite('glassBlack')
	removeLuaSprite('header')
	removeLuaSprite('icon')
	removeLuaText('dia')
	return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'boxAppears' then -- Timer completed, play dialogue
		print('dia dia dia dia dia')
		addLuaText('dia')
		addLuaSprite('box')
		objectPlayAnimation('box','appear')
		char = parseDialogueLine(dialogue[itemToDisplay])
		doDaFunnyCamera(char[1])
		runTimer('boxIdle', 0.1)
		if not isPlayingMusic then
			doFunnyCredits()
			playMusic('dialogue_8bit',1,true)
			soundFadeIn('',2.5)
			isPlayingMusic = true
			runTimer('bop',(60/bgmBPM)*4)
			runTimer('iconBop',(60/bgmBPM))
			runTimer('characterDance',(60/bgmBPM)*2)
		end
		addLuaSprite('glassWhite')
		addLuaSprite('glassBlack')
		addLuaSprite('header')
		addLuaSprite('icon')
	end
	if tag == 'boxIdle' then
		objectPlayAnimation('box','idle')
		setProperty('box.offset.y',-40)
	end

	if tag == 'bop' then
		if(hasStoppedDia) then return; end
		local bumpValue = 0.12
		setProperty('camOther.zoom',getProperty('camOther.zoom')+bumpValue)
		doTweenZoom('camOtherZoom','camOther',1,(60/bgmBPM),'circOut')
		setProperty('camGame.zoom',getProperty('camGame.zoom')+bumpValue/2)
		doTweenZoom('camGameZoom','camGame',1,(60/bgmBPM),'circOut')
		runTimer('bop',(60/bgmBPM)*4)
	end

	if tag == 'iconBop' then
		if(hasStoppedDia) then return; end
		local bumpValue = 0.12
		scaleObject('icon',iconScale+bumpValue,iconScale+bumpValue)
		doTweenX('iconScaleX','icon.scale',iconScale,(60/bgmBPM),'circOut')
		doTweenY('iconScaleY','icon.scale',iconScale,(60/bgmBPM),'circOut')
		runTimer('iconBop',(60/bgmBPM))
		characterDance('gf')
	end

	if tag == 'characterDance' then
		if(hasStoppedDia) then return; end
		characterDance('dad')
		characterDance('boyfriend')
		runTimer('characterDance',(60/bgmBPM)*2)
	end

	if tag == 'creditsGoByeBye' then
		doTweenX('creditsX','credits',-500,(60/bpm)*2,'circInOut')
		doTweenX('creditsTextX','creditsText',-500,(60/bpm)*2,'circInOut')
		runTimer('deleteCredits',(60/bpm)*2)
	end

	if tag == 'deleteCredits' then
		removeLuaSprite('credits')
		removeLuaText('creditsText')
	end
end

function onUpdate()
	if(not hasStoppedDia) then
		char = parseDialogueLine(dialogue[itemToDisplay])

		if(dialogueLength >= itemToDisplay) then
			doDaFunnyCamera(parseDialogueLine(dialogue[itemToDisplay])[1])
		end
		--	print(char[1])

		if(not char[3]) then
			char[3] = char[1]
		end

		--print(char[1])
		--print(char[2])
	--	print(char[3])

		loadGraphic('icon','dialogue/newDialogue/icons/'..char[3])

		if(char[3] == '8bit')then char[3] = '_8bit' end

		setProperty('icon.offset.y',iconOffsets["y"][char[3]])
		setProperty('icon.offset.x',iconOffsets["x"][char[3]])
		
		setTextString('dia',char[2])
		if(keyJustPressed('accept')) then
			playSound('clickText')
			itemToDisplay = itemToDisplay + 1
			if(itemToDisplay > dialogueLength) then
				endDialogue()
				return;
			end
		end
		end
end

function endDialogue()
	hasStoppedDia = true
	removeLuaText('dia')
	removeLuaSprite('box')
	removeLuaSprite('glassWhite')
	removeLuaSprite('glassBlack')
	removeLuaSprite('header')
	removeLuaSprite('icon')
	setProperty('camHUD.visible',true)

	allowCountdown = true;

	if(songName == 'nexto' and getProperty('dialogueNum') < 2) then
		allowCountdown = false;
		setProperty('dialogueNum',getProperty('dialogueNum') + 1)
		playSound('mic_drop')
		cameraShake('game',0.0125,1)
		onCreate()
	end
	
	startCountdown()
end

function doDaFunnyCamera(string)
	local stringToGoTo = string
	--print('stringy: '..stringToGoTo)
	local dur = (60/bpm)*2.5
	dur = dur*4
	--print('dia:')
	--	print(hasStoppedDia)
	if(hasStoppedDia) then return; end
	if(stringToGoTo == 'dad') then
		doTweenX('followX','camFollowPos',getProperty('dad.x')+80,dur,'circOut')
		doTweenY('followY','camFollowPos',getProperty('dad.y')+100,dur,'circOut')
	else if(stringToGoTo == 'bf') then
		doTweenX('followX','camFollowPos',getProperty('boyfriend.x')+150,dur,'circOut')
		doTweenY('followY','camFollowPos',getProperty('boyfriend.y')+150,dur,'circOut')
	else if(stringToGoTo == 'gf') then
		doTweenX('followX','camFollowPos',getProperty('gf.x')+100,dur,'circOut')
		doTweenY('followY','camFollowPos',getProperty('gf.y')+200,dur,'circOut')
	end
	end
end
end

function doFunnyCredits()
	makeLuaSprite('credits','dialogue/newDialogue/credits',-500,0)
	setObjectCamera('credits','other')
	addLuaSprite('credits')

	makeLuaText('creditsText','Now Playing:\n\nAlf42red-Mauiwowi\nby Armin Heller',1280,-500,15)
	setTextBorder('creditsText',0,0)
	setObjectCamera('creditsText','other')
	setTextSize('creditsText',27)
	setTextAlignment('creditsText','left')
	addLuaText('creditsText')

	doTweenX('creditsX','credits',0,(60/bpm)*2,'circInOut')
	doTweenX('creditsTextX','creditsText',0,(60/bpm)*2,'circInOut')
	
	runTimer('creditsGoByeBye',(60/bpm)*8)
end