package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.5'; // This is also used for Discord RPC
	public static var vs8bitVersion:String = '3.0.1a';
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	//private var bitboi:Character = null;

	var optionShit:Array<String> = [
		'story_mode',
		'freeplay',
		#if ACHIEVEMENTS_ALLOWED 'awards',
		#end
		'credits',
		'website',
		'options'
	];

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var debugKeys:Array<FlxKey>;

	var easterEggKeys:Array<String> = [
		//'MENTAL', 'DEATH', 'COPE', 'ACHIEVEMENT', 'DAKOTA', '2BIT', 'MAR31', 'IP', 'BUMBLEBEE', 'PICO'
		'MAR31', 'BUMBLEBEE', 'ACHIEVEMENT', 'DAKOTA'
	];
	var allowedKeys:String = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
	var easterEggKeysBuffer:String = '';

	var daImage:FlxSprite;
	override function create()
	{
		Conductor.changeBPM(102);
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement);
		FlxCamera.defaultCameras = [camGame];

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);
		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuBg'));
		bg.scrollFactor.set(0, yScroll);
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.scrollFactor.set(0, yScroll);
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = ClientPrefs.globalAntialiasing;
		magenta.color = 0xFFfd719b;
		add(magenta);
		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var scale:Float = 1.1;
		/*if(optionShit.length > 6) {
			scale = 6 / optionShit.length;
		}*/

		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite(0, (i * 140) + offset);
			menuItem.scale.x = scale;
			menuItem.scale.y = scale;
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			//	menuItem.screenCenter(X);
			menuItem.x = 100;
			menuItems.add(menuItem);
			menuItem.scrollFactor.set(0, (optionShit.length - 4) * 0.135);
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			// menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
			menuItem.updateHitbox();
		}

		FlxG.camera.follow(camFollowPos, null, 1);

		/*bitboi = new Character(1000, 250, '8bit', true);
		bitboi.scrollFactor.set(0, 0);
		add(bitboi);*/

		var versionShit:FlxText = new FlxText(12, FlxG.height - 64, 0, "VS. 8Bit v" + vs8bitVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat(Paths.font('vcr.ttf'), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat(Paths.font('vcr.ttf'), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat(Paths.font('vcr.ttf'), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();

		daImage = new FlxSprite(500);
		daImage.screenCenter(Y);
		daImage.y -= 500;
		daImage.scrollFactor.set();
		//add(daImage);

		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		#end

		super.create();
	}

	
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement(achievement)
	{
		#if ACHIEVEMENTS_ALLOWED
			add(new AchievementObject(achievement, camAchievement));
			FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
			trace('Giving achievement "$achievement"');
		#end
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		menuItems.forEach(function(spr:FlxSprite)
		{
			if (spr.ID != curSelected)
				spr.x = 100;
		});
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		if (!selectedSomethin)
		{
			if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == 'website')
				{
					CoolUtil.browserLoad('https://8bitjake.github.io');
					var achieveID:Int = Achievements.getAchievementIndex('shameless_plug');
					if (!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2]))
					{ // It's a friday night. WEEEEEEEEEEEEEEEEEE
						Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
						giveAchievement('shameless_plug');
						ClientPrefs.saveSettings();
					}
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					if (ClientPrefs.flashing)
						FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[curSelected];

								switch (daChoice)
								{
									case 'story_mode':
										MusicBeatState.switchState(new StoryMenuState());
									case 'freeplay':
										//MusicBeatState.switchState(new FreeplayState());
										MusicBeatState.switchState(new FreeplaySelectState());
									case 'awards':
										MusicBeatState.switchState(new AchievementsMenuState());
									case 'credits':
										MusicBeatState.switchState(new CreditsState());
									case 'options':
										MusicBeatState.switchState(new options.OptionsState());
								}
							});
						}
					});
				}
			}
			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		if (FlxG.keys.firstJustPressed() != FlxKey.NONE)
		{
			var keyPressed:FlxKey = FlxG.keys.firstJustPressed();
			var keyName:String = Std.string(keyPressed);
			switch (keyName)
			{
				case "ONE":
					keyName = '1';
				case "TWO":
					keyName = '2';
				case "THREE":
					keyName = '3';
				case "FOUR":
					keyName = '4';
				case "FIVE":
					keyName = '5';
				case "SIX":
					keyName = '6';
				case "SEVEN":
					keyName = '7';
				case "EIGHT":
					keyName = '8';
				case "NINE":
					keyName = '9';
				case "ZERO":
					keyName = '0';
			}

			trace('Key pressed: ' + keyName);
			if (allowedKeys.contains(keyName))
			{
				easterEggKeysBuffer += keyName;
				if (easterEggKeysBuffer.length >= 32)
					easterEggKeysBuffer = easterEggKeysBuffer.substring(1);
				// trace('Test! Allowed Key pressed!!! Buffer: ' + easterEggKeysBuffer);

				for (wordRaw in easterEggKeys)
				{
					var word:String = wordRaw.toUpperCase(); // just for being sure you're doing it right
					if (easterEggKeysBuffer.contains(word))
					{
						trace('YOOO! Easter Egg found! ' + word);
						easterEggKeysBuffer = '';
						var loadSong = function(song:String = 'nexto')
						{
							CoolUtil.difficulties = ['Hard'];
							PlayState.storyDifficulty = 0;
							PlayState.SONG = Song.loadFromJson(song + '-hard', Paths.formatToSongPath(song));
							PlayState.isStoryMode = false;
							LoadingState.loadAndSwitchState(new PlayState());
						}
						switch (word.toLowerCase())
						{
							case "mental":
								loadSong(word.toLowerCase());
							case "death":
								loadSong(word.toLowerCase());
							case "cope":
								loadSong(word.toLowerCase());
							case "achievement":
								var achieveID:Int = Achievements.getAchievementIndex('cringe');
								if (!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2]))
								{ // It's a friday night. WEEEEEEEEEEEEEEEEEE
									Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
									giveAchievement('cringe');
									ClientPrefs.saveSettings();
								}
							case "dakota":
								var achieveID:Int = Achievements.getAchievementIndex('dakota');
								if (!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2]))
								{ // It's a friday night. WEEEEEEEEEEEEEEEEEE
									Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
									giveAchievement('dakota');
									ClientPrefs.saveSettings();
								}
								CoolUtil.browserLoad('https://gamejolt.com/games/hi-8bitjake/683848');
							case "2bit":
								loadSong(word.toLowerCase());
							case "mar31":
								loadSong('nexto (Unused Mix)');
							case "ip":
								loadSong(word.toLowerCase());
							case "bumblebee":
								loadSong(word.toLowerCase());
							case "pico":
								loadSong('picobit');
						}
						break;
					}
				}
			}
		}

		super.update(elapsed);
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		daImage.loadGraphic(Paths.image('mainmenu/8bit/'+optionShit[curSelected]));

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			spr.updateHitbox();

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				FlxTween.tween(spr, {x: 400}, 0.5, {ease: FlxEase.quadOut});
				var add:Float = 0;
				if (menuItems.length > 4)
				{
					add = menuItems.length * 8;
				}
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y - add);
				spr.centerOffsets();
			}
		});
	}
}
