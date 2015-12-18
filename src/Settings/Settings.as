package Settings
{
	
	import flash.filesystem.File;
	
	import MainMenu.MainMenu;
	
	import View.View;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	public class Settings extends Sprite {
		
		public var asset:AssetManager;

		public function Settings() {
			addEventListener( Event.ADDED_TO_STAGE, initialize );
		}
		
		public function initialize (event:Event):void 
		{			
			asset = new AssetManager;
			var folder:File = File.applicationDirectory.resolvePath("Settings/assets");
			asset.enqueue( folder );
			asset.loadQueue( onProgress );
		}
		
		private function onProgress( ratio:Number ):void
		{
			if( ratio == 1 )
			{
				startSettings();
			}
		}
		
		private function startSettings():void 
		{
			var background:Image = new Image(asset.getTexture("settingsBackgr"));
			addChild( background );
			
			var turnOnMusic:Button = new Button (asset.getTexture("OnButton"), "", asset.getTexture("OffButton"));
			turnOnMusic.x = stage.stageWidth / 2;
			turnOnMusic.y = stage.stageHeight / 5 * 1.8;
			
			var turnOnSound:Button = new Button (asset.getTexture("OnButton"), "", asset.getTexture("OffButton"));
			turnOnSound.x = stage.stageWidth / 2;
			turnOnSound.y = stage.stageHeight / 5 * 3.2;
		
			turnOnMusic.addEventListener( Event.TRIGGERED, music );
			addChild( turnOnMusic );
			
			turnOnSound.addEventListener( Event.TRIGGERED, sound );
			addChild( turnOnSound );
			
			var backToMenu:Button = new Button (asset.getTexture("ExitButtonUp"), "", asset.getTexture("ExitButtonDown"));
			backToMenu.x = stage.stageWidth - 150;
			backToMenu.y = 20;
			
			backToMenu.addEventListener( Event.TRIGGERED, exitSettings );
			addChild( backToMenu );
		}
		
		private function music (e:Event):void
		{
			
		}
		
		private function sound (e:Event):void 
		{
			
		}
		
		private function exitSettings (e:Event):void 
		{
			View.View.getInstance().loadScreen( MainMenu );
		}
	}
	
}

