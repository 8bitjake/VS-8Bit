function onCreate()
    makeLuaText('txt', '', 1280, 0, screenHeight);
    setTextSize('txt', 25 * 1.5);
    addLuaText('txt');
end

function onEvent(name, value1, value2)
    if name == "Display Tutorial Text" then
        setTextString('txt', value1);
        doTweenY('txtYPos', 'txt', screenHeight - 100, 0.5, 'sineOut')
        runTimer('removeText', value2)
    end
end

function onTimerCompleted(t)
    if (t == 'removeText') then
        doTweenY('txtYPos', 'txt', screenHeight, 0.5, 'sineIn')
    end
end
