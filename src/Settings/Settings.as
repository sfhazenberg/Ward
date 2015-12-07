package  Settings{
	
	import flash.desktop.NativeApplication;
	import flash.filesystem.File;
	
	import ScreenSwitcher.ScreenSwitcher;
	
	import starling.display.Button;
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
			var turnOnMusic:Button = new Button (asset.getTexture("OnButton"), "", asset.getTexture("OffButton"));
			turnOnMusic.x = stage.stageWidth / 2;
			turnOnMusic.y = stage.stageHeight / 5 * 2;
			
			var turnOnSound:Button = new Button (asset.getTexture("OnButton"), "", asset.getTexture("OffButton"));
			turnOnSound.x = stage.stageWidth / 2;
			turnOnSound.y = stage.stageHeight / 5 * 4;
			
			turnOnMusic.addEventListener( Event.TRIGGERED, music );
			addChild( turnOnMusic );
			
			turnOnSound.addEventListener( Event.TRIGGERED, sound );
			addChild( turnOnSound );
		}
		
		private function music (e:Event):void
		{
			
		}
		
		private function sound (e:Event):void 
		{
			
		}
	}
	
}

