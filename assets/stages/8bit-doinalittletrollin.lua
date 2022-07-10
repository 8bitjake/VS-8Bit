function onCreate()
	-- bg
	makeLuaSprite('bg', '8bitStage/sky', -200,-200);
	setLuaSpriteScrollFactor('bg', 0.1, 0.15);
	addLuaSprite('bg', false);
	setProperty('bg.antialiasing',false);
	-- dark grass
	makeLuaSprite('darkGrass', '8bitStage/background', -400,-275);
	setLuaSpriteScrollFactor('darkGrass', 0.5, 0.5);
	addLuaSprite('darkGrass', false);
	setProperty('darkGrass.antialiasing',false);
	-- foreground
	makeLuaSprite('grass', '8bitStage/ground', -400,-50);
	setLuaSpriteScrollFactor('grass', 1, 1);
	addLuaSprite('grass', false);
	setProperty('grass.antialiasing',false);
end