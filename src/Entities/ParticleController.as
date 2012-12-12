package Entities 
{
	
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.utils.Ease;
	
	/**
	 * ...
	 * @author Kasene Clark
	 */
	public class ParticleController extends Entity
	{
		private var emitter:Emitter;
		
		public function ParticleController() 
		{
			emitter = new Emitter(new BitmapData(3, 3, false, 0xFFFFFF), 3, 3);
			emitter.newType("explosion", [0]);
			emitter.setMotion("explosion", 0, 100, 2, 360, -40, 1, Ease.quadOut);
			emitter.setAlpha("explosion", 1, 0.1);
			
			emitter.newType("collect_powerup", [0]);
			emitter.setMotion("collect_powerup", 0, 75, 3, 360, -30, 1, Ease.quadOut);
			emitter.setColor("collect_powerup", 0x33FF00, 0x33FF00, Ease.quadOut);
			
			
			graphic = emitter;
			this.layer = GC.LAYER_PARTICLES;
			
		}
		
		public function explosion(_x:Number, _y:Number, particles:int = 20):void
		{
			for (var i:uint = 0; i < particles; i++ )
			{
				emitter.emit("explosion", _x, _y);
				emitter.emit("explosion", _x, _y);
			}
		}
		
		public function collect_powerup(_x:Number, _y:Number, particles:int = 20):void
		{
			for (var i:uint = 0; i < particles; i++ )
			{
				emitter.emit("explosion", _x, _y);
			}
		}
		
	}

}