WinmovementAmount = 20;
Windowspeed = 0

function onCreate()
	Windowspeed = (60/bpm)
end

function onUpdatePost(elapsed)
    setPropertyFromClass("openfl.Lib", "application.window.y", (75 + (WinmovementAmount * math.cos(((getSongPosition() / 1000)*(bpm/60) * Windowspeed) * math.pi))*2))
    setPropertyFromClass("flixel.FlxG", "fullscreen", false)
   -- setPropertyFromClass("openfl.Lib", "application.window.title", '[object Object]')
end