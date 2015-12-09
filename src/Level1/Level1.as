package  Level1{
	import flash.filesystem.File;
	
	import ScreenSwitcher.ScreenSwitcher;
	
	import Shop.ShopMenu;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
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
			var conceptBar:Image = new Image(asset.getTexture("TopBar"));
			addChild(conceptBar);
			
			var shopButton:Button = new Button (asset.getTexture("ExitButtonUp"), "", asset.getTexture("ExitButtonDown"));
			shopButton.x = stage.stageWidth - 100;
			shopButton.y = 50;
			shopButton.addEventListener( Event.TRIGGERED, goToShop)
			addChild(shopButton);
			
			var waitingRoom:Image = new Image(asset.getTexture("waiting_room"));
			waitingRoom.x = stage.stageWidth - 375;
			waitingRoom.y = stage.stageHeight - 329;
			addChild(waitingRoom);
			
			var supplyRoom:Image = new Image(asset.getTexture("supply_room"));
			supplyRoom.x = stage.stageWidth - 755;
			supplyRoom.y = stage.stageHeight - 329;
			addChild(supplyRoom);
			
			var treatmentRoom:Image = new Image(asset.getTexture("Treatment Room"));
			treatmentRoom.x = stage.stageWidth - 1135;
			treatmentRoom.y = stage.stageHeight - 329;
			addChild(treatmentRoom);
			
			//var doctor1:MovieClip = new MovieClip(asset.getTexture("Doctor Front mc"), 24);
			//Starling.juggler.add(doctor1);
			
		}
		
		private function goToShop (e:Event):void
		{
			ScreenSwitcher.ScreenSwitcher.getInstance().loadScreen( ShopMenu );
		}
		
		
	}
	
}
