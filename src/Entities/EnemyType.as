package Entities 
{
	/**
	 * ...
	 * @author Kasene Clark
	 */
	public class EnemyType 
	{
		
		public static const ENEMY_BASIC:int = 0; // 2 Hits
		public static const ENEMY_MED:int = 1; // 4 Hits
		public static const ENEMY_HARD:int = 2; // 7 Hits
		public static const ENEMY_EXTREME:int = 3; // 11 Hits
		
		private var _ETYPE:int;
		
		public function setType(_Type:int):void
		{
			_ETYPE = _Type;
		}
		
		public function getType():int
		{
			return _ETYPE;
		}
		
	}

}