package MainMenu
{
	
	import flash.desktop.NativeApplication;
	import flash.filesystem.File;
	
	import Level1.Level1;
	
	import Settings.Settings;
	
	import View.View;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	public class MainMenu extends Sprite {
		
		public var asset:AssetManager;
		
		public function MainMenu( ) {
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
			var background:Image = new Image (asset.getTexture("Background"));
			addChild(background);
			
			var playButton:Button = new Button ( asset.getTexture ("PlayButtonUp"), "", asset.getTexture ("PlayButtonDown"));
			playButton.alignPivot();
			playButton.x = 430;
			playButton.y = 520;
			
			var settingsButton:Button = new Button ( asset.getTexture("SettingsButtonUp"), "", asset.getTexture("SettingsButtonDown"));
			settingsButton.alignPivot();
			settingsButton.x = 430;
			settingsButton.y = 730;
			
			var quitButton:Button = new Button ( asset.getTexture("QuitButtonUp"), "", asset.getTexture("QuitButtonDown"));
			quitButton.alignPivot();
			quitButton.x = 430;
			quitButton.y = 940;
			
			playButton.addEventListener( Event.TRIGGERED, loadLevel1Screen );
			addChild( playButton );
			
			settingsButton.addEventListener( Event.TRIGGERED, loadSettingsScreen );
			addChild( settingsButton );
			
			quitButton.addEventListener( Event.TRIGGERED, quitGame );
			addChild( quitButton );
		}
		
		public function loadLevel1Screen(e:Event):void 
		{
			Destroy();
			View.View.getInstance().loadScreen( Level1.Level1 );
		}
		
		public function loadSettingsScreen(e:Event):void
		{
			View.View.getInstance().loadScreen( Settings );
		}
		
		public function quitGame(e:Event):void
		{
			NativeApplication.nativeApplication.exit();
		}
		
		private function Destroy():void
		{
			asset.dispose();
		}
	}
	
}
