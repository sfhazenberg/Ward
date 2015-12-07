package Main
{		
	import ScreenSwitcher.ScreenSwitcher;
	
	import starling.display.Sprite;

	public class Loader extends Sprite
	{
		public function Loader()
		{
			addChild(ScreenSwitcher.ScreenSwitcher.getInstance());
		}
	}
}