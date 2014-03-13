package entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author Joan Odicio
	 */
	public class BonusSpike extends Entity 
	{
		private var speedX:Number=0;
		public var Scorevalue:int = 2;
		public function BonusSpike(x:Number=0, y:Number=0, layer:int=0, speedX:Number=0) 
		{
			super(x, y);
			setHitbox(Spike.widthHitBox/2, 64, 0, 0);
			type = "Bonus";
			this.speedX = speedX;
			centerOrigin();
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