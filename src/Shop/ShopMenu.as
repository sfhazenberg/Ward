package  Shop{
	
	import flash.filesystem.File;
	
	import General.GeneralChecker;
	
	import Level1.Level1;
	
	import View.View;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.AssetManager;
	
	public class ShopMenu extends Sprite {
		
		private var asset:AssetManager;
		private var screenSwitcher:View;
		private var sprite:Sprite;
		private var lackOfMoney:Image;
		private var close:Button;
		public var numberOfDoctors:int = 1;
		public var suppliesNumber:int = 0;
		public var suppliesNumberTextField:TextField;
		private var maxNumberOfSupplies:int = 30;
		
		private var backToGame:Button;
		private var upgradeButton:Button;
		private var treatmentRoom:Button;
		private var waitingRoom:Button;
		private var supplyRoom:Button;
		private var workshop:Button;
		private var seminar:Button
		private var staffButton:Button;
		private var suppliesButton:Button;
		private var statsButton:Button;
		private var hireDoctor:Button;
		private var fireDoctor:Button;
		private var suppliesPlus:Button;
		private var suppliesMinus:Button;
		private var buySupplies:Button;

		public function ShopMenu() 
		{
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
			addChild(View.View.getInstance().getTopBar());
			View.View.getInstance().getTopBar().update();
			
			backToGame = new Button (asset.getTexture("ExitButtonUp"), "", asset.getTexture("ExitButtonDown"));
			backToGame.x = 1825;
			backToGame.y = 30;
			backToGame.addEventListener( Event.TRIGGERED, exitShop );
			addChild( backToGame );
			
			upgradeButton = new Button ( asset.getTexture("UpgradeButtonOff"),"", asset.getTexture("UpgradeButtonOn"));
			upgradeButton.x = 5;
			upgradeButton.y = 170;
			addChild(upgradeButton);
			
			staffButton = new Button ( asset.getTexture("StaffButtonOff"), "", asset.getTexture("StaffButtonOn"));
			staffButton.x = 5;
			staffButton.y = 395;
			addChild(staffButton);
			
			suppliesButton = new Button ( asset.getTexture("SuppliesButtonOff"), "", asset.getTexture("SuppliesButtonOn"));
			suppliesButton.x = 5;
			suppliesButton.y = 620;
			addChild(suppliesButton);
			
			statsButton = new Button ( asset.getTexture("up_stats"), "Information", asset.getTexture("down_stats"));
			statsButton.y = 1000;
			addChild(statsButton);
			
			sprite = new Sprite();
			sprite.x = 500;
			sprite.y = 500;
			addChild(sprite);
			 
			addMainEventListeners();
		}
		
		private function exitShop (e:Event):void
		{
			View.View.getInstance().loadScreen( Level1 );
		}
		
		private function addMainEventListeners():void
		{
			upgradeButton.addEventListener( Event.TRIGGERED, upgradeScreen );
			staffButton.addEventListener( Event.TRIGGERED, staffScreen );
			suppliesButton.addEventListener( Event.TRIGGERED, suppliesScreen );
			statsButton.addEventListener( Event.TRIGGERED, statsScreen );
		}
		
		private function removeMainEventListeners():void
		{
			upgradeButton.addEventListener( Event.TRIGGERED, upgradeScreen );
			staffButton.addEventListener( Event.TRIGGERED, staffScreen );
			suppliesButton.addEventListener( Event.TRIGGERED, suppliesScreen );
			statsButton.addEventListener( Event.TRIGGERED, statsScreen );
		}
		
		
// *UPGRADE********************************************************************************
		private function upgradeScreen (e:Event):void
		{
			sprite.dispose();
			removeChild(sprite);
			sprite = new Sprite();
			sprite.x = 315;
			sprite.y = 170;
			addChild(sprite);
			
			var upgradeBackground:Image = new Image (asset.getTexture("UpgradesScreen"));
			sprite.addChild(upgradeBackground);
			
			treatmentRoom = new Button (asset.getTexture("TreatmentRoomButton"));
			treatmentRoom.x = 500;
			treatmentRoom.y = 150;
			sprite.addChild(treatmentRoom);
			
			waitingRoom = new Button (asset.getTexture("WaitingRoomButton"));
			waitingRoom.x = 500;
			waitingRoom.y = 280;
			sprite.addChild(waitingRoom);
			
			supplyRoom = new Button (asset.getTexture("SupplyRoomButton"));
			supplyRoom.x = 500;
			supplyRoom.y = 410;
			sprite.addChild(supplyRoom);
			
			workshop = new Button (asset.getTexture("WorkshopButton"));
			workshop.x = 500;
			workshop.y = 590;
			sprite.addChild(workshop);
			
			seminar = new Button (asset.getTexture("SeminarButton"));
			seminar.x = 500;
			seminar.y = 720;
			sprite.addChild(seminar);
			seminar.addEventListener(Event.TRIGGERED, seminarTriggered);
			
			addUpgradesEventListeners();
		}
		
		private function onTouched(event:TouchEvent):void 
		{
			if(event.getTouch(this, TouchPhase.ENDED))
			{
				GeneralChecker.getInstance().setGridView(true);
				View.View.getInstance().loadScreen( Level1 );
			}
		}
		
		private function workshopTriggered():void
		{
			if (View.View.getInstance().getTopBar().budget >= 5000)
			{
				View.View.getInstance().getTopBar().budget -= 5000;
				View.View.getInstance().setBudget(View.View.getInstance().getTopBar().budget);
				View.View.getInstance().updateTopBar();
				
			}
			else 
			{
				removeUpgradesEventListeners();
				notEnoughMoney();
			}
		}
		
		private function seminarTriggered():void
		{
			if (View.View.getInstance().getTopBar().budget >= 10000)
			{
				View.View.getInstance().getTopBar().budget -= 10000;
				View.View.getInstance().setBudget(View.View.getInstance().getTopBar().budget);
				View.View.getInstance().updateTopBar();
			}
			else 
			{
				notEnoughMoney();
			}
		}
		
		private function addUpgradesEventListeners():void
		{
			treatmentRoom.addEventListener(TouchEvent.TOUCH, onTouched);
			workshop.addEventListener(Event.TRIGGERED, workshopTriggered);
		}
		
		private function removeUpgradesEventListeners():void
		{
			workshop.removeEventListener(Event.TRIGGERED, workshopTriggered);
		}		
		
		private function notEnoughMoney():void
		{
			lackOfMoney = new Image (asset.getTexture("NoMoney"));
			lackOfMoney.x = 800;
			lackOfMoney.y = 400;
			close = new Button (asset.getTexture("Close"));
			close.x = 1000;
			close.y = 680;
			close.addEventListener(Event.TRIGGERED, closeLackOfMoney);
			addChild(lackOfMoney);
			addChild(close);
		}
		
		private function closeLackOfMoney():void
		{
			removeChild(lackOfMoney);
			removeChild(close);
			addUpgradesEventListeners();
		}
		
// *STAFF************************************************************************
		private function staffScreen (e:Event):void
		{
			removeChild(sprite);
			sprite = new Sprite();
			sprite.x = 315;
			sprite.y = 170;
			addChild(sprite);
			
			var staffBackground:Image = new Image (asset.getTexture("StaffScreen"));
			sprite.addChild(staffBackground);
			
			hireDoctor = new Button (asset.getTexture("HireButton"));
			hireDoctor.x = 300;
			hireDoctor.y = 280;
			hireDoctor.addEventListener(Event.TRIGGERED, hireDoctorTriggered);
			sprite.addChild(hireDoctor);
			
			fireDoctor = new Button (asset.getTexture("FireButton"));
			fireDoctor.x = 300;
			fireDoctor.y = 500;
			fireDoctor.addEventListener(Event.TRIGGERED, fireDoctorTriggered);
			sprite.addChild(fireDoctor);
		}
		
		private function hireDoctorTriggered():void
		{
			numberOfDoctors += 1;
		}
		
		private function fireDoctorTriggered():void
		{
			if (numberOfDoctors > 0)
			{
				numberOfDoctors -= 1;
			}
		}
		

// *SUPPLIES*********************************************************************************		
		private function suppliesScreen (e:Event):void
		{
			removeChild(sprite);
			sprite = new Sprite();
			sprite.x = 315;
			sprite.y = 170;
			addChild(sprite);
			
			var suppliesBackground:Image = new Image (asset.getTexture("SuppliesScreen"));
			sprite.addChild(suppliesBackground);
			
			suppliesMinus = new Button (asset.getTexture("MinusButton"));
			suppliesMinus.x = 500;
			suppliesMinus.y = 450;
			addChild(suppliesMinus);
			
			var suppliesNumberBox:Image = new Image (asset.getTexture("NumberBox"));
			suppliesNumberBox.x = 830;
			suppliesNumberBox.y = 450;
			addChild(suppliesNumberBox);
			
			suppliesNumberTextField = new TextField (510, 200, suppliesNumber.toString(10),"",100, 0x333333);
			suppliesNumberTextField.x = 830;
			suppliesNumberTextField.y = 450;
			addChild(suppliesNumberTextField);
			
			suppliesPlus = new Button (asset.getTexture("PlusButton"));
			suppliesPlus.x = 1400;
			suppliesPlus.y = 450;
			addChild(suppliesPlus);
			
			addSuppliesEventListeners();
		}
		
		private function addSuppliesEventListeners():void
		{
			suppliesMinus.addEventListener(Event.TRIGGERED, suppliesMinusTrigerred);
			suppliesPlus.addEventListener( Event.TRIGGERED, suppliesPlusTriggered);
		}
		
		private function suppliesMinusTrigerred():void
		{
			if (suppliesNumber > 0)
			{
				suppliesNumber -= 1;
				updateSuppliesNumber();
			}
		}
		
		private function suppliesPlusTriggered():void
		{
			if (suppliesNumber < maxNumberOfSupplies)
			{
				suppliesNumber += 1;
				updateSuppliesNumber();
			}
		}
		
		private function updateSuppliesNumber():void
		{
			removeChild(suppliesNumberTextField);
			suppliesNumberTextField = new TextField (510, 200, suppliesNumber.toString(10),"",100, 0x333333);
			suppliesNumberTextField.x = 830;
			suppliesNumberTextField.y = 450;
			addChild(suppliesNumberTextField);	
		}
		
// *STATS************************************************************************************
		private function statsScreen (e:Event):void
		{
			removeChild(sprite);
			sprite = new Sprite();
			sprite.x = 500;
			sprite.y = 500;
			addChild(sprite);
		}
		
// ******************************************************************************************		

		
	}
	
}


