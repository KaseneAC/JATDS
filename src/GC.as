package  
{
	/**
	 * ...
	 * @author Kasene Clark
	 */
	public class GC 
	{
		
		// Global Layers
		public static const LAYER_BACKGROUND:int = 5;
		public static const LAYER_PARTICLES:int = 0;
		public static const LAYER_BULLETS:int = 3;
		public static const LAYER_PLAYER:int = 2;
		public static const LAYER_ENEMY:int = 1;
		
		// Assets
		//[Embed(source = "/Assets/bg.png")] public static const Asset_Background:Class;
		[Embed(source = '/Assets/space.png')] public static const Asset_PlayerSprite:Class;
		[Embed(source = '/Assets/bullet.png')] public static const Asset_Bullet:Class;
		[Embed(source = '/Assets/Enemy.png')] public static const Asset_EnemySprite:Class;
		[Embed(source = '/Assets/powerup.png')] public static const Asset_PowerUp:Class;
	}

}