package entities 
{
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Backdrop;
	
	/**
	 * ...
	 * @author Joan Odicio
	 */
	public class Cloud extends Entity 
	{
		private var sprite:Backdrop = new Backdrop(Assets.GRAPHICS_CLOUDS,true,false);
		private var speed:Number = -10;
		public function Cloud(x:Number,y:Number) 
		{
			graphic = sprite;
			layer = 20;
			sprite.x =  x;
			sprite.y = y;
			type = "cloud";
		}
		override public function update():void 
		{
			sprite.x += speed * FP.elapsed;
			//sprite.y += speed * FP.elapsed;
			//trace("Actualizando " + sprite.x + "," + sprite.y);
		}
		public function applyFilter(isAgressive:Boolean):void
		{
			var myfilters:Array = [];
			var matrix:Array = [];
			var colorMatrix:ColorMatrixFilter;
			if (isAgressive)
			{
				matrix = matrix.concat([0.52, 0.5, 0, 0.81, 0]); // red
				matrix = matrix.concat([0, 1, 0, 0, 0]); // green
				matrix = matrix.concat([0, 0, 1, 0, 0]); // blue
				matrix = matrix.concat([0, 0, 0, 1, 0]); // alpha
				colorMatrix= new ColorMatrixFilter(matrix);
			}else
			{
				/*matrix = matrix.concat([1/0.52, 1/0.5, 0, 0, 0]); // red
				matrix = matrix.concat([0, 1, 0, 0, 0]); // green
				matrix = matrix.concat([0, 0, 1, 0, 0]); // blue
				matrix = matrix.concat([0, 0, 0, 1, 0]); // alpha*/
				colorMatrix = new ColorMatrixFilter();
			}
			sprite.applyFilter(colorMatrix);
			
		}
		public function changeColor(fromColor:uint,toColor:uint,mask:uint=0xFFFFFFFF):void
		{
			sprite.changeColor(fromColor, toColor, mask);
		}
	}

}