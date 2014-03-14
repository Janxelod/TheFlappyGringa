package entities 
{
	/**
	 * ...
	 * @author Joan Odicio
	 */
	import flash.media.Sound;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Sfx;
	import scenes.GameWorld;
	public class ScoreEffect extends Entity
	{
		private var text:Text;
		private var initialY:Number;
		private var SFX:Sfx
		public function ScoreEffect(x:Number,y:Number,value:int):void
		{
			text = new Text("+" + String(value));
			text.size = 35;
			graphic = text;
			this.x = x;
			initialY = this.y = y;
			layer = -50;
			text.color = (GameWorld.MODE == GameWorld.AGRESSIVE)?(Math.random() * 0xFFFFFF):0xFFFFFF;
			if (value == 2)
			{
				SFX = new Sfx(Assets.SOUNDS_PICKUP_COIN2);
				SFX.play(0.75);
				text.color = 0xFFFF00;
			}
			type = "score";
		}
		
		public function destroy():void 
		{
			FP.world.remove(this);
		}
		
		public override function update():void
		{
			text.alpha -= 0.005;
			moveBy(0, -0.75);
			if (y < initialY - 75)
			{
				destroy();
			}
		}
	}

}