package Main
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.geom.Rectangle;
	
	import MainMenu.MainMenu;
	
	import View.View;
	
	import starling.core.Starling;
	
	public class WARD extends Sprite
	{
		public function WARD()
		{
			super();
			
			stage.align = StageAlign.TOP_LEFT;
			
			var screenWidth:int = stage.fullScreenWidth;
			var screenHeight:int = stage.fullScreenHeight;
			var viewPort:Rectangle = new Rectangle(0, 0, screenWidth, screenHeight);

			var starlingInstance:Starling = new Starling(Loader, stage, viewPort);
			starlingInstance.stage.stageWidth = 1920;
			starlingInstance.stage.stageHeight = 1080;
			starlingInstance.start();
		}
	}
}