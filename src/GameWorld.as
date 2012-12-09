package  
{	
	import adobe.utils.ProductManager;
	import Entities.Bullet;
	import Entities.Enemy;
	import Entities.FlashText;
	import Entities.HUD;
	import Entities.ParticleController;
	import Entities.Player;
	import Entities.PowerUp;
	import Entities.EnemyBehavior;
	import Entities.EnemyType;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Kasene Clark
	 */
	
	public class GameWorld extends World
	{

		public function GameWorld() 
		{
			PlayerSetup();
			FXSetup();
			HUDSetup();
			BackgroundSetup();
			GameSetup();
		}
		
		override public function update():void
		{
			super.update();
			
			HUDUpdate();
			CameraUpdate();
			HandleGamePace();
			//TempGamePace();
			
		}
		
		
		//---------------SETUP-METHODS-----------------------------------------------------------------
		
		// Player Setup
		public function PlayerSetup():void
		{
			// Player Setup
			GV.PLAYER = new Player;
			// Positioning
			GV.PLAYER.x = FP.screen.width / 2;
			GV.PLAYER.y = 540;
			add(GV.PLAYER);
		}
		
		// Effects Setup
		public function FXSetup():void
		{
			// Particle Setup
			GV.PARTICLE_EMITTER = new ParticleController;
			add(GV.PARTICLE_EMITTER);
		}
		
		
		// HUD Setup
		public function HUDSetup():void
		{
			// HUD
			GV.GAMEHUD = new HUD;
			add(GV.GAMEHUD);
		}
		
		// Background Setup
		public function BackgroundSetup():void
		{
			// Background
			var BGIMG:Backdrop = new Backdrop(GC.Asset_Background, true, true);
			var BGENT:Entity = new Entity;
			BGENT.x = 1000;
			BGENT.graphic = BGIMG;
			BGENT.layer = 50;
			add(BGENT);
		}
		
		// Game Mechanics Setup
		public function GameSetup():void
		{
			// Setup Lives
			GV.GameLives = 3;
		}
		
		//------------------UPDATE-METHODS------------------------------------------------------------
		
		// Update HUD
		public function HUDUpdate():void
		{
			GV.GAMEHUD.setLives(GV.GameLives);
			GV.GAMEHUD.setScore(GV.GameScore);
			GV.GAMEHUD.setLevel(GV.GameLevel);
		}
		
		
		// Camera Vars
		private var CameraSpeed:Number = 30;
		// Update Camera
		public function CameraUpdate():void
		{
			// Background Scroll
			camera.y -= CameraSpeed * FP.elapsed;
			// Player Offset
			GV.PLAYER.y -= CameraSpeed * FP.elapsed;
		}
		
		// Timers
		private var Enemy_Spawn_Timer:Number = 0;
		
		// Booleans
		private var Should_Spawn_PowerUp:Boolean = false;
		private var SquadSpawn:Boolean = false;
		
		// Mod
		private var MasterMod:Number = 10;
		
		// Squad Spawns
		public static const FiveBasic:int = 0;
		
		
		public function HandleGamePace():void
		{
			// NOTE: Level Progression Based On Score & Kills
			// The better the player is doing, the harder the game gets.
			
			// Check Kills To Determine If We Should Progress To The Next Level
			if (GV.GameKills == (MasterMod * GV.GameLevel))
			{
				GV.GameLevel++;
				// Set Game Difficuly
				GV.GameDifficulty += 0.5;
				// Get PowerUp
				Should_Spawn_PowerUp = true;
				// Reset Kill Count
				GV.GameKills = 0;
				// Add To Camera Speed
				CameraSpeed += 10;
				// Notify Player
				var Flash:FlashText = new FlashText("Level " + GV.GameLevel, GV.PLAYER.x, GV.PLAYER.y);
			}
			
			// Check Level To Determine The Spawn Frequency, Enemy Health Mods
			// We Want the spawn frequency to be lower, the higher the level is
			GV.Enemy_Spawn_Frequency = MasterMod / GV.GameDifficulty;
			GV.EnemyHealthMod = GV.GameLevel;
			
			// Enemy Spawning
			if (Enemy_Spawn_Timer >= GV.Enemy_Spawn_Frequency)
			{
				// Check Level & Score To Determine What Behaviors The Ships Have
				
				
				// Determine Squad Spawn
				var i:int = FP.rand(100);
				if (i <= 100 / 4)
				{
					SquadSpawn = true;
					
				}else
				{
					SquadSpawn = false;
				}
				
				if (SquadSpawn)
				{
					// Determine Spawn Type
					var SpawnType:int = FP.rand(1);
					
					switch(SpawnType)
					{
						
						case FiveBasic: { // Five Basic
							
							for (var x:int = 0; x < 5; x++)
							{
								SpawnShip(EnemyBehavior.ENEMY_STATIC_SHOOTING, EnemyType.ENEMY_BASIC);
							}
							
							break;
						}
						
						
					}
					
					Enemy_Spawn_Timer = 0;
					
				}else{ // Regular Spawn
					
					SpawnShip(EnemyBehavior.ENEMY_STATIC, FP.rand(4));
					Enemy_Spawn_Timer = 0;
				}
				
			} else
			{
				Enemy_Spawn_Timer += FP.elapsed;
			}
			
			
			// PowerUp Spawning
			if (Should_Spawn_PowerUp)
			{
				// Spawn PowerUp
				
				var newPowerUp:PowerUp = create(PowerUp) as PowerUp;
				newPowerUp.x = FP.rand(FP.screen.width - 40);
				newPowerUp.y = camera.y - 50;
				newPowerUp.setVelocity(0, 70);
				add(newPowerUp);
				
				Should_Spawn_PowerUp = false;
				
			} else
			{
				// Check Score To Determine If The Player Deserves A Power Up
			}
			
			
		}
		
		
		public function SpawnShip(_behavior:int, _enemytype:int):void
		{
			// Spawn A Ship
			var newEnemy:Enemy = create(Enemy) as Enemy;
			
			// Make Sure The Enemy Doesn't Spawn Too Close To The Left or Right
			var XSpawn:Number = 0;
			do
			{
				XSpawn = FP.rand(FP.screen.width); 
			}while (XSpawn <= 100 && XSpawn >= FP.screen.width + 100); 
			
			newEnemy.x = XSpawn; // Set Adjusted Value
			newEnemy.y = camera.y - 50; // Just Above The Screen
			newEnemy.setBehavior(_behavior); // Set Behavior
			newEnemy.setEnemyType(_enemytype); // Set The Enemy Type At Random*
			add(newEnemy);
		}
		
		// Temporary Enemy Spawning
		private var EnemySpawnTimer:Number = 0;
		private var EnemySpawnFreq:Number = 1; 
		// Temporary PowerUp Spawning
		private var PowerUpSpawnTimer:Number = 0;
		private var PowerUpSpawnFreq:Number = 10;
		
		public function TempGamePace():void // Random Ships Flying At You At No Pace, Testing Only!
		{
			// Enemy Spawning
			if (EnemySpawnTimer >= EnemySpawnFreq) {
				
				var newEnemy:Enemy = create(Enemy) as Enemy;
				newEnemy.x = FP.rand(FP.screen.width - 40);
				newEnemy.y = camera.y - 50;
				newEnemy.setVelocity(0, 100);
				newEnemy.setEnemyType(FP.rand(3));
				add(newEnemy);
				
				EnemySpawnTimer = 0;
			}else {
				
				EnemySpawnTimer += FP.elapsed;
			}
			
			// Power Up Spawning
			if (PowerUpSpawnTimer >= PowerUpSpawnFreq) {
				

				
				PowerUpSpawnTimer = 0;
				
			}else {
				PowerUpSpawnTimer += FP.elapsed;
			}
		}
		

		
	}

}