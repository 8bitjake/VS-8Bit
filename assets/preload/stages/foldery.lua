function onCreate()
    addLuaScript('foldery/scripts/errorHandler')
    -- bg
    makeLuaSprite('bg', 'bg', -800, -800)
    scaleObject('bg', 2, 2)
    setLuaSpriteScrollFactor('bg', 0, 0)
    addLuaSprite('bg', false)
    -- debugPrint('bg created')

    -- ground
    makeLuaSprite('ground', null, 0, 750)
    makeGraphic('ground', screenWidth * 2, screenHeight, 'd09800')
    screenCenter('ground', 'x')
    setLuaSpriteScrollFactor('ground', 0, 1)
    addLuaSprite('ground', false)
    -- debugPrint('ground created')

    setProperty('skipCountdown', true)
end
