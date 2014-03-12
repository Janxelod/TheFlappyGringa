package entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author Joan Odicio    
	 */
	public class WallDown extends Entity 
	{
		private var sprite:Backdrop = new Backdrop(Assets.GRAPHICS_WALL_DOWN, true, false);
		private var speed:Number = GD.GlobalSpeedX;
		public function WallDown(x:Number,y:Number) 
		{
			super(x,y)
			setHitbox(FP.width, 25, 0, 25);
			sprite.x = 0;
			sprite.y = -sprite.height;
			graphic = sprite;
			//sprite.alpha = 0.5;
			layer = -10;
			type = "solid";
		}
		override public function update():void 
		{
			
			sprite.x += speed * FP.elapsed;
			if (Player.posGlobalY > 400)
			{
				sprite.alpha = 0.5;
			}else if (Player.posGlobalY<=400) {
				sprite.alpha = 1;
			}
		}
	}

}