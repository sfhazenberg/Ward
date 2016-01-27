package MainInfo
{
	import flash.filesystem.File;
	import flash.utils.Timer;
	
	import Level1.Level1;
	import Level1.Tutorial;
	
	import MainMenu.MainMenu;
	
	import View.View;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	public class GameOver extends Sprite
	{		
		public var asset:AssetManager;
		
		public function GameOver() {
			addEventListener( Event.ADDED_TO_STAGE, initialize );
		}
		
		public function initialize (event:Event):void 
		{			
			asset = new AssetManager;
			var folder:File = File.applicationDirectory.resolvePath("MainInfo/assets");
			asset.enqueue( folder );
			asset.loadQueue( onProgress );
		}
		
		private function onProgress( ratio:Number ):void
		{
			if( ratio == 1 )
			{
				gameIsOver();
			}
		}
		public function gameIsOver():void
		{
			var over:Image = new Image (asset.getTexture("GameOver"));
			addChild(over);
			
			var overButton:Button = new Button (asset.getTexture("ButtonGameOver"));
			overButton.x = 1450;
			overButton.y = 850;
			addChild(overButton);
			overButton.addEventListener(Event.TRIGGERED, overButtonTrigerred);
		}
		
		private function overButtonTrigerred():void
		{
			View.View.getInstance().loadScreen(MainMenu);
		}
	}
}