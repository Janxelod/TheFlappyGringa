package  entities
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import scenes.GameWorld;
	
	/**
	 * ...
	 * @author Joan Odicio
	 */
	public class Player extends Entity 
	{
		private var isRunning:Boolean=false;
		private var isRight:Boolean=false;
		private var speedY:Number=3.5;
		private var noPressed:Boolean=true;
		private var impulse:Number=-24;
		public var sprite:Spritemap = new Spritemap(Assets.GRAPHICS_GRINGA, 64,64);
		public static var posGlobalY:Number;
		public static var MOVING:String = "run";
		public static var DEATH:String = "death";
		public static var BEDYING:String="bedying"
		private var currentState:String
		private var timeToFly:Number=1.5;
		private var time:Number=0;

		private var deathSFX:Sfx = new Sfx(Assets.SOUNDS_DEATH);
		private var eatSFX:Sfx = new Sfx(Assets.SOUNDS_EATING_FOOD);
		private var spikeKilledMe:Sfx = new Sfx(Assets.SOUNDS_SPIKEISKILLYINGME);
		public var isGame:Boolean;
		public static var isAlive:Boolean;
		public static var timeToDeath:Number;
		public static var life:Number;
		public var timeStayingUp:Number;
		public var timeStayingDown:Number;
		
		private var shakeFreqY:Number = 10;
		private var shakeSizeX:Number = 3;
		private var shakeSizeY:Number = 3;
		private var shakeSizeY2:Number = 1.25;
		private var cameraShakingUpdatesLeft:int;
		private var t:Number=0;
		private var isShaking:Boolean=false;
		private var lastX:Number;
		private var lastY:Number;
		private var effect:Emitter;
		private var initialLife:Number;
		private var limitDown:Number;
		public static var SCORE:int;
		public static var posGlobalX:Number;
		public function Player(isGame:Boolean=true) 
		{
			super(FP.width - sprite.width-100, FP.height-sprite.height-200);
			sprite.centerOrigin();
			sprite.scale *= 1.25;
			sprite.y = -sprite.scaledHeight / 2 + 5;
			graphic = sprite;
			setHitbox(40, 15, 25, 15);
			type = "player";
			currentState = MOVING;
			this.isGame = isGame;
			timeToDeath = (GameWorld.MODE == GameWorld.AGRESSIVE)?GD.LifeTimeToAgressiveMode:GD.LifeTimeToNormalMode;
			
			life = timeToDeath * Math.round(FP.assignedFrameRate);
			initialLife = life;
			timeStayingDown=timeStayingUp = 0;
			limitDown = FP.height - 50;
			SCORE = 0;
			posGlobalX = this.x;
		}
		override public function added():void
		{
			sprite.add("run", [7,6,5,4,3,2,1,0],12   , true);
			sprite.add("death", [8]);
			sprite.add("bedying", [7]);
			sprite.play("run");
			posGlobalY = this.y;
			isAlive = true;
		}
		override public function update():void
		{
			switch(currentState)
			{
				case MOVING:
					if (isGame)
					{
						moving();
						if (y >= 150 && y < 250) layer = 7; //Layer between first wall and first spikes row
						if (y >= 250 && y < 350) layer = 3; //Layer between first spikes row and second spikes row
						if (y >= 350 && y < 450) layer = -3; //Layer between second spikes row and third spikes row
						if (y >= 450 && y < limitDown) layer = -7; //Layer between thirds spikes row and second wall
						
						//Verify player stay not much time in the wall Up
						if (y >= 150 && y < 300) timeStayingUp += FP.elapsed;
						else timeStayingUp = 0;
						
						//Verify player stay not much time in the wall Down
						if (y >= 450) timeStayingDown += FP.elapsed;
						else timeStayingDown = 0;
					}
				break;
			case BEDYING:
					if (isShaking) 
					{
						shake();
					}
					else 
					{
						switchState(DEATH);
						deathSFX.play();
					}
				break
				case DEATH:
					death();
				break;
			}
			
			posGlobalX = x;
			posGlobalY = y;
		}
		
		private function emitEffect():void 
		{
			var dimension:int = 150;
			for (var i:uint = 0; i < dimension; i++)
			{
				effect.emit("Blood", this.x + FP.rand(20) - FP.rand(20) , this.y);
			}
		}
		public function initShake(time:Number):void
		{
			cameraShakingUpdatesLeft = Math.round(FP.stage.frameRate * time);
			isShaking = true;
		}
		private function shake():void 
		{
			t += FP.elapsed;
			this.x += int(Math.sin( t * 63 ) * shakeSizeX);
			this.y += int(Math.sin( t * 63 ) * shakeSizeY + Math.cos( t * shakeFreqY ) * shakeSizeY2);
			cameraShakingUpdatesLeft--;
			if (cameraShakingUpdatesLeft == 0)
			{
				this.x = lastX;
				this.y = lastY;
				t = 0;
				isShaking = false
				deathSFX.play();
			}
		}
		public function switchState(newState:String):void
		{
			currentState = newState;
			sprite.play(currentState);
		}
		private function death():void 
		{
			time+=FP.elapsed
			if (time > timeToFly) {
				moveBy(0, -speedY);
			}
			if (this.y < -this.height)
			{
				GameWorld(FP.world).startGameOver();
				currentState = "end";
			}
		}
		
		private function moving():void 
		{
			if (noPressed) {
				moveBy(0, speedY , "solid", true);
			}else {
				moveBy(0, -speedY, "solid", true);
			}
			if (Input.pressed(Key.SPACE)) {
				noPressed = false;
				moveBy(0, impulse, "solid", true);
			}else if (Input.released(Key.SPACE)) {
				noPressed = true;
				
			}
			posGlobalY = this.y;
			if (collide("spike", x, y))
			{
				killPlayer();
				initShake(2);
				spikeKilledMe.play();
				if (GameWorld.MODE == GameWorld.AGRESSIVE)
				{
					startEffect();
					emitEffect();
				}
			}
			var f:Food = Food(collide("food", x, y));
			if (f)
			{
				eatSFX.play();
				life += f.power;
				
				HudScore.getInstance().setScore(1);
				if (life >= initialLife) life = initialLife;
				f.destroy();
			}
			var b:BonusSpike = BonusSpike(collide("Bonus", x, y));
			if (b)
			{
				//eatSFX.play();
				HudScore.getInstance().setScore(b.Scorevalue);
				if (GameWorld.MODE == GameWorld.AGRESSIVE) GameWorld(world).startLighting();
				//trace("Score Player: " + SCORE);
				FP.world.remove(b);
			}
			if (life >= 0) life--;
			else killPlayer();
		}
		
		private function killPlayer():void 
		{
			lastX = this.x;
			lastY = this.y;
			switchState(BEDYING);
			isAlive = false;
			var entites:Array=new Array();
			FP.world.getAll(entites);
			for each(var e:Entity in entites)
			{
				if(e!=this && e.type!="score") e.active = false;
			}
		}
		override public function moveCollideY(e:Entity):Boolean 
		{
			return super.moveCollideY(e);
		}
		private function startEffect():void
		{
			effect = new Emitter(Assets.GRAPHICS_BLOODEFFECT,40,40);
			/*Efecto de Daño*/
			effect.newType("Blood");
			effect.setAlpha("Blood", 1, 0.5);
			effect.setMotion("Blood", 0, 100, 2, 180, 0, 1.5, Ease.quadOut);
			effect.setGravity("Blood", -90, 180);
			//var pixel:myPixe
			/*Efecto de Daño*/
			effect.relative = false;
			addGraphic(effect);
		}
		
	}

}