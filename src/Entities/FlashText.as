package Entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Kasene Clark
	 */
	public class FlashText extends Entity
	{
		
		private var TextToFlash:Text;
		
		public function FlashText(_text:String, _x:Number, _y:Number)
		{
			
			TextToFlash = new Text(_text, _x, _y);
			TextToFlash.centerOO();
			graphic = TextToFlash;
			FP.world.add(this);
			
			
		}
		
		override public function update():void
		{
			y -= 40*FP.elapsed;
			
			if (TextToFlash.alpha > 0) {
				
				TextToFlash.alpha -= FP.elapsed;
				
			}else
			{
				destroy();
			}
			
		}
		
		public function destroy():void
		{
			FP.world.recycle(this);
		}
		
		
	}

}