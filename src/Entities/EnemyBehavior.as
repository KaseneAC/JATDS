package Entities 
{
	/**
	 * ...
	 * @author Kasene Clark
	 */
	public class EnemyBehavior 
	{
		
		public static const ENEMY_STATIC:int = 0; // Just flies straight ahead
		public static const ENEMY_BOUNCE:int = 1; // Bounces back and forth across the screen
		public static const ENEMY_STATIC_SHOOTING:int = 3;
		
		private var _behavior:int;
		
		public function setBehavior(_set:int):void
		{
			_behavior = _set;
		}
		
		public function getBehavior():int
		{
			return _behavior;
		}
		
		
	}

}