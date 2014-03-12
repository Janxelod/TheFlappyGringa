package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Key;
	import scenes.GameWorld;
	import scenes.MenuScene;

	/**
	 * ...
	 * @author Joan Odicio
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Engine 
	{
		private var isModeDevelop:Boolean = true;
		public function Main():void 
		{
			super(768, 512, 60, false);
			FP.world = new MenuScene();//new GameWorld();
			if (isModeDevelop)
			{
				FP.console.enable();
				FP.console.toggleKey = Key.D;
				GD.MODE_DEVELOP = true;
			}else
			{
				GD.MODE_DEVELOP = false;
			}
		}
		override public function init():void
		{
			trace("FlashPunk has started successfully!");
		}
	
	}
}