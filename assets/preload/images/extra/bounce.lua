local colors = {'262626','763800','149DFF','EE19D9'}
local i = 1;
local isLeft = false;
local beat = 0;
local step = 0;
function onCreate()
    if flashingLights then
	makeLuaSprite('flash', 'flash', 0, 0);
	defaultCamZoom = getProperty('defaultCamZoom') - 0.01;
	setProperty('flash.scale.x', 0.5 / defaultCamZoom * 50);
	setProperty('flash.scale.y', 0.5 / defaultCamZoom * 50);
	setProperty('flash.alpha', 0.0001);
	addLuaSprite('flash', true);
    end
end

function onBeatHit()
    beat = beat + 1;
    -- debugPrint('beat: ', beat);
   if beat >= (128 / 4) then
  -- debugPrint('camera shit |  camera rotation now: ', isLeft);
    isLeft = not isLeft;
    -- debugPrint('camera rotation now: ', isLeft);
    local dirNum = isLeft and -1 or 1;
    local daCalc = bpm * (0.00125 * 1.75);
    setProperty('camGame.angle', dirNum * -10);
    setProperty('camGame.y',dirNum * -100);
    doTweenAngle('camGameANGLE','camGame',0,daCalc,'circOut');
    doTweenY('camGameY','camGame',0,daCalc * 1.25,'circOut');
    setProperty('camHUD.angle', dirNum * 5);
    setProperty('camHUD.y',dirNum * 50);
    doTweenAngle('camANGLE','camHUD',0,daCalc,'circOut');
    doTweenY('camY','camHUD',0,daCalc * 1.25,'circOut');
    doTweenColor('flashCOLOR', 'flash', colors[i], 0.001, 'linear');
    setProperty('flash.alpha', 1);
    doTweenAlpha('tweenCutOffAlpha', 'flash', 0, 0.2, 'circOut');
    triggerEvent('Add Camera Zoom',0.1,0.05);
    i = i + 1;
    if (i > 4) then
        i = 1;
    end
  end
end

function onStepHit()
    step = step + 1;
    if step == 120 then
    doTweenY('camY','camHUD',50,0.8,'circIn');
    doTweenAngle('camANGLE','camHUD',5,0.8,'circIn');
    doTweenY('camGameY','camGame',-100,0.8,'circIn');
    doTweenAngle('camGameANGLE','camGame',-10,0.8,'circIn');
    doTweenZoom('camHudZoom','camHUD',getProperty('camHUD.zoom') + 0.05,0.8,'circIn');
    doTweenZoom('camGameZoom','camGame',getProperty('camGame.zoom') + 0.1,0.8,'circIn');
    end
end