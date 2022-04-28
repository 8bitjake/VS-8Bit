-- script by ItsCapp don't steal, it's dumb

-- simply, offsets. they're the numbers in the top left of the character editor
idleoffsets = {'-5', '0'} -- I recommend you have your idle offset at 0
leftoffsets = {'5', '-6'}
downoffsets = {'-10', '-50'}
upoffsets = {'-29', '27'}
rightoffsets = {'-48', '-7'}
leftmissoffsets = {'7','19'}
downmissoffsets = {'-15','-19'}
upmissoffsets = {'-36', '27'}
rightmissoffsets = {'-44', '22'}

-- change all of these to the name of the animation in your character's xml file
idle_xml_name = 'BF idle dance'
left_xml_name = 'BF NOTE LEFT0'
down_xml_name = 'BF NOTE DOWN0'
up_xml_name = 'BF NOTE UP0'
right_xml_name = 'BF NOTE RIGHT0'
left_miss_xml_name = 'BF NOTE LEFT MISS'
down_miss_xml_name = 'BF NOTE DOWN MISS'
up_miss_xml_name = 'BF NOTE UP MISS'
right_miss_xml_name = 'BF NOTE RIGHT MISS'

-- basically horizontal and vertical positions
x_position = 1000
y_position = 500

-- pretty self-explanitory
name_of_character_xml = 'BOYFRIEND'
name_of_character = 'bf'
name_of_notetype = 'No Animation'

-- if it's set to true the character appears behind the default characters, including gf, watch out for that
foreground = true
playablecharacter = false -- change to 'true' if you want to flipX

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function onCreate()
	makeAnimatedLuaSprite(name_of_character, 'characters/' .. name_of_character_xml, x_position, y_position);

	addAnimationByPrefix(name_of_character, 'idle', idle_xml_name, 24, false);
	addAnimationByPrefix(name_of_character, 'singLEFT', left_xml_name, 24, false);
	addAnimationByPrefix(name_of_character, 'singDOWN', down_xml_name, 24, false);
	addAnimationByPrefix(name_of_character, 'singUP', up_xml_name, 24, false);
	addAnimationByPrefix(name_of_character, 'singRIGHT', right_xml_name, 24, false);
	addAnimationByPrefix(name_of_character, 'singLEFTmiss', left_miss_xml_name, 24, false);
	addAnimationByPrefix(name_of_character, 'singDOWNmiss', down_miss_xml_name, 24, false);
	addAnimationByPrefix(name_of_character, 'singUPmiss', up_miss_xml_name, 24, false);
	addAnimationByPrefix(name_of_character, 'singRIGHTmiss', right_miss_xml_name, 24, false);
	
	if playablecharacter == true then
		setPropertyLuaSprite(name_of_character, 'flipX', true);
	else
		setPropertyLuaSprite(name_of_character, 'flipX', false);
	end


	objectPlayAnimation(name_of_character, 'idle');
	addLuaSprite(name_of_character, foreground);
end

local singAnims = {"singLEFT", "singDOWN", "singUP", "singRIGHT"}
function opponentNoteHit(id, direction, noteType, isSustainNote)
	if noteType == name_of_notetype then
		objectPlayAnimation(name_of_character, singAnims[direction + 1], false);

		if direction == 0 then
			setProperty(name_of_character .. '.offset.x', leftoffsets[1]);
			setProperty(name_of_character .. '.offset.y', leftoffsets[2]);
		elseif direction == 1 then
			setProperty(name_of_character .. '.offset.x', downoffsets[1]);
			setProperty(name_of_character .. '.offset.y', downoffsets[2]);
		elseif direction == 2 then
			setProperty(name_of_character .. '.offset.x', upoffsets[1]);
			setProperty(name_of_character .. '.offset.y', upoffsets[2]);
		elseif direction == 3 then
			setProperty(name_of_character .. '.offset.x', rightoffsets[1]);
			setProperty(name_of_character .. '.offset.y', rightoffsets[2]);
		end
	end
end

-- I know this is messy, but it's the only way I know to make it work on both sides.
local singAnims = {"singLEFT", "singDOWN", "singUP", "singRIGHT"}
function goodNoteHit(id, direction, noteType, isSustainNote)
	if noteType == name_of_notetype then
		objectPlayAnimation(name_of_character, singAnims[direction + 1], true);

		if direction == 0 then
			setProperty(name_of_character .. '.offset.x', leftoffsets[1]);
			setProperty(name_of_character .. '.offset.y', leftoffsets[2]);
		elseif direction == 1 then
			setProperty(name_of_character .. '.offset.x', downoffsets[1]);
			setProperty(name_of_character .. '.offset.y', downoffsets[2]);
		elseif direction == 2 then
			setProperty(name_of_character .. '.offset.x', upoffsets[1]);
			setProperty(name_of_character .. '.offset.y', upoffsets[2]);
		elseif direction == 3 then
			setProperty(name_of_character .. '.offset.x', rightoffsets[1]);
			setProperty(name_of_character .. '.offset.y', rightoffsets[2]);
		end
	end
end
function noteMiss(id, direction, noteType, isSustainNote)
	if noteType == name_of_notetype then
		objectPlayAnimation(name_of_character, singAnims[direction + 1]..'miss', true);

		if direction == 0 then
			setProperty(name_of_character .. '.offset.x', leftmissoffsets[1]);
			setProperty(name_of_character .. '.offset.y', leftmissoffsets[2]);
		elseif direction == 1 then
			setProperty(name_of_character .. '.offset.x', downmissoffsets[1]);
			setProperty(name_of_character .. '.offset.y', downmissoffsets[2]);
		elseif direction == 2 then
			setProperty(name_of_character .. '.offset.x', upmissoffsets[1]);
			setProperty(name_of_character .. '.offset.y', upmissoffsets[2]);
		elseif direction == 3 then
			setProperty(name_of_character .. '.offset.x', rightmissoffsets[1]);
			setProperty(name_of_character .. '.offset.y', rightmissoffsets[2]);
		end
	end
end

function onBeatHit()
	-- triggered 4 times per section
	if curBeat % 2 == 0 then
		objectPlayAnimation(name_of_character, 'idle');
		setProperty(name_of_character .. '.offset.x', idleoffsets[1]);
		setProperty(name_of_character .. '.offset.y', idleoffsets[2]);
	end
end

function onCountdownTick(counter)
	-- counter = 0 -> "Three"
	-- counter = 1 -> "Two"
	-- counter = 2 -> "One"
	-- counter = 3 -> "Go!"
	-- counter = 4 -> Nothing happens lol, tho it is triggered at the same time as onSongStart i think
	if counter % 2 == 0 then
		objectPlayAnimation(name_of_character, 'idle');
		setProperty(name_of_character .. '.offset.x', idleoffsets[1]);
		setProperty(name_of_character .. '.offset.y', idleoffsets[2]);
	end
end