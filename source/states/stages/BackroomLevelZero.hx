package states.stages;

import states.stages.objects.*;

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

	override function createPost()
	{
		// Use this function to layer things above characters!
	}

	override function update(elapsed:Float)
	{
		// Code here
	}

	override function destroy()
	{
		// Code here
	}

	
	override function countdownTick(count:Countdown, num:Int)
	{
		switch(count)
		{
			case THREE: //num 0
			case TWO: //num 1
			case ONE: //num 2
			case GO: //num 3
			case START: //num 4
		}
	}

	override function startSong()
	{
		// Code here
	}

	// Steps, Beats and Sections:
	//    curStep, curDecStep
	//    curBeat, curDecBeat
	//    curSection
	override function stepHit()
	{
		// Code here
	}
	override function beatHit()
	{
		// Code here
	}
	override function sectionHit()
	{
		// Code here
	}

	// Substates for pausing/resuming tweens and timers
	override function closeSubState()
	{
		if(paused)
		{
			//timer.active = true;
			//tween.active = true;
		}
	}

	override function openSubState(SubState:flixel.FlxSubState)
	{
		if(paused)
		{
			//timer.active = false;
			//tween.active = false;
		}
	}

	// For events
	override function eventCalled(eventName:String, value1:String, value2:String, flValue1:Null<Float>, flValue2:Null<Float>, strumTime:Float)
	{
		switch(eventName)
		{
			case "My Event":
		}
	}
	override function eventPushed(event:objects.Note.EventNote)
	{
		// used for preloading assets used on events that doesn't need different assets based on its values
		switch(event.event)
		{
			case "My Event":
				//precacheImage('myImage') //preloads images/myImage.png
				//precacheSound('mySound') //preloads sounds/mySound.ogg
				//precacheMusic('myMusic') //preloads music/myMusic.ogg
		}
	}
	override function eventPushedUnique(event:objects.Note.EventNote)
	{
		// used for preloading assets used on events where its values affect what assets should be preloaded
		switch(event.event)
		{
			case "My Event":
				switch(event.value1)
				{
					// If value 1 is "blah blah", it will preload these assets:
					case 'blah blah':
						//precacheImage('myImageOne') //preloads images/myImageOne.png
						//precacheSound('mySoundOne') //preloads sounds/mySoundOne.ogg
						//precacheMusic('myMusicOne') //preloads music/myMusicOne.ogg

					// If value 1 is "coolswag", it will preload these assets:
					case 'coolswag':
						//precacheImage('myImageTwo') //preloads images/myImageTwo.png
						//precacheSound('mySoundTwo') //preloads sounds/mySoundTwo.ogg
						//precacheMusic('myMusicTwo') //preloads music/myMusicTwo.ogg
					
					// If value 1 is not "blah blah" or "coolswag", it will preload these assets:
					default:
						//precacheImage('myImageThree') //preloads images/myImageThree.png
						//precacheSound('mySoundThree') //preloads sounds/mySoundThree.ogg
						//precacheMusic('myMusicThree') //preloads music/myMusicThree.ogg
				}
		}
	}

	// Note Hit/Miss
	override function goodNoteHit(note:Note)
	{
		// Code here
	}

	override function opponentNoteHit(note:Note)
	{
		// Code here
	}

	override function noteMiss(note:Note)
	{
		// Code here
	}

	override function noteMissPress(direction:Int)
	{
		// Code here
	}
}
