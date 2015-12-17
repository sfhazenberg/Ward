package MainInfo
{
	import MainInfo.TopBar;
	import View.View;
	
	import starling.display.Sprite;
	
	public class DayReview extends Sprite
	{
		private var topBar:TopBar = new TopBar();
		
		public function DayReview()
		{
			addChild(View.View.getInstance().getTopBar());
		}
	}
}