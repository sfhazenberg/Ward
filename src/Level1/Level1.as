package Level1
{
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import General.GeneralChecker;
	import MainInfo.GameOver;
	import Shop.ShopMenu;
	import View.View;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	
	public class Level1 extends Sprite {
		
		[Embed(source="assets/spritesheet_doctor.xml", mimeType="application/octet-stream")]
		public static const AtlasXML:Class;
		[Embed(source="assets/spritesheet_doctor.png")]
		public static const AtlasTexture:Class;
		private var doctor1:MovieClip;
		private var isLoaded:Boolean = false;
		private var texture:Texture = Texture.fromEmbeddedAsset(AtlasTexture);
		private var xml:XML = XML(new AtlasXML());
		private var atlas:TextureAtlas = new TextureAtlas(texture, xml);
		private var grids:Array = new Array();
		
		private var asset:AssetManager;
		private var timer:Timer;
		private var shopButton:Button;
		private var receptionDesk:Button;
		private var hallwayH:Array;
		
		/*private var pointAx:Number = 960;	//points used for positioning the NPC's
		private var pointAy:Number = 300;
		private var pointBx:Number = 890;
		private var pointBy:Number = 400;*/
		
		private var pointA:Point = new Point(960, 300);		//different naming might be more convenient
		private var pointB:Point = new Point(960, 450);
		private var pointC:Point = new Point(1120, 450);
		
		public function Level1() {
			addEventListener( Event.ADDED_TO_STAGE, initialize );
			addEventListener(Event.ENTER_FRAME, movementDoctor1);
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
			View.View.getInstance().updateTopBar();
			
			timer = new Timer(10000, 5);
			
			shopButton = new Button(asset.getTexture("buttoninfo"));
			shopButton.x = 1760;
			shopButton.y = 17;
			shopButton.addEventListener( Event.TRIGGERED, goToShop)
			addChild(shopButton);
			
			receptionDesk = new Button(asset.getTexture("reception_desk_PH"));
			receptionDesk.x = 1445;
			receptionDesk.y = 584;
			addChild(receptionDesk);
			
			//array that stores the horizontal hallways
			var hallwayH:Array = new Array();
			hallwayH.push(new Image(asset.getTexture("hallway_horz_PH")));
			hallwayH[0].x = 1520;
			hallwayH[0].y = 484;
			addChild(hallwayH[0]);
			
			hallwayH.push(new Image(asset.getTexture("hallway_horz_PH")));
			hallwayH[1].x = 1120;
			hallwayH[1].y = 484;
			addChild(hallwayH[1]);
			
			hallwayH.push(new Image(asset.getTexture("hallway_horz_PH")));
			hallwayH[2].x = 720;
			hallwayH[2].y = 484;
			addChild(hallwayH[2]);
			
			//array that stores the vertical hallways
			var hallwayV:Array = new Array();
			hallwayV.push(new Image(asset.getTexture("hallway_vert_PH")));
			hallwayV[0].x = 1820;
			hallwayV[0].y = 584;
			addChild(hallwayV[0]);
			
			//array that stores the images of the built rooms
			var rooms:Array = new Array();
			rooms.push(new Image(asset.getTexture("waiting_room")));
			rooms[0].x = 1545;
			rooms[0].y = 155;
			addChild(rooms[0]);
			
			rooms.push(new Image(asset.getTexture("supply_room")));
			rooms[1].x = 794;
			rooms[1].y = 155;
			addChild(rooms[1]);
			
			rooms.push(new Image(asset.getTexture("treatment_room")));
			rooms[2].x = 1170;
			rooms[2].y = 155;
			addChild(rooms[2]);
			
			showRooms();
			
			//rooms.removeAt[0];
			//removeChild(rooms[0]);
			
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
			doctor1.x = pointA.x;	//initial starting point of doctor1
			doctor1.y = pointA.y;
			addChild(doctor1);
			Starling.juggler.add(doctor1);
			
			isLoaded = true;
			
			timer.start();
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, dayFinished);
			trace("TIME: "+timer.currentCount);
			/*if (timer.currentCount % 20 == 1)
			{
				View.View.getInstance().updateInfPlus();
			}
			/*///View.View.getInstance().updateInfPlus();
		}
		
		/**
		 * method that handles movement for doctor1
		 */
		public function movementDoctor1(e:Event):void
		{
			if(isLoaded){
				var distanceX:Number = doctor1.x - pointB.x;
				var distanceY:Number = doctor1.y - pointB.y;
				
				var rotation:Number = Math.atan2(doctor1.y - pointB.y,doctor1.x - pointB.x) / Math.PI * 180;
				var distance:Number = Math.sqrt((distanceX*distanceX)+(distanceY*distanceY));
				
				var playerSpeed:Number = 10;
				
				if(distance < playerSpeed){
					doctor1.x = pointB.x;
					doctor1.y = pointB.y;
				}
				else{
					doctor1.x = doctor1.x + Math.cos(rotation/180*Math.PI)*playerSpeed;
					doctor1.y = doctor1.y - Math.sin(rotation/180*Math.PI)*playerSpeed;
				}
				
				//timer.stop();
				//timer.start();	//11-01: tried to make the second movement function activate at an interval. Has so far been unsuccesful however. Therefore, opted to simply make that a function and call it at the end of the initial movement.
				move();
			}
			
		}
		
		/**
		 * second movement of the doctor
		 */
		private function move():void	//incomplete movement code for the second walking portion of doctor1. Function name could also be renamed to something more....noticeable, applicable, obvious. Ya know, "sense making". 
		{							
			if(doctor1.y == 450)
			{
				var distanceX : Number = doctor1.x - pointC.x;
				var distanceY : Number = doctor1.y - pointC.y;
				
				var rotation : Number = Math.atan2(doctor1.y - pointC.y,doctor1.x - pointC.x) / Math.PI * 180;
				var distance : Number  = Math.sqrt((distanceX*distanceX)+(distanceY*distanceY));
				
				var playerSpeed:Number = 10;
				
				if(distance < playerSpeed){
					doctor1.x = pointC.x;
					doctor1.y = pointC.y;
				}
				else{
					doctor1.x = doctor1.x + Math.cos(rotation/180*Math.PI)*playerSpeed;
					doctor1.y = doctor1.y - Math.sin(rotation/180*Math.PI)*playerSpeed;
				}
			}
			
		}
		
		/**
		 * method to show specific rooms based on shop
		 * puts rooms in static name within the array
		 */
		private function showRooms():void
		{
			var foo:Array = GeneralChecker.getInstance().getRooms();
			/** show grid **/
			if(foo["SUP"]){
				grids["supply"] = new Image(asset.getTexture("grid_supplyroom"));
				grids["supply"].x = 700;
				grids["supply"].y = 584;
				addChild(grids["supply"]);
				grids["supply"].addEventListener(TouchEvent.TOUCH, onTouchedSupply);
			}
			if(foo["TRE"]){
				//grids.push(new Image(asset.getTexture("grid_treatmentroom")));
				grids["treatment"] = new Image(asset.getTexture("grid_treatmentroom"));
				grids["treatment"].x = 330;
				grids["treatment"].y = 584;
				addChild(grids["treatment"]);
				grids["treatment"].addEventListener(TouchEvent.TOUCH, onTouchedTreatment);
			}
			if(foo["WAI"]){
				//grids.push(new Image(asset.getTexture("grid_waitingroom")));
				grids["waiting"] = new Image(asset.getTexture("grid_waitingroom"));
				grids["waiting"].x = 1070;
				grids["waiting"].y = 584;
				addChild(grids["waiting"]);
				grids["waiting"].addEventListener(TouchEvent.TOUCH, onTouchedWaiting);
			}
			
			/**
			 * when a room is placed that does not have contact with a hallway, additional pieces of hallway should be created until at least one has contact with the newly built room.
			 */
			if(GeneralChecker.getInstance().getTexture("SUP"))
			{
				grids["texture_supply"] = new Image(asset.getTexture("supply_room"));
				grids["texture_supply"].x = 700;
				grids["texture_supply"].y = 584;
				addChild(grids["texture_supply"]);
			}
			if(GeneralChecker.getInstance().getTexture("TRE"))
			{
				grids["texture_treatment"] = new Image(asset.getTexture("treatment_room"));
				grids["texture_treatment"].x = 330;
				grids["texture_treatment"].y = 584;
				addChild(grids["texture_treatment"]);
			}
			if(GeneralChecker.getInstance().getTexture("WAI"))
			{
				grids["texture_waiting"] = new Image(asset.getTexture("waiting_room"));
				grids["texture_waiting"].x = 1070;
				grids["texture_waiting"].y = 584;
				addChild(grids["texture_waiting"]);
			}
		}
		
		/**
		 * methods called when the grid of a room is pushed
		 * right now they disappear when reentering the shop menu however. It should be permanent.
		 */
		private function onTouchedSupply(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this);
			if(touch) {
				switch(touch.phase) {
					case TouchPhase.ENDED:
					grids["supply"].texture = asset.getTexture("supply_room");	//supply cap also needs to increase 
					GeneralChecker.getInstance().setTextureRooms("SUP", true);
					break;
				}
			}	
		}
		
		private function onTouchedTreatment(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this);
			if(touch) {
				switch(touch.phase) {
					case TouchPhase.ENDED:
						grids["treatment"].texture = asset.getTexture("treatment_room");
						GeneralChecker.getInstance().setTextureRooms("TRE", true);
						/*if((hallwayH[length-1]).x > grids["treatment"].x )				//Used to work fine, now breaks. "Cannot access a property or method of a null object reference." on line 307. Tha's dis one. Dis line. Why. LITERALLY NOTHING ABOUT THIS CODE CHANGED MFFFFFFFFFFGGGGGGGGGG 
						{																	//places additional hallway piece if none are in contact with this room. Not the most efficient code however.
							hallwayH.push(new Image(asset.getTexture("hallway_horz_PH")));	//Idea: check starting position and width of hallway instead of fiddling with exact numbers for the x and y position.
							hallwayH[3].x = 320;											//additionally, hallway textures do not remain. Same logic used for the rooms should be applied.
							hallwayH[3].y = 484;
							addChild(hallwayH[3]);
						}*/
						break;
				}
			}	
		}
		
		private function onTouchedWaiting(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this);
			if(touch) {
				switch(touch.phase) {
					case TouchPhase.ENDED:
						grids["waiting"].texture = asset.getTexture("waiting_room");
						GeneralChecker.getInstance().setTextureRooms("WAI", true);
						break;
				}
			}	
		}
		
		private function goToShop (e:Event):void
		{
			removeGrids();
			View.View.getInstance().loadScreen(ShopMenu);
		}
		
		private function removeGrids():void
		{
			GeneralChecker.getInstance().setRooms("TRE", false);
			GeneralChecker.getInstance().setRooms("WAI", false);
			GeneralChecker.getInstance().setRooms("SUP", false);	
		}
		
		private function dayFinished(event:TimerEvent):void
		{
			View.View.getInstance().loadScreen(GameOver);
		}		
	}
	
}