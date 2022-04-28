function onCreate()
    -- bg
    makeLuaSprite('bg','bg',-100,-100)
    setLuaSpriteScrollFactor('bg',0,0.15)
    addLuaSprite('bg',false)
    debugPrint('bg created')

    -- folders

    makeLuaSprite('folders','folders',-100,-275)
    setLuaSpriteScrollFactor('folders',0.5,0.5)
    addLuaSprite('folders',false)
    debugPrint('folders created')

    -- ground

    makeLuaSprite('ground','ground',0,0)
    setLuaSpriteScrollFactor('ground',0,1)
    addLuaSprite('ground',false)
    debugPrint('ground created')
end