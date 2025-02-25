package states.stages;

import states.stages.objects.*;
import backend.Song;
import flixel.ui.FlxBar;

class BackroomLevelZero extends BaseStage
{
	var screenhurt:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('WrongArea/HurtScreen'));
	var screenStatics:FlxSprite = new FlxSprite(0, 0);
	var bfEntity:FlxSprite = new FlxSprite(0, 0);
	var hearts:FlxSprite = new FlxSprite(50, 40);
	var heartStart:FlxSprite = new FlxSprite(70, 120);
	var vignette:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('Custom_UI/Vignette_Screen'));
	var randomizeSymbols:FlxSprite = new FlxSprite(1142, 580);
	var badLuckSymbols:FlxSprite = new FlxSprite(1142, 580);

	var tvStaticSound:FlxSound;
	var heartbeatSound:FlxSound;
	var techJamSound:FlxSound;
	var mwahSound:FlxSound;
	var randomCountDownSound:FlxSound;

	// Key buttons
	var keyButtons:FlxSprite = new FlxSprite(0, 0);
	var spaceBarButton:FlxSprite = new FlxSprite(0, 0);
	var appearGlow:FlxSprite = new FlxSprite(0, 80);
	var warningSpaceGlow:FlxSprite = new FlxSprite(120, 40);
	var warningGlow:FlxSprite = new FlxSprite(0, 50);
	var randomizerNum:Float = 0;
	var randomButtom:Float = 1;
	var testStop:Bool = false;
  
	// FlxTimer not working, i tried. :C
	var timerRandomNum:Float = 20;
	var timerEMPNum:Float = 13;

	var farDis:Float;
	var closeDis:Float;
	var jumpDis:Float;
	var monSpeedMissDis:Float;
	var monSpeedBadDis:Float;
	var stunStruggle:Float;

	var JSActive:Bool = false;
	var dodgeBF:Bool = false;
	var pressedDodge:Bool = true;
	var heartActive:Bool = false;
	var gotStunned:Bool = false;
	var arrowCorrupt:Bool = false;
	var glitchHUDActive:Bool = false;

	var tvActive:Bool = false;
	var stayAliveDebug:Bool = false;
	var AwarenessBFEntity:Bool = false;

	var swapHealth:Bool = false;
	var swapHealthActive:Bool = false;
	var bleedHealth:Bool = false;
	var shortHealthInc:Bool = false;

	var curStage:String = '';
	var SONG:SwagSong;
	var storyWeek:Int = 0;
	var storyPlaylist:Array<String> = [];
	var storyDifficulty:Int = 1;
	var weekSong:Int = 0;
	var shits:Int = 0;
	var bads:Int = 0;
	var goods:Int = 0;
	var sicks:Int = 0;

	var songPosBG:FlxSprite;
	var songPosBar:FlxBar;

	var loadRep:Bool = false;

	var halloweenLevel:Bool = false;
	override function create()
	{
			var behindLevel0 :FlxSprite = new FlxSprite(60, 125).loadGraphic(Paths.image('WrongArea/TheBackroomLevel0_Background3'));
			behindLevel0.antialiasing = true;
			behindLevel0.setGraphicSize(Std.int(behindLevel0.width * 1.65));
			add(behindLevel0);

			var backLevel0 :FlxSprite = new FlxSprite(60, 125).loadGraphic(Paths.image('WrongArea/TheBackroomLevel0_Background2'));
			backLevel0.antialiasing = true;
			backLevel0.setGraphicSize(Std.int(backLevel0.width * 1.65));
			add(backLevel0);

			var frontLevel0 :FlxSprite = new FlxSprite(60, 125).loadGraphic(Paths.image('WrongArea/TheBackroomLevel0_Background1'));
			frontLevel0.antialiasing = true;
			frontLevel0.setGraphicSize(Std.int(frontLevel0.width * 1.65));
			add(frontLevel0);
    
    if (SONG.song.toLowerCase() == 'merriment' || SONG.song.toLowerCase() == 'games' || SONG.song.toLowerCase() == 'jovial')
		{
			entityBFMonster();
			vignette.setGraphicSize(Std.int(hearts.width * 2.15));
			vignette.color = FlxColor.PINK;
			if (bfEntity.x <= jumpDis)
			{
				JSActive = true;
			}
		}
	}

	// some custom below

	function entityBFMonster():Void // a kiler
	{
		if (!swapHealth && healthBar.percent < 45 || swapHealth == true && healthBar.percent > 64)
		{
			tvActive = true;
			screenStatics.animation.play('tvCorrupt');
			bfEntity.alpha = randomRangeFloat(0.4, 0.8);
		}
		if (!swapHealth && healthBar.percent > 46 || swapHealth == true && healthBar.percent < 65)
		{
			tvActive = false;
			screenStatics.alpha -= 0.025;
			screenStatics.animation.play('tvCorrupt');
			tvStaticSound.volume -= 0.025;
			bfEntity.x += 10;
			bfEntity.alpha -= 0.05;
		}
		if (bfEntity.x < closeDis)
		{
			bfEntity.animation.play('close');
		}
		if (bfEntity.x > farDis)
		{
			bfEntity.x = farDis;
			bfEntity.animation.play('far');
		}
		if (screenStatics.alpha > 0.35)
		{
			bfEntity.x -= 0.435;
		}
		if (screenStatics.alpha > 0.55)
		{
			screenStatics.alpha = 0.5;
		}
		if (SONG.song.toLowerCase() == 'tutorial')
		{
			bfEntity.kill();
			screenStatics.kill();
			tvStaticSound.stop();
			bfEntity.x += 9999;
		}
	}
}
