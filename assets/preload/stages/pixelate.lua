local squish = 80
function onCreate()
    makeLuaSprite('bg','PIXEL_BG',-550,-500)
    scaleObject('bg',7,7)
    setProperty('bg.antialiasing',false)
    addLuaSprite('bg',false)
    addVCREffect('camGame')
    addVCREffect('camHUD')
    --debugPrint('bg done')

    makeLuaSprite('bars','PIXEL_BARS',0,0)
	addLuaSprite('bars',true)
    setLuaSpriteScrollFactor('bars',160,90)
    scaleObject('bars',4,4)
	setObjectCamera('bars','camOther')

    setObjectOrder('bars',0)
end

function onCreatePost()
    if not middlescroll then
		noteTweenX('1',1,defaultOpponentStrumX1+squish,0.01,'linear')
		noteTweenX('2',2,defaultOpponentStrumX2+squish,0.01,'linear')
		noteTweenX('3',3,defaultOpponentStrumX3+squish,0.01,'linear')
		noteTweenX('4',4,defaultPlayerStrumX0-squish,0.01,'linear')
		noteTweenX('5',5,defaultPlayerStrumX1-squish,0.01,'linear')
		noteTweenX('6',6,defaultPlayerStrumX2-squish,0.01,'linear')
		noteTweenX('7',7,defaultPlayerStrumX3-squish,0.01,'linear')
	end
    --setPropertyFromClass('flixel.FlxG','drawFramerate',30)

    setTextFont('botplayTxt','pixel.otf')
    setTextSize('botplayTxt',getTextSize('botplayTxt')/1.5)
    
    setTextFont('scoreTxt','pixel.otf')
    setTextSize('scoreTxt',getTextSize('scoreTxt')/1.5)

    setTextFont('timeTxt','pixel.otf')
    setTextSize('timeTxt',getTextSize('timeTxt')/1.5)

    setTextFont('song','pixel.otf')
    setTextSize('song',getTextSize('song')/1.5)
end

function onUpdate()
    triggerEvent('Camera Follow Pos',600,400)
    local strumX = getPropertyFromGroup('opponentStrums',0,'x')
    if(strumX < defaultOpponentStrumX0+squish)then
        setPropertyFromGroup('opponentStrums',0,'x',strumX+squish)
    end
end

function onDestroy()
    --setPropertyFromClass('flixel.FlxG','drawFramerate',getPropertyFromClass('ClientPrefs','framerate'))
end