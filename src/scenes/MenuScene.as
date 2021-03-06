package scenes 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.ColorTween;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import entities.*;
	/**
	 * ...
	 * @author Joan Odicio
	 */
	public class MenuScene extends World 
	{
		private var title:Image;
		private var playTitle:Text;
		private var colorTween:ColorTween;
		private var canPress:Boolean = false;
		private var normalTitle:Text;
		private var agressiveTitle:Text;
		
		private var cloud:Cloud;
		private var currentColor:uint;
		private var normalColor:uint=0x31eee3;
		private var agressiveColor:uint = 0x5a5d56;
		
		private var creditsJanxelod:Image;
		public function MenuScene() 
		{
			super();
			title = new Image(Assets.GRAPHICS_TITLE);
			title.scale = 2;
			playTitle=initializeText("Press Space to Start",120,350,25,0);
			normalTitle=initializeText("Press N to Normal Mode",120,275,18,0);
			agressiveTitle = initializeText("Press A to Agressive Mode", 120, 300, 18, 0);
			currentColor = normalColor;
			creditsJanxelod = new Image(Assets.GRAPHICS_CREDITSJXLOD);
			creditsJanxelod.centerOrigin();
		}
		private function initializeText(content:String,x:Number,y:Number,size:Number,alpha:Number):Text
		{
			var text:Text = new Text(content, x, y);
			text.size = size;
			text.alpha = alpha;
			return text;
		}
		override public function update():void
		{
			super.update();
			playTitle.color = colorTween.color;
			agressiveTitle.color = colorTween.color;
			normalTitle.color = colorTween.color;
			checkInputs();
			
		}
		
		private function checkInputs():void 
		{
			if (Input.check(Key.SPACE) && canPress)
			{
				FP.tween(title, { y:-title.height*2 } ,1 , { complete:function():void {FP.world = new GameWorld(); }} );
				canPress = false;
				colorTween.tween(1, 0x000000 , 0xddd894 );
				colorTween.start();
				colorTween.complete = null;
			}
			if (Input.check(Key.N))
			{
				currentColor = normalColor;
				cloud.changeColor(0xFF7d6590, 0xFF81bddc);
				cloud.changeColor(0xFFb3b3b3, 0xFFFFFFFF);
				cloud.changeColor(0xFFc22222, 0xFF000000);
			}else if (Input.check(Key.A))
			{
				currentColor = agressiveColor;
				cloud.changeColor(0xFF81bddc, 0xFF7d6590);
				cloud.changeColor(0xFFFFFFFF, 0xFFb3b3b3);
				cloud.changeColor(0xFF000000, 0xFFc22222);
			}
		}
		override public function begin():void
		{
			add(new Floor(0, 175));
			cloud=Cloud(add(new Cloud(0, 15)));
			add(new WallUp(50,150));
			add(new Player(false));	
			add(new WallDown(50, FP.height));
			addGraphic(playTitle);
			addGraphic(normalTitle);
			addGraphic(agressiveTitle);
			title.y = -this.title.height;
			title.x = 60;
			addGraphic(title);
			FP.tween(title, { y:100 } , 1, { complete:function():void { playTitle.alpha = 1;
			normalTitle.alpha = 1; agressiveTitle.alpha = 1; addTween(colorTween, true); }} );
			colorTween = new ColorTween(function():void { canPress = true; } );
			colorTween.tween(1.5, 0xddd894, 0x000000);
			creditsJanxelod.scale = 1;
			addGraphic(creditsJanxelod, -30, FP.width - creditsJanxelod.scaledWidth+40, 280);
			var text:Text = new Text("Special thanks to Flashpunk Comunity");
			text.color = 0x407ed2;
			addGraphic(text, -30, 440, 320);
			var text2:Text = new Text("Music powered by http://www.freesfx.co.uk/");
			text2.wordWrap = true;
			text2.color = 0x407ed2;
			addGraphic(text2, -30, 440, 345);
			var text3:Text = new Text("and Nintendo Co. Ltd ");
			text3.wordWrap = true;
			text3.color = 0x407ed2;
			addGraphic(text3, -30, 440, 380);
			
			var backGroundText:Image = Image.createRect(340, 100, 0xFFFFFF, 0.75);
			addGraphic(backGroundText, -28, 425, 315);
			creditsJanxelod.originY = 1;
			FP.tween(creditsJanxelod, { scaleY:1.35, alpha:0.8 }, 3.5);
			
		}
		override public function render():void
		{
			Draw.rect(0, 0, FP.width, FP.height, currentColor);
			Draw.rect(0, FP.halfHeight, FP.width, FP.halfHeight, 0xddd894);
			super.render();
			if (playTitle.color==0x000000)
			{
				if (currentColor == normalColor)
					Draw.rectPlus(normalTitle.x, normalTitle.y, normalTitle.width, normalTitle.height, 0x000000, 1, false,2);
				else
					Draw.rectPlus(agressiveTitle.x, agressiveTitle.y, agressiveTitle.width, agressiveTitle.height, 0x000000, 1, false,2);
			}
			
		}
		override public function end():void
		{
			removeAll();
			if (currentColor == agressiveColor)
			{
				GameWorld.MODE = GameWorld.AGRESSIVE;
			}else if(currentColor == normalColor)
			{
				GameWorld.MODE = GameWorld.NORMAL;
			}
		}
	}

}