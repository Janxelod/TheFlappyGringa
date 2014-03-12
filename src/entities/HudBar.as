package entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Draw;
	
	/**
	 * ...
	 * @author Joan Odicio
	 */
	public class HudBar extends Entity 
	{
		private var fillBar:Image;
		private var initialLife:Number;
		public function HudBar(x:Number=0, y:Number=0) 
		{
			fillBar = Image.createRect(36, 108, 0xFF0A00);
			fillBar.y += 108+4;
			super(x, y,fillBar);
			layer = -30;
			addGraphic(new Image(Assets.GRAPHICS_HUDBAR));
			fillBar.originY = 108;
			initialLife = Player.life;
			fillBar.alpha = 0.5;
			//addGraphic(fillBar);
		}
		public override function update():void
		{
			if (Player.isAlive)
			{
				fillBar.scaleY = Player.life / initialLife;
				if (fillBar.scaleY >= 1) fillBar.scaleY = 1;
			}
		}
		public override function render():void
		{
			super.render();	
		}
		
	}

}