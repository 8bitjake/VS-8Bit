function onCreate()
    local coolZoom = function(zoomLevel,spb)
            doTweenZoom('coolZoomGame','camGame',2,spb,'circInOut')
            doTweenZoom('coolZoomHUD','camHUD',2,spb,'circInOut')
        end

    addBeatEvent(7,function(beat,spb)
        local tweenTo = 360
        doTweenAngle('camHUDAngle','camHUD',-tweenTo,spb*2,'circOut')
        doTweenAngle('camGameAngle','camGame',tweenTo,spb*2,'circOut')
    end)

    addBeatEvent(9,function(beat,spb)
        local newY = 300
        setProperty('camGame.y',newY)
        setProperty('camHUD.y',-newY)
        doTweenY('camGameY','camGame',0,spb*2,'circOut')
        doTweenY('camHUDY','camHUD',0,spb*2,'circOut')
    end)

    addStepEvent(10.5*4,function(beat,sps)
        coolZoom(2,sps*4)
    end)

    local newY = 75/2
    addStepEvent(50,function(beat,sps)
        doTweenY('camGameY','camGame',newY,sps*4,'circInOut')
        doTweenY('camHUDY','camHUD',-newY,sps*4,'circInOut')
    end)

    addStepEvent(53,function(beat,sps)
        doTweenY('camGameY','camGame',-newY,sps*4,'circInOut')
        doTweenY('camHUDY','camHUD',newY,sps*4,'circInOut')
    end)

    local shakeLength = 0.43
    local shakeAmount = 0.025

    addStepEvent(58,function(beat,sps)
        doTweenY('camGameY','camGame',0,sps*4,'circInOut')
        doTweenY('camHUDY','camHUD',0,sps*4,'circInOut')

        cameraShake('game',shakeAmount,shakeLength)
        cameraShake('hud',shakeAmount*0.1,shakeLength)
    end)

    addStepEvent(64,function(beat,sps)
        doTweenY('camGameY','camGame',newY,sps*4,'circInOut')
        doTweenY('camHUDY','camHUD',-newY,sps*4,'circInOut')
    end)

    addStepEvent(68,function(beat,sps)
        doTweenY('camGameY','camGame',-newY,sps*4,'circInOut')
        doTweenY('camHUDY','camHUD',newY,sps*4,'circInOut')
    end)

    addBeatEvent(18,function(beat,spb)
        doTweenY('camGameY','camGame',0,spb,'circInOut')
        doTweenY('camHUDY','camHUD',0,spb,'circInOut')

        local newX = 75
        doTweenX('camGameX','camGame',newX,spb,'circInOut')
        doTweenX('camHUDX','camHUD',-newX,spb,'circInOut')
    end)

    addBeatEvent(19,function(beat,spb)
        local newX = 75
        doTweenX('camGameX','camGame',-newX,spb,'circInOut')
        doTweenX('camHUDX','camHUD',newX,spb,'circInOut')
    end)

    addBeatEvent(20,function(beat,spb)
        doTweenX('camGameX','camGame',0,spb,'circInOut')
        doTweenX('camHUDX','camHUD',0,spb,'circInOut')
    end)

    addBeatEvent(22,function(beat,spb)
       coolZoom(2,spb)
    end)

    addBeatEvent(26,function(beat,spb)
       coolZoom(2,spb)
    end)

    addBeatEvent(30,function(beat,spb)
       coolZoom(2,spb)
    end)

end

local beatEvents = {}
local stepEvents = {}

local debugMode = false -- if true, will print out debug info

function addBeatEvent(beat,func) -- `beat` is the beat number, `func` is the function to be called
    beatEvents['event'..beat] = {f = func,step = beat*4}
    if(debugMode) then debugPrint('Added beat event: '..beat) end
end

function addStepEvent(step,func) -- `step` is the step number, `func` is the function to be called
    stepEvents['event'..step] = {f = func,step = step}
    if(debugMode) then debugPrint('Added step event: '..step) end
end

--function addEventOnEveryBeat(beats,func)
  --  activeBeatEvents[#activeBeatEvents+1] = {firstBeat = beats[1],lastBeat = beats[2],f = func}
 --   if(debugMode) then
 --       debugPrint('Added events from '..beats[1]..' to '..beats[2])
  --  end
--end

function onBeatHit()
    beatEvents['event'..curBeat].f(curBeat,getPropertyFromClass('Conductor','crochet')/1000)
end

function onStepHit()
    stepEvents['event'..curStep].f(curStep,getPropertyFromClass('Conductor','stepCrochet')/1000)
end

function onTweenCompleted(tag)
    local spb = getPropertyFromClass('Conductor','crochet')/1000
    if(tag == 'coolZoomGame') then
        doTweenZoom('coolZoomGame2','camGame',1,spb,'circInOut')
    end
    if(tag == 'coolZoomHUD') then
        doTweenZoom('coolZoomHUD2','camHUD',1,spb,'circInOut')
    end
end