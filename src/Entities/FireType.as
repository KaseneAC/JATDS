package Entities 
{
	/**
	 * ...
	 * @author Kasene Clark
	 */
	
	public class FireType
	{
		
		public static const FireType_Normal:int = 0;
		public static const FireType_Auto:int = 1;
		public static const FireType_AutoScatter:int = 2;
		public static const FireType_FluxScatter:int = 3;
		
		private var mType:int;
		
		public function FireType(_type:int = 0) {
			mType = _type;
		}
		
		public function setType(_type:int = 0):void
		{
			mType = _type;
		}
		
		public function getType():int
		{
			return mType;
		}
		
	}

}