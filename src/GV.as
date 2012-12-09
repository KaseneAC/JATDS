package  
{
	
	import Entities.HUD;
	import Entities.ParticleController;
	import Entities.Player;
	
	/**
	 * ...
	 * @author Kasene Clark
	 */
	public class GV 
	{
		
		// Global Variables
		public static var PARTICLE_EMITTER:ParticleController = new ParticleController;
		public static var PLAYER:Player = new Player;
		public static var GAMEHUD:HUD = new HUD;
		
		
		// Game Mechanics
		public static var GameScore:Number = 0;
		public static var GameLives:Number = 0;
		public static var GameKills:Number = 0;
		
		// Game Pace Variables
		public static var GameLevel:Number = 1;
		public static var GameDifficulty:Number = 2;
		public static var EnemyHealthMod:Number = 0; // Added To Health Of Enemy
		public static var Enemy_Spawn_Frequency:Number = 0;
		
	}

}