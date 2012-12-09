package Entities 
{
	import adobe.utils.ProductManager;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Kasene Clark
	 */
	public class Bullet extends Entity
	{
		
		private var ImageSource:Image;
		private var VelocityX:Number = 0;
		private var VelocityY:Number = 0;
		private var EnemyRound:Boolean = false;
		
		public function Bullet() 
		{
			
			ImageSource = new Image(GC.Asset_Bullet);
			ImageSource.centerOO();
			graphic = ImageSource;
			
			// Collision Type
			type = "Bullet";
			setHitbox(9, 12, 9 / 2, 6);
			
			// Layer
			layer = GC.LAYER_BULLETS;
			
		}
		
		public function isEnemyRound():void
		{
			EnemyRound = true;
			ImageSource.color = 0xFF0F0F;
			ImageSource.tinting = 1;
			graphic = ImageSource;
		}
		
		public function setVelocity(_x:Number = 0, _y:Number = 0):void
		{
			VelocityX = _x;
			VelocityY = _y;
		}
		
		override public function update():void
		{
			x += VelocityX * FP.elapsed;
			y += VelocityY * FP.elapsed;
			
			// If bullet leaves the screen, destroy it
			if (y < FP.world.camera.y || y > FP.screen.height + 10 || x < 0 + 20 || x > FP.screen.width + 10)
			{
				destroy();
			}
			
			// Hit Enemy
			var enemy:Enemy = collide("Enemy", x, y) as Enemy;
			if (enemy)
			{
				if (!EnemyRound)
				{
				// Enemy Looses Health
				enemy.takeHit();
				this.destroy();
				}
			}
			
			var player:Player = collide("Player", x, y) as Player;
			if (player && EnemyRound)
			{
				GV.PARTICLE_EMITTER.explosion(player.x, player.y);
				player.death();
				this.destroy();
			}
			
			
		}
		
		public function destroy():void
		{
			FP.world.remove(this);
		}
		
	}

}