local dumbasses = {};
local arrayLength = 0;
function onCreate()
	-- bg
	makeLuaSprite('bg', '8bitStage/sky', -200,-200);
	setLuaSpriteScrollFactor('bg', 0.1, 0.15);
	addLuaSprite('bg', false);
	-- dark grass
	makeLuaSprite('darkGrass', '8bitStage/background', -400,-275);
	setLuaSpriteScrollFactor('darkGrass', 0.5, 0.5);
	addLuaSprite('darkGrass', false);
	-- middleground???
	makeLuaSprite('mg', '8bitStage/middleGround', -400,-75);
	setLuaSpriteScrollFactor('mg', 0.9, 0.9);
	addLuaSprite('mg', false);
	-- bg dudes
	createBackgroundBumper('shiftKey',350,512.5);
	createBackgroundBumper('foldery',600,525);
	-- foreground
	makeLuaSprite('grass', '8bitStage/ground', -400,-50);
	setLuaSpriteScrollFactor('grass', 1, 1);
	addLuaSprite('grass', false);
end

function createBackgroundBumper(name,x,y)
	makeAnimatedLuaSprite(name, '8bitStage/idiots/'..name, x,y);
    addAnimationByPrefix(name,'idle',name,24,false);
	setLuaSpriteScrollFactor(name, 0.95, 0.95); 
	addLuaSprite(name, false);
    table.insert(dumbasses,name);
	arrayLength = arrayLength + 1;
end

function onBeatHit()
	for i = 0, arrayLength do
        objectPlayAnimation(dumbasses[i],'idle',true);
	end
end

function onCountdownTick(counter)
	onBeatHit();
end