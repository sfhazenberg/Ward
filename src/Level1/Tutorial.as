package Level1
{
	import flash.filesystem.File;
	
	import View.View;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	public class Tutorial extends Sprite
	{
		private var asset:AssetManager;
		private var tutorialFirst:Image;
		private var tutorialSecond:Image;
		private var nextPage:Button;
		private var back:Button;
		private var backButton:Button;
		
		public function Tutorial()
		{
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
		
		private function Initialize():void{
			asset = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("Level1/assets");
			asset.enqueue(folder);
			asset.loadQueue(onProgress);
		}
		
		private function onProgress(ratio:Number):void
		{
			if(ratio == 1)
			{
				start();
			}
		}
		
		private function start():void
		{
			tutorialFirst = new Image ( asset.getTexture("TutorialOneScreen"));
			addChild(tutorialFirst);
			
			var nextPage:Button = new Button (asset.getTexture("NextPageButton"));
			nextPage.x = 1700;
			nextPage.y = 870;
			addChild(nextPage);
			nextPage.addEventListener ( Event.TRIGGERED, nextTutorialScreen );
			
			back = new Button (asset.getTexture("BackButton"));
			back.x = 1700;
			back.y = 30;
			addChild(back);
			back.addEventListener (Event.TRIGGERED, backToGame);
		}
		
		private function nextTutorialScreen(e:Event):void
		{
			removeChild(tutorialFirst);
			tutorialSecond = new Image ( asset.getTexture("TutorialTwoScreen"));
			addChild(tutorialSecond);
			
			backButton = new Button (asset.getTexture("BackButtonTwo"));
			backButton.x = 1700;
			backButton.y = 30;
			addChild(backButton);
			backButton.addEventListener(Event.TRIGGERED, backToTutorialOne);
		}
		
		private function backToGame(e:Event):void
		{
			View.View.getInstance().loadScreen(Level1);
		}
		
		private function backToTutorialOne(e:Event):void
		{
			removeChild(tutorialSecond);
			removeChild(backButton);
			start();
		}
	}
}