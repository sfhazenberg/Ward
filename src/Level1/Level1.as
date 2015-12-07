package  Level1{
	import flash.filesystem.File;
	
	import ScreenSwitcher.ScreenSwitcher;
	
	import Shop.ShopMenu;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	public class Level1 extends Sprite {
		
		private var asset:AssetManager;

		public function Level1() {
			addEventListener( Event.ADDED_TO_STAGE, initialize );
		}

		public function initialize (event:Event):void 
		{			
			asset = new AssetManager;
			var folder:File = File.applicationDirectory.resolvePath("Level1/assets");
			asset.enqueue( folder );
			asset.loadQueue( onProgress );
		}
		
		private function onProgress( ratio:Number ):void
		{
			if( ratio == 1 )
			{
				startLevel1();
			}
		}
		
		private function startLevel1():void 
		{
			//var conceptBar:Image = new Image(asset.getTexture("ConceptBar"));
			//addChild(conceptBar);
			
			var shopButton:Button = new Button ( asset.getTexture("shopButton_PH" ));
			shopButton.x = 20;
			shopButton.y = 20;
			shopButton.addEventListener( Event.TRIGGERED, goToShop)
			addChild(shopButton);
		}
		
		private function goToShop (e:Event):void
		{
			this.screenSwitcher.loadScreen( ShopMenu );
		}
		
		
	}
	
}
