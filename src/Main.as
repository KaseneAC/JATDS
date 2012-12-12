package 
{

	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Kasene Clark
	 */
	public class Main extends Engine
	{
		
		public function Main():void 
		{
			// Set Flashpunk Up
			super(800, 600, 60, false);
			
			// Turn The Console On
			FP.console.enable();
			
			// Set The World
			FP.world = new GameWorld;
		}
		
		override public function init():void
		{
			//this.addChild(new TheMiner());  
		}
		
		
	}
	
}