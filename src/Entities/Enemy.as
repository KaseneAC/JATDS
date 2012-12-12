package Entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import Entities.EnemyType;
	/**
	 * ...
	 * @author Kasene Clark
	 */
	public class Enemy extends Entity
	{
		
		private var ImageSource:Image = null;
		private var VelocityX:Number = 0;
		private var VelocityY:Number = 0;
		private var SpeedMod:Number = 0;
		private var EType:EnemyType;
		private var Health:Number;
		private var Behavior:EnemyBehavior;
		

		public function Enemy() 
		{
			EType = new EnemyType;
			Behavior = new EnemyBehavior;
			
			
			ImageSource = new Image(GC.Asset_EnemySprite);
			ImageSource.centerOO();
			
			
			graphic = ImageSource;
			
			
			layer = GC.LAYER_ENEMY;
			
			// Collision Type
			type = "Enemy";
			setHitbox(30, 30, 15, 15);
			
		}
		
		
		public function setBehavior(_behavior:int):void
		{
			Behavior.setBehavior(_behavior);
		}
		
		public function takeHit():void
		{
			Health--;
			var Flash:FlashText;
			GV.PARTICLE_EMITTER.explosion(x, y, 3);
			
			
			
			if (Health <= 0)
			{
				// Enemy Dies
				GV.PARTICLE_EMITTER.explosion(x, y);
				destroy();
				
				// Count The Kill
				GV.GameKills++;
				
				// Calculate Score
				switch (EType.getType())
				{
					case EnemyType.ENEMY_BASIC: {
						GV.GameScore += 100;
						Flash = new FlashText("+100", x, y);
						break;
					}
					
					case EnemyType.ENEMY_MED: {
						GV.GameScore += 200;
						Flash = new FlashText("+200", x, y);
						break;
					}
					
					case EnemyType.ENEMY_HARD: {
						GV.GameScore += 300;
						Flash = new FlashText("+300", x, y);
						break;
					}
					
					case EnemyType.ENEMY_EXTREME: {
						GV.GameScore += 400;
						Flash = new FlashText("+400", x, y);
						break;
					}
					
				}
				
			}else {
				
				// Enemy Simply Took Some Damage
				// Award Player Some Score
				
				var RandScore:Number = 0;
				
				do // Calculate Random Number Between 10 - 25
				{
					RandScore = FP.rand(26)
				}while (RandScore < 10);
				
				GV.GameScore += RandScore;
				Flash = new FlashText("+" + RandScore.toString(), x, y);
				
			}
		}
		
		public function setEnemyType(_type:int):void
		{
			EType.setType(_type);
			switch (EType.getType())
			{
				case EnemyType.ENEMY_BASIC: {
					Health = 2;
					SpeedMod = 10;
					ImageSource.color = 0x8CFF1A;
					ImageSource.tinting = 0.7;
					this.graphic = ImageSource;
					break;
				}
				
				case EnemyType.ENEMY_MED: {
					Health = 4;
					SpeedMod = 25;
					ImageSource.color = 0xFFFF1A;
					ImageSource.tinting = 0.7;
					this.graphic = ImageSource;
					break;
				}
				
				case EnemyType.ENEMY_HARD: {
					Health = 7;
					SpeedMod = 45;
					ImageSource.color = 0xFF8C1A;
					ImageSource.tinting = 0.7;
					this.graphic = ImageSource;
					break;
				}
				
				case EnemyType.ENEMY_EXTREME: {
					Health = 11;
					SpeedMod = 60;
					ImageSource.color = 0xFF0F0F;
					ImageSource.tinting = 0.7;
					this.graphic = ImageSource;
					break;
				}
				
			}
		}
		
		public function handleTypeSpecific():void // Incase We Ever Need To Do This
		{

			switch (EType.getType())
			{
				case EnemyType.ENEMY_BASIC: {
					
					break;
				}
				
				case EnemyType.ENEMY_MED: {
					
					break;
				}
				
				case EnemyType.ENEMY_HARD: {
					
					break;
				}
				
				case EnemyType.ENEMY_EXTREME: {
					
					break;
				}
				
			}
			
		}
		
		public function setVelocity(_x:Number = 0, _y:Number = 0):void
		{
			VelocityX = _x;
			VelocityY = _y;
		}
		
		public function shootBullet(_velx:Number = 0, _vely:Number = 0):void
		{
			var firedRound:Bullet = FP.world.create(Bullet) as Bullet;
			firedRound.x = x;
			firedRound.y = y;
			firedRound.isEnemyRound();
			firedRound.setVelocity(_velx, _vely);
			FP.world.add(firedRound);
		}
		
		private var ShotTimer:Number = 0;
		private var ShotFreq:Number = 1;
		
		public function handleShooting():void
		{
			
			if (ShotTimer >= ShotFreq)
			{
				shootBullet(0, 240);
				ShotTimer = 0;
				
			}else
			{
				ShotTimer += FP.elapsed;
			}
			
		}
		
		override public function update():void 
		{
			
			
			
			// Handle Behaviors
			switch(Behavior.getBehavior())
			{
				case EnemyBehavior.ENEMY_STATIC: {
					this.setVelocity(0, 100);
					break;
				}
				
				case EnemyBehavior.ENEMY_STATIC_SHOOTING: {
					this.setVelocity(0, 100);// Set Regular Velocity
					
					handleShooting();
					
					break;
				}
				
				case EnemyBehavior.ENEMY_BOUNCE: {
					this.setVelocity(100, 100);// Set Regular Velocity
					
					
					
					break;
				}
				
				
			}
			
			// Calculate Velocity
			x += VelocityX * FP.elapsed;
			y += (VelocityY - SpeedMod) * FP.elapsed;
			
			
			// If The Enemy is Touching Another Enemy
			// Adjust Position Slowly
			
			var friend:Enemy = collide("Enemy", x, y) as Enemy;
			if (friend)
			{
				friend.x += 30;
			}
			
			// If the enemy leaves the bottom of the screen, destroy it
			if (y >= FP.world.camera.y + FP.screen.height + 50 ) {
				destroy();
			}
		}
		
		public function destroy():void {
			FP.world.recycle(this);
		}
		
	}

}