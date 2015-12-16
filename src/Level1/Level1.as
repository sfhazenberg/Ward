package  Level1{
	
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.utils.Timer;
	
	import MainInfo.TopBar;
	
	import Shop.ShopMenu;
	
	import View.View;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	
	public class Level1 extends Sprite {
		
		[Embed(source="assets/spritesheet_doctor.xml", mimeType="application/octet-stream")]
		public static const AtlasXML:Class;
		[Embed(source="assets/spritesheet_doctor.png")]
		public static const AtlasTexture:Class;
		//public static var asset:AssetManager;
		private var doctor1:MovieClip;
		var texture:Texture = Texture.fromEmbeddedAsset(AtlasTexture);
		var xml:XML = XML(new AtlasXML());
		var atlas:TextureAtlas = new TextureAtlas(texture, xml);
		private var asset:AssetManager;
		private var topBar:TopBar = new TopBar();
		private var timer:Timer;
		
		
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
			addChild(topBar);
			
			timer = new Timer(10000,1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, dayFinished);
			
			var shopButton:Button = new Button (asset.getTexture("ExitButtonUp"), "", asset.getTexture("ExitButtonDown"));
			shopButton.x = stage.stageWidth - 95;
			shopButton.y = 30;
			shopButton.addEventListener( Event.TRIGGERED, goToShop)
			addChild(shopButton);
			
			//array that stores the images of the built rooms
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
			
			//array that holds grid views of empty rooms
			var grids:Array = new Array();
			grids.push(new Image(asset.getTexture("grid_waitingroom")));
			grids[0].x = stage.stageWidth - 1500;
			grids[0].y = stage.stageHeight - 925;
			addChild(grids[0]);
			
			grids.push(new Image(asset.getTexture("grid_supplyroom")));
			grids[1].x = stage.stageWidth - 1125;
			grids[1].y = stage.stageHeight - 925;
			addChild(grids[1]);
			
			grids.push(new Image(asset.getTexture("grid_treatmentroom")));
			grids[2].x = stage.stageWidth - 750;
			grids[2].y = stage.stageHeight - 925;
			addChild(grids[2]);
			//addChild event needs to be alongside the shop button functionality majigger. You know what I mean.
			
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
			
			doctor1 = new MovieClip(atlas.getTextures("Doctor_Front000"), 6);
			doctor1.x = doctor1.y = 300;
			addChild( doctor1 );
			Starling.juggler.add( doctor1 );
			
			timer.start();
			
		}
		
		private function goToShop (e:Event):void
		{
			View.View.getInstance().loadScreen( ShopMenu );
		}
		
		private function dayFinished(event:TimerEvent):void
		{
			View.View.getInstance().loadScreen(ShopMenu);
		}
		
		
	}
	
}
