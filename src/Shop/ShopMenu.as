package  Shop{
	
	import flash.filesystem.File;
	
	import Level1.Level1;
	
	import MainInfo.MainInfo;
	
	import ScreenSwitcher.ScreenSwitcher;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	public class ShopMenu extends MainInfo {
		
		private var asset:AssetManager;
		private var screenSwitcher:ScreenSwitcher;
		private var sprite:Sprite;
		public static var treatmentRoom:Object;

		public function ShopMenu() {
			
			this.screenSwitcher = screenSwitcher;
			addEventListener( Event.ADDED_TO_STAGE, initialize );
		}
		
		public function initialize (event:Event):void 
		{			
			asset = new AssetManager;
			var folder:File = File.applicationDirectory.resolvePath("Shop/assets");
			asset.enqueue( folder );
			asset.loadQueue( onProgress );
		}
		
		private function onProgress( ratio:Number ):void
		{
			if( ratio == 1 )
			{
				startShopMenu();
			}
		}
		
		private function startShopMenu ():void
		{						
			var backToGame:Button = new Button (asset.getTexture("ExitButtonUp"), "", asset.getTexture("ExitButtonDown"));
			backToGame.x = stage.stageWidth - 95;
			backToGame.y = 30;
			backToGame.addEventListener( Event.TRIGGERED, exitShop );
			addChild( backToGame );
			
			var upgradeButton:Button = new Button ( asset.getTexture("UpgradeButtonOff"),"", asset.getTexture("UpgradeButtonOn"));
			upgradeButton.x = 5;
			upgradeButton.y = 170;
			addChild(upgradeButton);
			
			var staffButton:Button = new Button ( asset.getTexture("StaffButtonOff"), "", asset.getTexture("StaffButtonOn"));
			staffButton.x = 5;
			staffButton.y = 395;
			addChild(staffButton);
			
			var suppliesButton:Button = new Button ( asset.getTexture("SuppliesButtonOff"), "", asset.getTexture("SuppliesButtonOn"));
			suppliesButton.x = 5;
			suppliesButton.y = 620;
			addChild(suppliesButton);
			
			var statsButton:Button = new Button ( asset.getTexture("up_stats"), "Information", asset.getTexture("down_stats"));
			statsButton.y = 1000;
			addChild(statsButton);
			
			upgradeButton.addEventListener( Event.TRIGGERED, upgradeScreen );
			staffButton.addEventListener( Event.TRIGGERED, staffScreen );
			suppliesButton.addEventListener( Event.TRIGGERED, suppliesScreen );
			statsButton.addEventListener( Event.TRIGGERED, statsScreen );
			
			sprite = new Sprite();
			sprite.x = 500;
			sprite.y = 500;
			addChild(sprite);
		}
		
		private function exitShop (e:Event):void
		{
			ScreenSwitcher.ScreenSwitcher.getInstance().loadScreen( Level1 );
		}
		
		private function upgradeScreen (e:Event):void
		{
			sprite.dispose();
			removeChild(sprite);
			sprite = new Sprite();
			sprite.x = 280;
			sprite.y = 180;
			addChild(sprite);
			var upgradeBackground:Image = new Image (asset.getTexture("UpgradesScreen"));
			sprite.addChild(upgradeBackground);
			
			var treatmentRoom:Button = new Button (asset.getTexture("TreatmentRoomButton"));
			treatmentRoom.x = 500;
			treatmentRoom.y = 150;
			sprite.addChild(treatmentRoom);
			
			
			var waitingRoom:Button = new Button (asset.getTexture("WaitingRoomButton"));
			waitingRoom.x = 500;
			waitingRoom.y = 280;
			sprite.addChild(waitingRoom);
			
			var supplyRoom:Button = new Button (asset.getTexture("SupplyRoomButton"));
			supplyRoom.x = 500;
			supplyRoom.y = 410;
			sprite.addChild(supplyRoom);
			
			var workshop:Button = new Button (asset.getTexture("WorkshopButton"));
			workshop.x = 500;
			workshop.y = 590;
			sprite.addChild(workshop);
			
			var seminar:Button = new Button (asset.getTexture("SeminarButton"));
			seminar.x = 500;
			seminar.y = 720;
			sprite.addChild(seminar);
			
		}
		
		private function staffScreen (e:Event):void
		{
			removeChild(sprite);
			sprite = new Sprite();
			sprite.x = 310;
			sprite.y = 190;
			addChild(sprite);
			
			var staffBackground:Image = new Image (asset.getTexture("StaffScreen"));
			sprite.addChild(staffBackground);
			
			var hireDoctor:Button = new Button (asset.getTexture("HireButton"));
			hireDoctor.x = 300;
			hireDoctor.y = 280;
			sprite.addChild(hireDoctor);
			
			var fireDoctor:Button = new Button (asset.getTexture("FireButton"));
			fireDoctor.x = 300;
			fireDoctor.y = 500;
			sprite.addChild(fireDoctor);
		}
		
		private function suppliesScreen (e:Event):void
		{
			removeChild(sprite);
			sprite = new Sprite();
			sprite.x = 500;
			sprite.y = 500;
			addChild(sprite);
		}
		
		private function statsScreen (e:Event):void
		{
			removeChild(sprite);
			sprite = new Sprite();
			sprite.x = 500;
			sprite.y = 500;
			addChild(sprite);
		}
		
		}

	}
	

