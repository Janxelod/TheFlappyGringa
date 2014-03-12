package entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Backdrop;
	
	/**
	 * ...
	 * @author Joan Odicio
	 */
	public class WallUp extends Entity 
	{
		private var sprite:Backdrop = new Backdrop(Assets.GRAPHICS_WALLUP, true, false);
		private var speed:Number = GD.GlobalSpeedX;
		public function WallUp(x:Number, y:Number) 
		{
			super(x,y)
			setHitbox(FP.width, 25, 0, -10);
			sprite.x = 0;
			sprite.y = -sprite.height + height;
			graphic = sprite;
			layer = 10;
			type = "solid";
		}
		override public function update():void 
		{
			sprite.x += speed * FP.elapsed;
		}
	}

}