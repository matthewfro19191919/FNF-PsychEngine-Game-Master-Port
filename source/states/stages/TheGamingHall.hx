package states.stages;

import states.stages.objects.*;

class TheGamingHall extends BaseStage
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
			var behindGaming:FlxSprite = new FlxSprite(50, 85).loadGraphic(Paths.image('WrongArea/TheGamingHall_Background_Behind'));
			behindGaming.antialiasing = true;
			behindGaming.setGraphicSize(Std.int(behindGaming.width * 1.5));
			add(behindGaming);

			var frontGaming:FlxSprite = new FlxSprite(50, 85).loadGraphic(Paths.image('WrongArea/TheGamingHall_Background'));
			frontGaming.antialiasing = true;
			frontGaming.setGraphicSize(Std.int(frontGaming.width * 1.5));
			add(frontGaming);

	if (SONG.song.toLowerCase() == 'jovial')
	{
			frontGaming.color = FlxColor.PURPLE;
			behindGaming.color = 0xFF823C25;
			boyfriendGroup.color = FlxColor.PURPLE;
			gfGroup.color = FlxColor.PURPLE;
			dadGroup.color = FlxColor.PURPLE;
	}
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


	function flirtHeart():Void // pain.
	{
		if (hearts.x >= 820 && hearts.x <= 925 && !dodgeBF)
		{
			FlxG.sound.play(Paths.sound('hitHeart'));
			heartbeatSound.volume = 1;
			hearts.x = 50;
			hearts.y = 40;
			hearts.alpha = 0;
			heartActive = false;
			boyfriend.playAnim('love stun');
			boyfriend.stunned = true;
			gotStunned = true;
			pressedDodge = false;
			FlxG.camera.flash(FlxColor.PINK, 0.5);
			camHUD.visible = false;

			warningGlow.alpha = 0;
			keyButtons.alpha = 0;
			appearGlow.alpha = 0;

			warningSpaceGlow.animation.play('redGlowSpace');
			spaceBarButton.animation.play('spaceToSmash');
			warningSpaceGlow.alpha = 1;
			spaceBarButton.alpha = 1;
		}
		if (hearts.x >= 575 && hearts.x <= 600 && pressedDodge == true)
		{
			warningGlow.animation.play('redGlow');
			appearGlow.animation.play('yellowGlow');
			warningGlow.alpha = 1;
			keyButtons.alpha = 1;
			appearGlow.alpha = 1;
			if (randomButtom == 1)
			{
				keyButtons.animation.play('ButtonV');
			}
			if (randomButtom == 2)
			{
				keyButtons.animation.play('ButtonB');
			}
			if (randomButtom == 3)
			{
				keyButtons.animation.play('ButtonN');
			}
		}

		if (hearts.x >= 575 && hearts.x <= 765 && pressedDodge == true)
		{
			if (FlxG.keys.justPressed.V && randomButtom == 1 || FlxG.keys.justPressed.B && randomButtom == 2 ||  FlxG.keys.justPressed.N && randomButtom == 3)
			{
				FlxG.sound.play(Paths.sound('BFDodge_Heart'));
				dodgeBF = true;
				pressedDodge = false;
				boyfriend.stunned = true;
				boyfriend.playAnim('dodge');
				warningGlow.alpha = 0;
				keyButtons.alpha = 0;
				appearGlow.alpha = 0;
				randomButtom = randomRangeFloat(1, 3);
				new FlxTimer().start(1.1, function(tmr:FlxTimer)
				{
					dodgeBF = false;
					pressedDodge = true;
					boyfriend.stunned = false;
				});
			}
		}
		if (hearts.x >= 1250)
		{
			FlxTween.tween(hearts, {alpha: 0}, 1, {ease: FlxEase.linear,
				onComplete: function(twn:FlxTween)
				{
					hearts.x = 50;
					hearts.y = 40;
					hearts.alpha = 0;
					heartStart.alpha = 0;
					heartActive = false;
					warningGlow.alpha = 0;
					keyButtons.alpha = 0;
					appearGlow.alpha = 0;
				}
			});
		}

		if (curBeat % 16 == 15 && SONG.song.toLowerCase() == 'jovial')
		{
			if (curBeat <= 73 || curBeat >= 80 && curBeat <= 250)
			{
				dad.playAnim('flirtHeart');
				hearts.animation.reset();
				hearts.animation.play('heartAttack');
				heartStart.animation.reset();
				// FlxG.sound.play(Paths.sound('GameMaster2_Kiss'));
				mwahSound.play();
				new FlxTimer().start(0.1, function(tmr:FlxTimer)
				{
					hearts.alpha = 1;
					Actuate.tween (heartStart, 7.5, { alpha: 0 });
					heartStart.alpha = 1;
					heartStart.animation.play('heartAppear');
					heartActive = true;
				});
			}
		}

		if (gotStunned == true && !pressedDodge)
		{
			gf.playAnim('jealous');
			vignette.alpha -= 0.05;
			heartStart.alpha = 0;
			vignette.alpha = FlxMath.bound(vignette.alpha, 0.35, 1);
			if (FlxG.keys.justPressed.SPACE)
			{
				stunStruggle += 1.58;
				vignette.alpha = 1;
				FlxG.sound.play(Paths.soundRandom('StruggleBroke_', 1, 4));
				FlxG.camera.shake(0.01, 0.5);
			}
			if (!paused)
			{
				camHUD.visible = false;
			}
		}

		stunStruggle = FlxMath.bound(stunStruggle, 0, 15);

		if (stunStruggle >= 15)
		{
			FlxG.sound.play(Paths.sound('HeartBroken'));
			boyfriend.stunned = false;
			stunStruggle = 0;
			vignette.alpha = 0;
			gf.playAnim('cheer');
			boyfriend.playAnim('idle');
			pressedDodge = true;
			gotStunned = false;
			FlxG.camera.flash(FlxColor.WHITE, 0.5);
			camHUD.visible = true;
			warningSpaceGlow.alpha = 0;
			spaceBarButton.alpha = 0;
			heartbeatSound.volume = 1;
		}
	}

	function machineJam():Void // EMP SYSTEM, INCOMING
	{
		if (!inCutscene)
		{
			timerEMPNum -= 0.01;
		}

		if (!glitchCover.visible)
		{
			strumLineNotes.visible = true;
			healthBar.visible = true;
			healthBarBG.visible = true;
			iconP1.visible = true;
			iconP2.visible = true;
			scoreTxt.visible = true;
			randomizeSymbols.visible = true;
			badLuckSymbols.visible = true;
			techJamSound.volume = 0;
		}

		if (glitchCover.visible == true)
		{
			strumLineNotes.visible = false;
			healthBar.visible = false;
			healthBarBG.visible = false;
			iconP1.visible = false;
			iconP2.visible = false;
			scoreTxt.visible = false;
			randomizeSymbols.visible = false;
			badLuckSymbols.visible = false;
			techJamSound.volume = 1;
			// FlxG.sound.play(Paths.sound('Tech_Jam');
		}

		if (timerEMPNum <= 0.99 && SONG.song.toLowerCase() == 'jovial')
		{
			glitchCover.visible = !glitchCover.visible;
			timerEMPNum = randomRangeFloat(10, 15);
			techJamSound.play();
		}
	}

	function badLuckRandom():Void // bad choice, maybe
	{
		if (randomizerNum == 0)
		{
			if (!inCutscene)
			{
				timerRandomNum -= 0.01;
			}
			
			if (timerRandomNum <= 0)
			{
				randomizerNum = randomRangeFloat(1, 7);
				// randomizerNum += 2;
				randomizeSymbols.alpha = 0;
				badLuckSymbols.alpha = 0.85;
			}
			if (timerRandomNum <= 4)
			{
				FlxTween.tween(randomizeSymbols, {y: 580}, 1.15, {ease: FlxEase.circOut});
				randomCountDownSound.play();
				randomizeSymbols.alpha = 0.85;
			}
		}
		if (timerRandomNum >= 1)
		{
			testStop = false;
		}

		if (randomizerNum == 1 && !testStop || randomizerNum == 7 && !testStop) // random 1, shortly increase health idk.
		{
			randomizerNum = 0;
			shortHealthInc = true;
			testStop = true;
			timerRandomNum = 21;
			FlxG.sound.play(Paths.sound('randomStart'));

			badLuckSymbols.animation.play('downgradedIncreaseHealth_Symbols');

			trace('lack of increase health');
		}

		if (randomizerNum == 4 && !testStop) // random 2, back to the middle
		{
			randomizerNum = 0;
			health = 1;
			testStop = true;
			timerRandomNum = 15;
			FlxG.sound.play(Paths.sound('randomStart'));

			badLuckSymbols.animation.play('middle_Symbols');

			trace('middle');
		}
		
		if (randomizerNum == 2 && !testStop || randomizerNum == 6 && !testStop) // the swap
		{
			randomizerNum = 0;
			swapHealthActive = true;
			testStop = true;
			timerRandomNum = 22;
			FlxG.sound.play(Paths.sound('randomStart'));

			badLuckSymbols.animation.play('swap_Symbols');

			trace('swap');
		}

		if (randomizerNum == 3 && !testStop || randomizerNum == 5 && !testStop) // bleed
		{
			randomizerNum = 0;
			bleedHealth = true;
			testStop = true;
			timerRandomNum = 23;
			FlxG.sound.play(Paths.sound('randomStart'));

			badLuckSymbols.animation.play('bleed_Symbols');

			trace('bleed');
		}

		if (bleedHealth == true) // bleed
		{
			health -= 0.00075;
		}

		if (swapHealthActive == true)
		{
			swapHealthActive = false;
			swapHealth = true;
			tvActive = false;
			screenStatics.alpha = 0;
			tvStaticSound.volume -= 0;
			bfEntity.x = 1650;
			bfEntity.alpha = 0;

			if (health >= 1.99)
			{
				health -= 0.35;
			}

			if (iconP1.animation.curAnim.name == 'thegamemaster-phase1')
				iconP1.animation.play(SONG.player1);
			else
				iconP1.animation.play('thegamemaster-phase1');

			if (iconP2.animation.curAnim.name == 'bf')
				iconP2.animation.play(SONG.player2);
			else
				iconP2.animation.play('bf');
		}

		if (!swapHealth)
		{
			health = FlxMath.bound(health, 0, 1.998);
		}
		if (swapHealth == true)
		{
			health = FlxMath.bound(health, 0.002, 2);
		}

		if (timerRandomNum <= 9.5) // change back to normal
		{
			shortHealthInc = false;
			bleedHealth = false;
			if (swapHealth == true)
			{
				swapHealth = false;
				if (health <= 0.01)
				{
					health += 0.35;
				}
				
				if (iconP1.animation.curAnim.name == 'thegamemaster-phase1')
					iconP1.animation.play(SONG.player1);
				else
					iconP1.animation.play('thegamemaster-phase1');

				if (iconP2.animation.curAnim.name == 'bf')
					iconP2.animation.play(SONG.player2);
				else
					iconP2.animation.play('bf');
			}

			FlxTween.tween(badLuckSymbols, {y: 800}, 0.5, {ease: FlxEase.cubeIn,
				onComplete: function(twn:FlxTween)
				{
					// badLuckSymbols.alpha = 0;
				}
			});
		}
		if (timerRandomNum >= 9.6)
		{
			randomizeSymbols.y += 120;
			badLuckSymbols.y = 580;
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
