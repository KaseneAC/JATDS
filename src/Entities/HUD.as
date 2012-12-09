package Entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	
	
	/**
	 * ...
	 * @author Kasene Clark
	 */
	public class HUD extends Entity
	{
		
		private var HUDScore:Text;
		private var HUDLives:Text;
		private var HUDLevel:Text;
		private var offset:Number = 20;
		
		public function HUD() 
		{
			HUDScore = new Text("Score: 0", 110, 0);
			HUDLives = new Text("Lives: 0", 10, 0);
			HUDLevel = new Text("Level: 0", 10, 560);
			
			addGraphic(HUDLives);
			addGraphic(HUDScore);
			addGraphic(HUDLevel);
			
			
			layer = -100;
			
		}
		
		public function setScore(_score:Number):void
		{
			HUDScore.text = "Score: " + _score.toString();
		}
		
		public function setLives(_lives:Number):void
		{
			HUDLives.text = "Lives: " + _lives.toString();
		}
		
		public function setLevel(_level:Number):void
		{
			HUDLevel.text = "Level: " + _level.toString();
		}
		
		override public function update():void
		{
			// Offset The Camera
			y = FP.world.camera.y + offset
		}
		
	}

}