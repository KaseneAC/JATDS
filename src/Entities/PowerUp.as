package Entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Kasene Clark
	 */
	public class PowerUp extends Entity
	{
		
		private var ImageSource:Image;
		private var VelocityX:Number = 0;
		private var VelocityY:Number = 0;
		
		
		public function PowerUp() 
		{
			
			ImageSource = new Image(GC.Asset_PowerUp);
			ImageSource.centerOO();
			graphic = ImageSource;
			
			// Collision Type
			type = "PowerUp"
			setHitbox(12, 12, 6, 6);
			
			
			// Layer
			//layer = GC.LAYER_ENEMY;
			
		}
		
		public function setVelocity(_x:Number = 0, _y:Number = 0):void
		{
			
			VelocityX = _x;
			VelocityY = _y;
			
		}
		
		public function destroy():void
		{
			FP.world.recycle(this);
		}
		
		override public function update():void
		{
			// Update Velocity
			x += VelocityX * FP.elapsed;
			y += VelocityY * FP.elapsed;
			
			// If bullet leaves the screen, destroy it
			if (y > FP.screen.height + 10)
			{
				destroy();
			}
			
			// Collide With Player
			var player:Player = collide("Player", x, y) as Player;
			if (player) {
				// Did collide with player
				this.destroy();
				GV.PARTICLE_EMITTER.collect_powerup(player.x, player.y);
				player.upgradeFireType();
				
			}
			
		}
		
	}

}