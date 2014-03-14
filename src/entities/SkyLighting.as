package entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author Joan Odicio
	 */
	public class SkyLighting extends Entity 
	{
		private var sprite:Image;
		private var timeAppear:Number;
		private var timeToDisappear:Number = 0.35;
		private var SFX:Sfx;
		public function SkyLighting() 
		{
			sprite = new Image(Assets.GRAPHICS_SKYLIGHTING);
			graphic = sprite;
			visible = false;
			layer = 30;
			sprite.scaleX = 5;
			sprite.scaleY = 3.5
			SFX = new Sfx(Assets.SOUNDS_RANDOMIZE32);
			
		}
		public function appear():void
		{
			visible = true;
			timeAppear = 0;
			active = true;
			sprite.alpha = 1;
			SFX.play();
		}
		public override function update():void
		{
			timeAppear += FP.elapsed;
			sprite.alpha -= 0.05;
			if (timeAppear >= timeToDisappear)
			{
				visible = false;
				active = false;
			}
		}
		
	}

}