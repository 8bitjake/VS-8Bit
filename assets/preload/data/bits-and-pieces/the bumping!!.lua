local time = 0
local daDefault = 0
local toAngle = 5
function onBeatHit()
    if (curBeat % 2 == 0 and curBeat >= 32) then -- every other beat
        time = (60 / curBpm)
        setProperty('camGame.zoom', daDefault*1.05)
        doTweenZoom('camGameZoomYeah', 'camGame', daDefault*0.95, time, 'circOut')
        setProperty('camHUD.zoom', 1.05)
        setProperty('camHUD.y', 25)
        doTweenZoom('camHUDZoomYeah', 'camHUD', 0.9, time, 'circOut')
        doTweenY('camHUDYYeah', 'camHUD', 0, time, 'circOut')

        toAngle = -toAngle
        setProperty('camGame.angle', -toAngle)
        doTweenAngle('camGameAngleYeah', 'camGame', 0, time, 'circOut')
    end
end

function onUpdatePost()
    daDefault = getProperty('defaultCamZoom')
end

function onTweenCompleted(t)
    if (t == 'camGameZoomYeah') then
        doTweenZoom('camGameZoomYeah2', 'camGame', daDefault, time - 0.05, 'circIn')
    end
    if (t == 'camHUDZoomYeah') then
        doTweenZoom('camHUDZoomYeah2', 'camHUD', 1, time - 0.05, 'circIn')
    end
    if (t == 'camHUDYYeah') then
        doTweenY('camHUDYYeah2', 'camHUD', 25, time - 0.05, 'circIn')
    end
    if (t == 'camGameAngleYeah') then
        doTweenAngle('camGameAngleYeah2', 'camGame', toAngle, time - 0.05, 'circIn')
    end
end