package entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.NumTween;
	import scenes.GameWorld;
	
	/**
	 * ...
	 * @author Joan Odicio
	 */
	public class Food extends Entity 
	{
		private var image:Image = new Image(Assets.GRAPHICS_FOOD);
		private var speedX:Number;
		public var power:Number = 120;
		private var up:Boolean = true;
		private var clockwise:Boolean = true;
		public function Food(x:Number, y:Number,layer:int,speedX:Number) 
		{
			super(x, y);
			image.scale = 0.8;
			image.centerOrigin();
			graphic = image;
			type = "food";
			this.speedX = speedX;
			this.layer = layer;
			power = (GameWorld.MODE == GameWorld.AGRESSIVE)?GD.EnergyTimeToAgressiveMode:GD.EnergyTimeToNormalMode;
			power *= Math.round(FP.frameRate);
			trace("Power: " + power);
			setHitbox(image.scaledWidth, image.scaledHeight, image.scaledWidth/2, image.scaledHeight/2);
		}
		
		override public function update():void
		{
			if (up)
			{
				image.scale += FP.elapsed / 2.5;
				
				if (image.scale >= 1) up = false;
			}else
			{
				image.scale -= FP.elapsed / 2.5;
				
				if (image.scale <=0.8) up = true;
			}
			if (clockwise)
			{
				image.angle += 1;
				if (image.angle >= 22.5) clockwise = false;
			}else
			{
				image.angle -= 1;
				if (image.angle <= -22.5) clockwise = true;
			}
			
			moveBy(speedX * FP.elapsed, 0, "", true);
			
			if (this.x > FP.width + this.width)
			{
				destroy();
			}
		}
		public function destroy():void
		{
			FP.world.remove(this);
		}
	}

}