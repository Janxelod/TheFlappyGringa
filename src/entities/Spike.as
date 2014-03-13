package entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author Joan Odicio
	 */
	public class Spike extends Entity 
	{
		private var sprite:Spritemap = new Spritemap(Assets.GRAPHICS_SPIKE,116,213);
		private var speedX:Number;
		public static var widthHitBox:Number;
		public function Spike(x:Number,y:Number,layer:int,speedX:Number) 
		{
			super(x, y);
			sprite.centerOrigin();
			sprite.scale = 0.5;
			sprite.smooth = false;
			sprite.y = -sprite.scaledHeight / 2;
			graphic = sprite;
			this.layer = layer;
			this.speedX = speedX;
			widthHitBox = sprite.width / 2.5;
			setHitbox(widthHitBox, 15, 25, 15);
			
			type = "spike";
			sprite.add("stand", [0,1,2],10   , true);
			sprite.play("stand");
		}
		override public function update():void
		{
			moveBy(speedX*FP.elapsed, 0, "", true);
			if (this.x > FP.width + this.width)
			{
				FP.world.remove(this);
			}
		}
	}

}