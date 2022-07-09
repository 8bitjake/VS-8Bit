local ratios = {"you fell off","cringe","didn't ask","don't care","fuck you","play vs silas","motherfucker","ploopy (real)","you suck","no bitches","ah hell nah"}
local fakeBPM = 205.5
local step = 0
local fakeStepTime = (60/fakeBPM)/4
function onCreate()
    makeLuaSprite('white','extra/copeHeader',0,0)
    setObjectCamera('white','other')
    addLuaSprite('white',true)
    makeLuaText('text',"ratio",1280,0,25)
    setObjectCamera('text','other')
    setTextSize('text',120)
    setTextColor('text','000000')
    setTextBorder('text',0.5,'000000')
    addLuaText('text')
end

function onSongStart()
    runTimer('fakeStep',fakeStepTime)
end

function fakeStepHit()
    local stepRatio = 8
    if(step % stepRatio == stepRatio/2)then
        setTextString('text','+')
    else
        if (step % stepRatio == 0)then
            setTextString('text',ratios[math.random(1,#ratios)])
        end
    end
end

function onTimerCompleted(tag)
    if(tag == 'fakeStep')then
        if(step >= 20)then
            fakeStepHit()
        end
        step = step + 1
        runTimer('fakeStep',fakeStepTime)
    end
end