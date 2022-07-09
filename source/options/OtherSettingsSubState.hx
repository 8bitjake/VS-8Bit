package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

using StringTools;

class OtherSettingsSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Other Settings';
		rpcTitle = 'Other Settings Menu'; //for Discord Rich Presence
		
		var option:Option = new Option('Old Instrumentals', //Name
			'Brings back the instrumentals from the legacy version.\nSimple enough.', //Description
			'oldSongs', //Save data variable name
			'bool', //Variable type
			false); //Default value
		addOption(option);

		var option:Option = new Option('Effects',
			'Toggles the cool visual effects.\nForced off if flashing lights are disabled.',
			'effects',
			'bool',
			ClientPrefs.flashing);
		addOption(option);

		super();
	}
}