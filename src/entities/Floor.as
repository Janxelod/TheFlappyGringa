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
	public class Floor extends Entity 
	{
		private var sprite:Backdrop = new Backdrop(Assets.GRAPHICS_FLOOR,true,false);
		private var speed:Number = GD.GlobalSpeedX;
		public function Floor(x:Number=0, y:Number=0) 
		{
			super(x, y);
			
			//sprite.x = 0;
			//sprite.y = sprite.height;
			graphic = sprite;
			layer =20;
		}
		override public function update():void 
		{
			sprite.x += speed * FP.elapsed;
			//sprite.y += speed * FP.elapsed;
			//trace("Actualizando " + sprite.x + "," + sprite.y);
		}
	}

}