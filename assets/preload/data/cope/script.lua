local insults = {'cope','stay mad','stay bad','cringe','you fell off','ratio','idiot','bad','L','seethe','mald','cry','dilate',"don't care","didn't ask",'vouch',"you're cringe",'stay lame'}

function onCreate()
    makeLuaSprite('white','extra/copeHeader',0,0)
    setObjectCamera('white','other')
    addLuaSprite('white',true)
    makeLuaText('text',insults[1],1280,0,25)
    setObjectCamera('text','other')
    setTextSize('text',120)
    setTextColor('text','000000')
    setTextBorder('text',0.5,'000000')
    addLuaText('text')
end

function onStepHit()
    setTextString('text',insults[math.random(1,#insults)])
end