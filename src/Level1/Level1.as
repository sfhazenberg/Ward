package  Level1{
	import flash.filesystem.File;
	
	import MainInfo.MainInfo;
	
	import ScreenSwitcher.ScreenSwitcher;
	
	import Shop.ShopMenu;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	public class Level1 extends MainInfo {
		
		private var asset:AssetManager;
		private var animation:MovieClip;
		
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
			var shopButton:Button = new Button (asset.getTexture("ExitButtonUp"), "", asset.getTexture("ExitButtonDown"));
			shopButton.x = stage.stageWidth - 100;
			shopButton.y = 50;
			shopButton.addEventListener( Event.TRIGGERED, goToShop)
			addChild(shopButton);
			
			//array that stores the images of the rooms
			var rooms:Array = new Array();
			rooms.push(new Image(asset.getTexture("waiting_room")));
			rooms[0].x = stage.stageWidth - 375;
			rooms[0].y = stage.stageHeight - 329;
			addChild(rooms[0]);
			
			//rooms.removeAt[0];
			//removeChild(rooms[0]);
			
			rooms.push(new Image(asset.getTexture("supply_room")));
			rooms[1].x = stage.stageWidth - 755;
			rooms[1].y = stage.stageHeight - 329;
			addChild(rooms[1]);
			
			rooms.push(new Image(asset.getTexture("Treatment Room")));
			rooms[2].x = stage.stageWidth - 1135;
			rooms[2].y = stage.stageHeight - 329;
			addChild(rooms[2]);
			
			
			/*var waitingRoom:Image = new Image(asset.getTexture("waiting_room"));
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
			addChild(treatmentRoom);*/
			
			animation = new MovieClip( asset.getTextures( "Doctor Front mc" ), 24 );
			animation.x = animation.y = 300;
			Starling.juggler.add( animation );
			addChild( animation );
			
		}
		
		private function goToShop (e:Event):void
		{
			ScreenSwitcher.ScreenSwitcher.getInstance().loadScreen( ShopMenu );
		}
		
		
	}
	
}
