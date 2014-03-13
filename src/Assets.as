package
{
	public class Assets
	{
		[Embed(source='../assets/test.png')] public static const _TEST:Class;

		/* --- graphics --- */
		[Embed(source='../assets/graphics/bloodEffect.png')] public static const GRAPHICS_BLOODEFFECT:Class;
		[Embed(source='../assets/graphics/bloodSplatter.png')] public static const GRAPHICS_BLOODSPLATTER:Class;
		[Embed(source='../assets/graphics/clouds.png')] public static const GRAPHICS_CLOUDS:Class;
		[Embed(source='../assets/graphics/creditsJxlod.png')] public static const GRAPHICS_CREDITSJXLOD:Class;
		[Embed(source='../assets/graphics/floor.png')] public static const GRAPHICS_FLOOR:Class;
		[Embed(source='../assets/graphics/floor_plus.png')] public static const GRAPHICS_FLOOR_PLUS:Class;
		[Embed(source='../assets/graphics/food.png')] public static const GRAPHICS_FOOD:Class;
		[Embed(source='../assets/graphics/gameover.png')] public static const GRAPHICS_GAMEOVER:Class;
		[Embed(source='../assets/graphics/gringa.png')] public static const GRAPHICS_GRINGA:Class;
		[Embed(source='../assets/graphics/gringa_.png')] public static const GRAPHICS_GRINGA_:Class;
		[Embed(source='../assets/graphics/hudbar.png')] public static const GRAPHICS_HUDBAR:Class;
		[Embed(source='../assets/graphics/spike.png')] public static const GRAPHICS_SPIKE:Class;
		[Embed(source='../assets/graphics/spike2.png')] public static const GRAPHICS_SPIKE2:Class;
		[Embed(source='../assets/graphics/title.png')] public static const GRAPHICS_TITLE:Class;
		[Embed(source='../assets/graphics/wall_down.png')] public static const GRAPHICS_WALL_DOWN:Class;
		[Embed(source='../assets/graphics/wallUp.png')] public static const GRAPHICS_WALLUP:Class;
		public static const GRAPHICS:Array = [GRAPHICS_BLOODEFFECT, GRAPHICS_BLOODSPLATTER, GRAPHICS_CLOUDS, GRAPHICS_CREDITSJXLOD, GRAPHICS_FLOOR, GRAPHICS_FLOOR_PLUS, GRAPHICS_FOOD, GRAPHICS_GAMEOVER, GRAPHICS_GRINGA, GRAPHICS_GRINGA_, GRAPHICS_HUDBAR, GRAPHICS_SPIKE, GRAPHICS_SPIKE2, GRAPHICS_TITLE, GRAPHICS_WALL_DOWN, GRAPHICS_WALLUP];

		/* --- sounds --- */
		[Embed(source='../assets/sounds/death.mp3')] public static const SOUNDS_DEATH:Class;
		[Embed(source='../assets/sounds/eating_food.mp3')] public static const SOUNDS_EATING_FOOD:Class;
		[Embed(source='../assets/sounds/spike.mp3')] public static const SOUNDS_SPIKE:Class;
		[Embed(source='../assets/sounds/spikeiskillyingme.mp3')] public static const SOUNDS_SPIKEISKILLYINGME:Class;
		public static const SOUNDS:Array = [SOUNDS_DEATH, SOUNDS_EATING_FOOD, SOUNDS_SPIKE, SOUNDS_SPIKEISKILLYINGME];
	}
}
