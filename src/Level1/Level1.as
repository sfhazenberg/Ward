package  Level1{
	
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.utils.Timer;
	
	import General.GeneralChecker;
	
	import MainInfo.DayReview;
	import MainInfo.TopBar;
	
	import Shop.ShopMenu;
	
	import View.View;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	
	public class Level1 extends Sprite {
		
		[Embed(source="assets/spritesheet_doctor.xml", mimeType="application/octet-stream")]
		public static const AtlasXML:Class;
		[Embed(source="assets/spritesheet_doctor.png")]
		public static const AtlasTexture:Class;
		//public static var asset:AssetManager;
		private var doctor1:MovieClip;
		private var texture:Texture = Texture.fromEmbeddedAsset(AtlasTexture);
		private var xml:XML = XML(new AtlasXML());
		private var atlas:TextureAtlas = new TextureAtlas(texture, xml);
		private var grids:Array = new Array();
		
		private var asset:AssetManager;
		private var timer:Timer;
		private var shopButton:Button;
		
		
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
			addChild(View.View.getInstance().getTopBar());
			
			timer = new Timer(10000,1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, dayFinished);
			
			shopButton = new Button(asset.getTexture("ShopButton"));
			shopButton.x = 1800;
			shopButton.y = 30;
			shopButton.addEventListener( Event.TRIGGERED, goToShop)
			addChild(shopButton);
			
			//array that stores the images of the built rooms
			var rooms:Array = new Array();
			rooms.push(new Image(asset.getTexture("waiting_room")));
			rooms[0].x = 1545;
			rooms[0].y = 751;
			addChild(rooms[0]);
			
			//rooms.removeAt[0];
			//removeChild(rooms[0]);
			
			rooms.push(new Image(asset.getTexture("supply_room")));
			rooms[1].x = 1165;
			rooms[1].y = 751;
			addChild(rooms[1]);
			
			rooms.push(new Image(asset.getTexture("treatment_room")));
			rooms[2].x = 785;
			rooms[2].y = 751;
			addChild(rooms[2]);
			
			showRooms();
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
			/**
			doctor1 = new MovieClip(atlas.getTextures("Doctor_Front000"), 6);
			doctor1.x = doctor1.y = 300;
			addChild( doctor1 );
			Starling.juggler.add( doctor1 );
			*/
			//timer.start();
			
		}
		
		/**
		 * method to show specific rooms based on shop
		 * puts rooms in static name within the array
		 */
		private function showRooms():void{
			var foo:Array = GeneralChecker.getInstance().getRooms();
			/** show grid **/
			if(foo["SUP"]){
				grids["supply"] = new Image(asset.getTexture("grid_supplyroom"));
				grids["supply"].x = 795;
				grids["supply"].y = 155;
				addChild(grids["supply"]);
				grids["supply"].addEventListener(TouchEvent.TOUCH, onTouchedSupply);
			}
			if(foo["TRE"]){
				grids.push(new Image(asset.getTexture("grid_treatmentroom")));
				grids[(grids.length - 1)].x = 1170;
				grids[(grids.length - 1)].y = 155;
				addChild(grids[(grids.length - 1)]);
				//requires TouchEvent
			}
			if(foo["WAI"]){
				grids.push(new Image(asset.getTexture("grid_waitingroom")));
				grids[(grids.length - 1)].x = 420;
				grids[(grids.length - 1)].y = 155;
				addChild(grids[(grids.length - 1)]);
				//requires TouchEvent
			}
		}
		
		/**
		 * methods called when the relevant room is pushed
		 */
		private function onTouchedSupply(event:TouchEvent):void
		{
			var t:Touch = event.getTouch(this);
			if(t) {
				switch(t.phase) {
					case TouchPhase.ENDED:
					grids["supply"].texture = asset.getTexture("supply_room");	//supply cap also needs to increase
					break;
				}
			}	
		}
		//additional functions required for SUP and WAI
		
		private function goToShop (e:Event):void
		{
			View.View.getInstance().loadScreen(ShopMenu);
		}
		
		private function dayFinished(event:TimerEvent):void
		{
			View.View.getInstance().loadScreen(DayReview);
		}
		
		
	}
	
}
