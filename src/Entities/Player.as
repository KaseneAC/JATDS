package Entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	import Entities.FireType;
	
	/**
	 * ...
	 * @author Kasene Clark
	 */
	
	 
	public class Player extends Entity
	{
		
		private var SourceImage:Image;
		private var MoveSpeed:Number = 300;
		private var RoundFireTimer:Number = 0;
		private var NormalRoundFreq:Number = 0.3; // Per Second
		private var PlayerFireType:FireType = new FireType(FireType.FireType_Normal);
		private var FluxScatterCount:Number = 0;
		private var ScatterAccuracy:Number = 0; // Negitive Increases, Positive Decreases
		
		
		public var Spr:Spritemap = new Spritemap(GC.Asset_PlayerSprite, 41, 40);
		
		public function Player() 
		{
			// Animations
			Spr.add("idle", [1], 1, true);
			Spr.add("left", [0], 1, true);
			Spr.add("right", [2], 1, true);
			
			// Input Defines
			Input.define("left", Key.LEFT);
			Input.define("right", Key.RIGHT);
			Input.define("fire", Key.A);
			
			// Collision Type
			type = "Player";
			setHitbox(40, 40, 20, 20);
			
			SourceImage = Spr;
			SourceImage.centerOO();
			
			//Layer
			layer = GC.LAYER_PLAYER;
			
			graphic = SourceImage;
		}
		
		public function shootBullet(_velx:Number = 0, _vely:Number = 0):void
		{
			var firedRound:Bullet = FP.world.create(Bullet) as Bullet;
			firedRound.x = x;
			firedRound.y = y;
			firedRound.setVelocity(_velx, _vely);
			FP.world.add(firedRound);
		}
		
		public function upgradeFireType():void
		{
			
			var Flash:FlashText;
			
			if (PlayerFireType.getType() >= 3) {
				return;
			}else {
				PlayerFireType.setType(PlayerFireType.getType() + 1); // Set The Type
				switch (PlayerFireType.getType())
				{
					case FireType.FireType_Auto: {
						Flash = new FlashText("Fully Automatic!", x, y);
						break;
					}
					
					case FireType.FireType_AutoScatter: {
						Flash = new FlashText("Scattershot!", x, y);
						break;
					}
					
					case FireType.FireType_FluxScatter: {
						Flash = new FlashText("Flux Cannon!", x, y);
						break;
					}
				}
			}
		}
		
		public function resetFireType():void 
		{
			PlayerFireType.setType(FireType.FireType_Normal);
		}
		
		public function handleFire():void
		{
			
			if (Input.check("fire")) { // If the fire button was pressed
				
				switch (PlayerFireType.getType())
				{
					case FireType.FireType_Normal: {
						if (RoundFireTimer >= NormalRoundFreq){
						shootBullet(0, -400)
						RoundFireTimer = 0;
						}
						break;
					}
					
					case FireType.FireType_Auto:{
						if (RoundFireTimer >= 0.1){
						shootBullet(0, -400);
						RoundFireTimer = 0;
						}
						break;
					}
					
					case FireType.FireType_AutoScatter: {
						if (RoundFireTimer >= 0.3) {
						shootBullet(100 - ScatterAccuracy, -400);
						shootBullet(0, -400);
						shootBullet( -100 + ScatterAccuracy, -400);
						RoundFireTimer = 0;
						}
						break;
					}
					
					
					case FireType.FireType_FluxScatter: {
						if (RoundFireTimer >= 0.06) {
						if (FluxScatterCount == 0){	
							shootBullet(100 + ScatterAccuracy, -400);
							FluxScatterCount++;
						} else if (FluxScatterCount == 1){
							shootBullet(0, -400);
							FluxScatterCount++;
						} else if (FluxScatterCount == 2){
							shootBullet( -100 - ScatterAccuracy, -400);
							FluxScatterCount++;
						} else if (FluxScatterCount == 3){
							shootBullet(0, -400);
							FluxScatterCount = 0;
						}
						RoundFireTimer = 0;
						}
						break;
					}
					
				}
				

				
			}
			

			RoundFireTimer += FP.elapsed;
			
			
		}
		
		public function death():void
		{
			SourceImage.alpha = 0;
			
			this.x = FP.screen.width / 2;
			this.y = FP.world.camera.y + 540;
			
			resetFireType();
			
		}
		
		override public function update():void
		{
			
				Spr.play("idle");
			
				if (Input.check("left")) {
					Spr.play("left"); // Play Anim
					
					if (x >= 0 + 25) // Control Bounds
					{
						x -= MoveSpeed * FP.elapsed;
					}
				}else if (Input.check("right")) {
					Spr.play("right"); // Play Anim
					
					if (x <= FP.screen.width - 25) // Control Bounds
					{
						x += MoveSpeed * FP.elapsed;
					}
				}
				
				handleFire();

			
				var enemy:Enemy = collide("Enemy", x, y) as Enemy;
				if (enemy) {
					// Player Dies
					GV.PARTICLE_EMITTER.explosion(enemy.x, enemy.y);
					enemy.destroy();
					GV.PARTICLE_EMITTER.explosion(this.x, this.y);
					this.death();
				}
				
				if (SourceImage.alpha < 1) {
					SourceImage.alpha += FP.elapsed;
				}
			
			
		}
		
	}

}