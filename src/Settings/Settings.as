﻿package Settings
{
	
	import flash.filesystem.File;
	
	import Cutscenes.OpeningCutscene;
	
	import MainMenu.MainMenu;
	
	import View.View;
	
	import starling.display.Button;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	public class Settings extends Sprite {
		
		public var asset:AssetManager;
		private var MovieClip:DisplayObjectContainer;
		private var cutscene:OpeningCutscene = new OpeningCutscene(MovieClip);
		
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
			var background:Image = new Image(asset.getTexture("SettingsBackground"));
			addChild( background );
			
			/*var turnOnMusic:Button = new Button (asset.getTexture("OnButton"), "", asset.getTexture("OffButton"));
			turnOnMusic.x = stage.stageWidth / 2;
			turnOnMusic.y = stage.stageHeight / 5 * 1.8;
			turnOnMusic.addEventListener( Event.TRIGGERED, music );
			addChild( turnOnMusic );*/
			
			var turnOnSound:Button = new Button (asset.getTexture("SoundOn"));
			turnOnSound.x = 570;
			turnOnSound.y = stage.stageHeight / 5 * 3.2;
		
			turnOnSound.addEventListener( Event.TRIGGERED, sound );
			addChild( turnOnSound );
			
			var backToMenu:Button = new Button (asset.getTexture("BackButton"));
			backToMenu.x = 1730;
			backToMenu.y = 880;
			
			backToMenu.addEventListener( Event.TRIGGERED, exitSettings );
			addChild( backToMenu );
		
			/////////////////////////////
			var testImage:Button = new Button(asset.getTexture("TEST"));
			testImage.x = 960;
			testImage.y = 400;
			testImage.addEventListener(Event.TRIGGERED, Cutscene);
			addChild(testImage);
			/////////////////////////////
		}
		
		/////////////////////////////////////////////////////
		public function getCutscene(OpeningCutscene:Boolean):void
		{
			//var cutscene = OpeningCutscene.
			//return cutscene;
		}
		
		private function Cutscene(value:Boolean):void
		{
			//Cutscenes.OpeningCutscene(checker = true);
			
		}
		/////////////////////////////////////////////////////
		
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

