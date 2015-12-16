package Main
{		
	import View.View;
	
	import starling.display.Sprite;

	public class Loader extends Sprite
	{
		public function Loader()
		{
			addChild(View.View.getInstance());
		}
	}
}