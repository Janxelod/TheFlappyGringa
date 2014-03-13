package  scenes
{
	import entities.*;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import net.flashpunk.utils.Draw;
	/**
	 * ...
	 * @author Joan Odicio
	 */
	public class GameWorld extends World 
	{
		static public const AGRESSIVE:int = 1;
		static public const NORMAL:int = 2;
		static public var MODE:int=0;
		private var timeToAppear:Number = 1;
		private var waitingTime:Number = 0;
		private var barHud:HudBar;
		private var spikeSFX:Sfx = new Sfx(Assets.SOUNDS_SPIKE);
		private var currentColor:uint;
		private var normalColor:uint=0x31eee3;
		private var agressiveColor:uint = 0x5a5d56;
		private var isGameOver:Boolean = false;
		private var playerRef:Player;
		private var maxTimePermitedStayUp:Number=2;
		private var maxTimePermitedStayDown:Number=3.5;
		public function GameWorld() 
		{
			super();
		}
		override public function begin():void
		{
			var cloud:Cloud
			if (GameWorld.MODE == GameWorld.AGRESSIVE)
			{
				cloud = Cloud(add(new Cloud(0, 15)));
				timeToAppear = 0.75;
				currentColor = agressiveColor;
				cloud.changeColor(0xFF81bddc, 0xFF7d6590);
				cloud.changeColor(0xFFFFFFFF, 0xFFb3b3b3);
				cloud.changeColor(0xFF000000, 0xFFc22222);
				GD.GlobalSpeedX = GD.AgressiveSpeedX;
			}else
			{
				cloud = Cloud(add(new Cloud(0, 15)));
				timeToAppear = 1;
				currentColor = normalColor
				GD.GlobalSpeedX = GD.NormalSpeedX;
			}
			add(new Floor(0, 175));
			add(new WallUp(50,150));
			playerRef=Player(add(new Player()));	
			add(new WallDown(50, FP.height));
			barHud=new HudBar(0,265);
			add(barHud);
		}
		override public function update():void
		{
			super.update();
			if(isGameOver||GD.MODE_DEVELOP)checkInputs();
			waitingTime += FP.elapsed;
			if (waitingTime >= timeToAppear)
			{
				if (Player.isAlive)
				{
					var canCreateFood:int;
					var tempRow:Entity;	
					var spikePerRow:int = (MODE == AGRESSIVE)?(FP.rand(3) + 1):(FP.rand(2) + 1);
					var spikeCol:Array = [ 1, 2, 3 ];
					var lastSpikeRow:int = int.MAX_VALUE;
					FP.shuffle(spikeCol);
					for (var i:uint = 0; i < spikePerRow; i++ )
					{
						var spikeRow:int = spikeCol[i];
						if (Math.abs(lastSpikeRow - spikeRow) == 1 && spikePerRow==2) 
						{
							if ((lastSpikeRow == 1 && spikeRow == 2) || (lastSpikeRow == 2 && spikeRow == 1))
							{
								add(new BonusSpike(tempRow.x, 295, tempRow.layer, GD.GlobalSpeedX));
							}
							if ((lastSpikeRow == 2 && spikeRow == 3) || (lastSpikeRow == 3 && spikeRow == 2))
							{
								add(new BonusSpike(tempRow.x, 395, tempRow.layer, GD.GlobalSpeedX));
							}
						}
						if (spikePerRow == 3 && i==2)
						{
							add(new BonusSpike(tempRow.x, 295, tempRow.layer, GD.GlobalSpeedX));
							add(new BonusSpike(tempRow.x, 395, tempRow.layer, GD.GlobalSpeedX));
						}
						switch(spikeRow)
						{
							case 1: 
								tempRow = add(new Spike( -100, 250, 5, GD.GlobalSpeedX)); 
								if (playerRef.timeStayingUp < maxTimePermitedStayUp)
								{
									canCreateFood = FP.rand(10);
									if (canCreateFood > 4)
									{
										add(new Food(tempRow.x - 100, tempRow.y-20, tempRow.layer, GD.GlobalSpeedX));
									}
									else if (spikePerRow==1)
									{
										add(new Food(tempRow.x - 100, tempRow.y-20, tempRow.layer, GD.GlobalSpeedX));
									}
								}
							break;
							case 2: 
								tempRow=add(new Spike( -100, 350, 0, GD.GlobalSpeedX));  
								canCreateFood = FP.rand(10);
								if (canCreateFood > 5)
								{
									add(new Food(tempRow.x - 100, tempRow.y-20, tempRow.layer, GD.GlobalSpeedX));
								}else if (spikePerRow==1)
								{
									add(new Food(tempRow.x - 100, tempRow.y-20, tempRow.layer, GD.GlobalSpeedX));
								}
							break;
							case 3: 
								tempRow=add(new Spike( -100, 450, -5, GD.GlobalSpeedX)); 
								canCreateFood = FP.rand(10);
								if (playerRef.timeStayingDown < maxTimePermitedStayDown)
								{
									//trace("TimeStayingDown: " + playerRef.timeStayingDown);
									if (canCreateFood > 7)
									{
										add(new Food(tempRow.x - 100, tempRow.y-20, tempRow.layer, GD.GlobalSpeedX));
									}else if (spikePerRow==1)
									{
										add(new Food(tempRow.x - 100, tempRow.y-20, tempRow.layer, GD.GlobalSpeedX));
									}
								}
							break;
						}
						lastSpikeRow = spikeRow;
					}
					
					spikeSFX.play();
				}
				waitingTime = 0;
			}
		}
		
		private function checkInputs():void 
		{
			if (Input.check(Key.R))
			{
				FP.world = new MenuScene();
			}
		}
		public function startGameOver():void
		{
			var title:Image = new Image(Assets.GRAPHICS_GAMEOVER);
			title.scale = 3;
			addGraphic(title, -30, FP.halfWidth-title.scaledWidth/2, -title.scaledHeight);
			FP.tween(title, { y:FP.halfHeight  }, 2, { complete:
				function():void 
				{
					isGameOver = true;
					title.originY = 1;
					var instruction:Text = new Text("Press R to restart game",0 ,0 , null);
					instruction.size = 25;
					instruction.setStyle("bold", { bold:true } );
					instruction.color = 0x000000;
					addGraphic(instruction, -30, FP.halfWidth-instruction.width/2, FP.height - 150);
				} 
			} );
			FP.tween(title, { scaleY:1.5,alpha:0.7 }, 10, { delay:1.5 } );
			
		}
		override public function render():void
		{
			Draw.rect(0, 0, FP.width, FP.height, currentColor);
			Draw.rect(0, FP.halfHeight, FP.width, FP.halfHeight, 0xddd894);
			
			super.render();
		}
		override public function end():void
		{
			removeAll();
		}
		
	}

}