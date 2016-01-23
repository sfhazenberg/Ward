package Level1
{
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.geom.Point;
	import flash.sampler.stopSampling;
	import flash.utils.Timer;
	
	import General.GeneralChecker;
	import General.Placeholder;
	
	import Level1.Tutorial;
	
	import MainInfo.DayReview;
	import MainInfo.GameOver;
	
	import Movement.Movement;
	
	import Shop.ShopMenu;
	
	import View.View;
	
	import starling.core.Starling;
	import starling.core.starling_internal;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.SubTexture;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	
	public class Level1 extends Sprite {
		
		[Embed(source="assets/doctor/front/spritesheet_doctor_front.xml", mimeType="application/octet-stream")]
		public static const AtlasXML:Class;
		[Embed(source="assets/doctor/front/spritesheet_doctor_front.png")]
		public static const AtlasTexture:Class;
		private var doctor1:MovieClip;
		private var isLoaded:Boolean = false;
		private var texture:Texture = Texture.fromEmbeddedAsset(AtlasTexture);
		private var xml:XML = XML(new AtlasXML());
		private var atlas:TextureAtlas = new TextureAtlas(texture, xml);
		private var grids:Array = new Array();
		
		private var asset:AssetManager;
		public var timer:Timer;
		private var tutorialButton:Button;
		private var receptionDesk:Button;
		private var background:Image;
		private var hallwayH:Array = new Array();
		private var hallwayHLatest:int = 1520;
		private var budget:int = View.View.getInstance().getBudget();
		private var numberOfDoctors:int = View.View.getInstance().getDoctors();
		
		/*private var pointAx:Number = 960;	//points used for positioning the NPC's
		private var pointAy:Number = 300;
		private var pointBx:Number = 890;
		private var pointBy:Number = 400;*/
		
		private var RoomArrays:Array = new Array();
		
		/*private var pointB:Point = new Point(960, 450);
		private var pointC:Point = new Point(1160, 450);*/
		
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
			View.View.getInstance().updateTopBar();
			
			tutorialButton = new Button(asset.getTexture("buttoninfo"));
			tutorialButton.x = 1760;
			tutorialButton.y = 17;
			tutorialButton.addEventListener( Event.TRIGGERED, tutorialScreen)
			addChild(tutorialButton);

			background = new Image(asset.getTexture("bg_gray_grad2"));
			background.x = 0;
			background.y = 155;
			addChild(background);
			
			//dynamicly generate rooms
			generateRooms();
			
			receptionDesk = new Button(asset.getTexture("reception_desk"));
			receptionDesk.x = 1445;
			receptionDesk.y = 584;
			addChild(receptionDesk);
			
			/**
			*array that stores the images of the initial rooms
			*/
			//idea: use variable similar to hallwayHLatest to set x position of rooms
			var rooms:Array = new Array();
			rooms.push(new Image(asset.getTexture("waiting_room")));
			rooms[0].x = 1545;
			rooms[0].y = 155;
			addChild(rooms[0]);
			
			rooms.push(new Image(asset.getTexture("supply_room")));
			rooms[1].x = 795;
			rooms[1].y = 155;
			addChild(rooms[1]);
			
			rooms.push(new Image(asset.getTexture("treatment_room")));
			rooms[2].x = 1170;
			rooms[2].y = 155;
			addChild(rooms[2]);
			
			/**
			 * array that stores the initial horizontal hallways
			 */
			var hallwayH:Array = new Array();
			hallwayH.push(new Image(asset.getTexture("hallwayH")));
			hallwayH[0].x = hallwayHLatest;
			hallwayH[0].y = 484;
			addChild(hallwayH[0]);
			
			hallwayHLatest -= 400;
			
			hallwayH.push(new Image(asset.getTexture("hallwayH")));
			hallwayH[1].x = hallwayHLatest;
			hallwayH[1].y = 484;
			addChild(hallwayH[1]);
			
			hallwayHLatest -= 400;			
			
			hallwayH.push(new Image(asset.getTexture("hallwayH")));
			hallwayH[2].x = hallwayHLatest;
			hallwayH[2].y = 484;
			addChild(hallwayH[2]);
			
			/**
			 * array that stores the initial vertical hallways
			 */
			var hallwayV:Array = new Array();
			hallwayV.push(new Image(asset.getTexture("hallwayV")));
			hallwayV[0].x = 1820;
			hallwayV[0].y = 584;
			addChild(hallwayV[0]);
			
			/**
			 * stores newly added horizontal hallway textures to the array
			 */
			if(GeneralChecker.getInstance().getHallwayH("0"))
			{
				hallwayHLatest -= 400;
				hallwayH.push(new Image(asset.getTexture("hallwayH")));
				hallwayH[3].x = hallwayHLatest;
				hallwayH[3].y = 484;
				addChild(hallwayH[3]);
				hallwayV.push(new Image(asset.getTexture("hallwayV")));
				hallwayV[1].x = 595;
				hallwayV[1].y = 584;
				addChild(hallwayV[1]);
			}
			
			/**
			 * loads the moving doctor
			 */
			var pointA:Point = new Point(1280, 300);		//different naming might be more convenient
			doctor1 = new MovieClip(atlas.getTextures("Doctor_Front000"), 6);
			doctor1.x = pointA.x;	//initial starting point of doctor1
			doctor1.y = pointA.y;
			addChild(doctor1);
			Starling.juggler.add(doctor1);
			var firstMovement:Movement = new Movement(doctor1);		
			
			time();
		}
		
		private function generateRooms():void{
			this.RoomArrays = GeneralChecker.getInstance().getPlaceHolder().Synchronise();
			for each(var instance:Image in RoomArrays){
				if(instance != null){
					//if is treatment
					if(GeneralChecker.getInstance().getPlaceHolder().getTreat().indexOf(instance) >= 0 && GeneralChecker.getInstance().getPlaceHolder().getOverwrite().indexOf(instance) >= 0){
						instance.texture = asset.getTexture('treatment_room');
					}
					else if(GeneralChecker.getInstance().getPlaceHolder().getTreat().indexOf(instance) >= 0){
						instance.texture = asset.getTexture('grid_treatmentroom');
					}
					else if (GeneralChecker.getInstance().getPlaceHolder().getSupply().indexOf(instance) >= 0 && GeneralChecker.getInstance().getPlaceHolder().getOverwrite().indexOf(instance) >= 0){
						instance.texture = asset.getTexture('supply_room');
					}
					else if(GeneralChecker.getInstance().getPlaceHolder().getSupply().indexOf(instance) >= 0){
						instance.texture = asset.getTexture('grid_supply');
					}
					else if(GeneralChecker.getInstance().getPlaceHolder().getWaiting().indexOf(instance) >= 0 && GeneralChecker.getInstance().getPlaceHolder().getOverwrite().indexOf(instance) >= 0){
						instance.texture = asset.getTexture('waiting_room');
					}
					else if(GeneralChecker.getInstance().getPlaceHolder().getWaiting().indexOf(instance) >= 0){
						instance.texture = asset.getTexture('grid_waitingroom');
					}
					instance.addEventListener(TouchEvent.TOUCH, onTouchedROOM);	
					addChild(instance);	
				}
			}
		}

		/**
		 * method called when GRID of room is pushed.
		 * @event: push event
		 */
		private function onTouchedROOM(event:TouchEvent):void{
			var touch:Touch = event.getTouch(this);
			if(touch){
				switch(touch.phase){
					case TouchPhase.ENDED:
					event.target.removeEventListeners(null);
				
					if(GeneralChecker.getInstance().getPlaceHolder().getTreat().indexOf(event.target) >= 0){
						var newImage:Image = new Image(asset.getTexture('treatment_room'));
						var locationInArray:int = this.RoomArrays.indexOf(event.target);
						newImage.x = RoomArrays[locationInArray].x;
						newImage.y = RoomArrays[locationInArray].y;
						removeChild(RoomArrays[locationInArray]);
						GeneralChecker.getInstance().getPlaceHolder().overwriteGrid(RoomArrays[locationInArray]);
						addChild(newImage);
					}
					else if(GeneralChecker.getInstance().getPlaceHolder().getWaiting().indexOf(event.target) >= 0){
						var newImage2:Image = new Image(asset.getTexture('waiting_room'));
						var locationInArray2:int = this.RoomArrays.indexOf(event.target);
						newImage2.x = RoomArrays[locationInArray2].x;
						newImage2.y = RoomArrays[locationInArray2].y;
						removeChild(RoomArrays[locationInArray2]);
						GeneralChecker.getInstance().getPlaceHolder().overwriteGrid(RoomArrays[locationInArray2]);
						addChild(newImage2);
					}
					else if(GeneralChecker.getInstance().getPlaceHolder().getSupply().indexOf(event.target) >= 0){
						var newImage3:Image = new Image(asset.getTexture('supply_room'));
						var locationInArray3:int = this.RoomArrays.indexOf(event.target);
						newImage3.x = RoomArrays[locationInArray3].x;
						newImage3.y = RoomArrays[locationInArray3].y;
						removeChild(RoomArrays[locationInArray3]);
						GeneralChecker.getInstance().getPlaceHolder().overwriteGrid(RoomArrays[locationInArray3]);
						addChild(newImage3);
					}
				}
			}
		}
		
		private function time():void
		{
			timer = new Timer(1, 1500);
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, counting);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, dayFinished);
		}
		
		private function counting(event:TimerEvent):void
		{
			trace("TIME: "+timer.currentCount);
			if (timer.currentCount > 0 && timer.currentCount % 400 == 0 && timer.currentCount != 1500)
			{
				View.View.getInstance().updateInfPlus(); 
				View.View.getInstance().updateTopBar();
			}
			
			var supplies:int = View.View.getInstance().getNumberOfSupplies();
			if (timer.currentCount > 0 && timer.currentCount % 100 == 0 && supplies != 0)
			{
				supplies -= numberOfDoctors;
				budget += 1000 * numberOfDoctors;
				View.View.getInstance().setNumberOfSupplies(supplies);
				View.View.getInstance().setBudget(budget);
				View.View.getInstance().updateTopBar();
				trace("SUPPLY: "+supplies);
			}
		}
		
		
		private function tutorialScreen (e:Event):void
		{
			GeneralChecker.getInstance().removeRoomGrids();
			Destroy();
			View.View.getInstance().loadScreen(ShopMenu);
			View.View.getInstance().loadScreen(Tutorial);
		}

		private function goToShop (e:Event):void

		{
			GeneralChecker.getInstance().removeRoomGrids();
			Destroy();
			View.View.getInstance().loadScreen(Tutorial);
		}
		
		private function dayFinished(e:TimerEvent):void
		{
			var doc:int = View.View.getInstance().getDoctors();
			budget -= doc * 1000;
			trace("BUDGET " + budget);
			View.View.getInstance().setBudget(budget);
			View.View.getInstance().updateTopBar();
			View.View.getInstance().loadScreen(ShopMenu);
		}


		/*	trace("DAY FINISHED");
			View.View.getInstance().loadScreen(ShopMenu);
			View.View.getInstance().loadScreen(GameOver);
		}*/		
		

		private function Destroy():void
		{
			asset.dispose();
			//GeneralChecker.getInstance().getPlaceHolder().Add(null, null);
			//this.RoomArrays.pop();
			//this.RoomArrays.splice(0);
			//this.RoomArrays.length = 0;
		}
	}
}