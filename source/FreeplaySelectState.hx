package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;

class FreeplaySelectState extends MusicBeatState
{
	var states:Array<String> = ['main', 'extra', 'joke'];
	var bg:FlxSprite = null;
	var mainSprite:FlxSprite = null;
	var selected:Int = 0;

	override function create()
	{
		super.create();

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		var scaleVal:Float = 2;
		bg = FlxGridOverlay.create(20, 20, Math.floor(FlxG.width * scaleVal), Math.floor(FlxG.height * scaleVal), true, 0xff438eb4, 0xffd9d5d5);
		add(bg);
		bg.x = 1;
		bg.y = 1;

		mainSprite = new FlxSprite();
		add(mainSprite);
	}

	var elapsedTime:Float = 0;

	override function update(elapsed:Float)
	{
		elapsedTime += elapsed;

		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}
		if (controls.BACK)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}

		super.update(elapsed);

		var move:Array<Float> = [0.25, 0.25];
		bg.x += move[0];
		bg.y += move[1];
		if (bg.x >= 0)
			bg.x = -200;
		if (bg.y >= 0)
			bg.y = -200;

		if (controls.UI_RIGHT_P)
		{
			selected += 1;
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}
		if (controls.UI_LEFT_P)
		{
			selected -= 1;
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}
		if (selected < 0)
			selected = states.length - 1;
		if (selected > states.length - 1)
			selected = 0;

		mainSprite.loadGraphic(Paths.image('freeplay/' + states[selected]));
		var scaleToSet:Float = 0.5;
		switch (states[selected])
		{
			case 'extra':
				scaleToSet = 0.35;
		}
		mainSprite.scale.set(scaleToSet, scaleToSet);
		mainSprite.screenCenter();
		mainSprite.y += (Math.sin(elapsedTime * 5)) * 20;

		if (controls.ACCEPT)
		{
			FreeplayState.state = states[selected];
			MusicBeatState.switchState(new FreeplayState());
		}
	}
}
