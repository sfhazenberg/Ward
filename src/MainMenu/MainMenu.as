package  MainMenu{
	
	import flash.desktop.NativeApplication;
	import flash.filesystem.File;
	
	import Level1.Level1;
	
	import ScreenSwitcher.ScreenSwitcher;
	
	import Settings.Settings;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	public class MainMenu extends Sprite {
		
		public var asset:AssetManager;
		
		public function MainMenu( screenSwitcher:ScreenSwitcher ) {
			addEventListener( Event.ADDED_TO_STAGE, initialize );
		}
		
		public function initialize (event:Event):void 
		{			
			asset = new AssetManager;
			var folder:File = File.applicationDirectory.resolvePath("MainMenu/assets");
			asset.enqueue( folder );
			asset.loadQueue( onProgress );
		}
		
		private function onProgress( ratio:Number ):void
		{
			if( ratio == 1 )
			{
				startMenu();
			}
		}
		
		private function startMenu() :void
		{
			var playButton:Button = new Button ( asset.getTexture ("PlayButtonUp"), "", asset.getTexture ("PlayButtonDown"));
			playButton.alignPivot();
			playButton.x = stage.stageWidth / 2;
			playButton.y = stage.stageHeight / 5 * 2;
			
			var settingsButton:Button = new Button ( asset.getTexture("SettingsButtonUp"), "", asset.getTexture("SettingsButtonDown"));
			settingsButton.alignPivot();
			settingsButton.x = stage.stageWidth / 2;
			settingsButton.y = stage.stageHeight / 5 * 3;
			
			var quitButton:Button = new Button ( asset.getTexture("QuitButtonUp"), "", asset.getTexture("QuitButtonDown"));
			quitButton.alignPivot();
			quitButton.x = stage.stageWidth / 2;
			quitButton.y =stage.stageHeight / 5 * 4;
			
			playButton.addEventListener( Event.TRIGGERED, loadLevel1Screen );
			addChild( playButton );
			
			settingsButton.addEventListener( Event.TRIGGERED, loadSettingsScreen );
			addChild( settingsButton );
			
			quitButton.addEventListener( Event.TRIGGERED, quitGame );
			addChild( quitButton );
		}
		
		public function loadLevel1Screen(e:Event):void 
		{
			ScreenSwitcher.ScreenSwitcher.getInstance().loadScreen( Level1 );
		}
		
		public function loadSettingsScreen(e:Event):void
		{
			ScreenSwitcher.ScreenSwitcher.getInstance().loadScreen( Settings );
		}
		
		public function quitGame(e:Event):void
		{
			NativeApplication.nativeApplication.exit();
		}
		
	}
	
}
