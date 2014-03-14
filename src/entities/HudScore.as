package entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Ease;
	/**
	 * ...
	 * @author Joan Odicio
	 */
	public class HudScore extends Entity 
	{
		private var text:Text;
		private static var instance:HudScore;
		private function init():void
		{
			text = new Text("0");
			text.originX = 0.5;
			text.originY = 0.5;
			text.color = 0xFFFFFF;
			text.size = 64;
			graphic = text;
			this.x = 20;
			this.y = 130;
			layer = -40;
			type = "score";
		}
		public static function getInstance():HudScore
		{
			if (instance == null)
			{
				instance = new HudScore();
				instance.init();
				
			}
			instance.text.text = String(Player.SCORE);
			return instance;
		}
		public function setScore(value:int):void
		{
			Player.SCORE += value;
			instance.text.text = String(Player.SCORE);
			FP.world.add(new ScoreEffect(Player.posGlobalX,Player.posGlobalY-20, value));
			startEffect();
		}
		public function startEffect():void
		{
			//FP.world.clearTweens();
			FP.tween(text, { scale:1.25 }, 0.25  );
			FP.tween(text, { scale:1 }, 0.25, { delay:0.25,ease:Ease.circInOut } );
		}
	}
}
