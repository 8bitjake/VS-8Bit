function onBeatHit()
    if (curBeat >= 68 and curBeat < 326) then
        setTextSize('botplayTxt',22.5)
        setTextString('botplayTxt','this is the part where you thank me for forcing botplay on')
        local z = 0.18

        if(curBeat >= 133 and curBeat < 164) then
            z = z/(1.75*2)
        end

        triggerEvent('Add Camera Zoom',z/1.75,z)
      --  triggerEvent('Switch Scroll')
        local a = 6.25

        if(curBeat >= 261) then
            triggerEvent('Add Camera Zoom',(z*-2)/1.75,z*-2)
            setTextString('botplayTxt',"OH DANG")
            -- setTextSize('botplayTxt',80)
        end
        
        if(curBeat < 133 or curBeat >= 165) then
            if(curBeat % 2 == 1) then
                setProperty('camGame.angle',a)
                setProperty('camHUD.angle',-a)
            else
                setProperty('camGame.angle',-a)
                setProperty('camHUD.angle',a)
            end
            doTweenAngle('gameAngle','camGame',0,(60/bpm),'circOut')
            doTweenAngle('hudAngle','camHUD',0,(60/bpm),'circOut')
        else 
            setTextString('botplayTxt',"i'm not sure what to say, really")
        end

        if(curBeat >= 165 and curBeat < 261) then
            setTextString('botplayTxt',"oh dang")
            setTextSize('botplayTxt',40)
        end
    end
    if(curBeat >= 64 and curBeat < 68) then
        setTextSize('botplayTxt',30)
        setTextString('botplayTxt','get ready...')
    end
    if(curBeat == 326) then
        setTextSize('botplayTxt',40)
        setTextString('botplayTxt','...')
        doTweenAlpha('game','camGame',0,32.02,'linear')
        doTweenAlpha('hud','camHUD',0,32.02,'linear')
    end
    if(curBeat == 423) then
        setTextSize('botplayTxt',40)
        setTextString('botplayTxt','wait, what?')
        doTweenAlpha('game','camGame',1,1,'linear')
        doTweenAlpha('hud','camHUD',1,1,'linear')
    end
end

function onCreate()
    setProperty('cpuControlled',true)
    setProperty('botplayTxt.visible',true)
    setTextString('botplayTxt','botplay is forced on for the sake of your fingers, thank me in about 23 seconds from now')
    setTextSize('botplayTxt',22.5)
end