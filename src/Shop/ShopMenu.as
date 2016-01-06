package Shop
{
	
	import flash.filesystem.File;
	
	import General.GeneralChecker;
	
	import Level1.Level1;
	
	import MainInfo.TopBar;
	
	import View.View;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.AssetManager;

	public class ShopMenu extends Sprite {
		
		private var asset:AssetManager;
		private var screenSwitcher:View;
		private var sprite:Sprite;
		private var topBar:TopBar;
		private var lackOfMoney:Image;
		private var close:Button;
		public var numberOfDoctors:int = 1;
		public var suppliesNumber:int = 0;
		private var suppliesNumberTextField:TextField;
		private var priceForSuppliesText:TextField;
		private var priceOfSupplies:int = 500;
		private var priceForSupplies:int = 0;
		private var maxNumberOfSupplies:int = View.View.getInstance().getMaxNumberOfSupplies();
		private var numberOfSupplies:int = View.View.getInstance().getNumberOfSupplies();
		
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
			
			statsButton = new Button ( asset.getTexture("ShopInfoButtonOff"), "", asset.getTexture("ShopInfoButtonOn"));
			statsButton.x = 5;
			statsButton.y = 845;
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
		
		/**
		 * eventlisteners for individual buttons inside upgrade screen
		 */
		private function addUpgradesEventListeners():void
		{
			treatmentRoom.addEventListener(TouchEvent.TOUCH, onTouchedTreatment);
			waitingRoom.addEventListener(TouchEvent.TOUCH, onTouchedWaiting);
			supplyRoom.addEventListener(TouchEvent.TOUCH, onTouchedSupply);
			//supplyRoom.addEventListener(Event.TRIGGERED, supplyTriggered);
			workshop.addEventListener(Event.TRIGGERED, workshopTriggered);
		}
		

		private function supplyTriggered():void		//should happen at the same time a new supply room has been put into the hospital screen.
		{
			maxNumberOfSupplies += 30;
			View.View.getInstance().setMaxNumberOfSupplies(maxNumberOfSupplies);
			View.View.getInstance().updateTopBar();
		}
		
		//TouchEvent should be Phase ENDED
		/**
		 * method called when treatment room is pushed
		 */
		private function onTouchedTreatment(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this);
			if(touch){
				switch(touch.phase){
					case TouchPhase.ENDED:
					GeneralChecker.getInstance().setRooms("TRE", true);	//reveals grid view of corresponding room
					View.View.getInstance().loadScreen( Level1 );		//loads back to the main game screen
					break;
				}
			}
		}
		
		/**
		 * method called when waiting room is pushed
		 */
		private function onTouchedWaiting(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this);
			if(touch){
				switch(touch.phase){
					case TouchPhase.ENDED:
						GeneralChecker.getInstance().setRooms("WAI", true);	//reveals grid view of corresponding room
						View.View.getInstance().loadScreen( Level1 );		//loads back to the main game screen
						break;
				}
			}
		}
		
		/**
		 * method called when supply room is pushed
		 */

		/*private function onTouchedSupply(event:TouchEvent):void
		{
			GeneralChecker.getInstance().setRooms("SUP", true);
		}*/	

		private function onTouchedSupply(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this);
			if(touch){
				switch(touch.phase){
					case TouchPhase.ENDED:
						GeneralChecker.getInstance().setRooms("SUP", true);	//reveals grid view of corresponding room
						View.View.getInstance().loadScreen( Level1 );		//loads back to the main game screen
						break;
				}
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
			
			buySupplies = new Button (asset.getTexture("buyButton"));
			buySupplies.x = 870;
			buySupplies.y = 750;
			addChild(buySupplies);
			
			priceForSuppliesText = new TextField (210, 140, priceForSupplies.toString(10), "", 60, 0xFFFFFF);
			priceForSuppliesText.x = 870;
			priceForSuppliesText.y = 750;
			addChild(priceForSuppliesText);
			
			addSuppliesEventListeners();
		}
		
		private function addSuppliesEventListeners():void
		{
			suppliesMinus.addEventListener(Event.TRIGGERED, suppliesMinusTrigerred);
			suppliesPlus.addEventListener( Event.TRIGGERED, suppliesPlusTriggered);
			buySupplies.addEventListener( Event.TRIGGERED, buySuppliesTriggered);
		}
		
		private function removeSuppliesEventListeners():void
		{
			suppliesMinus.removeEventListener(Event.TRIGGERED, suppliesMinusTrigerred);
			suppliesPlus.removeEventListener( Event.TRIGGERED, suppliesPlusTriggered);
			buySupplies.removeEventListener( Event.TRIGGERED, buySuppliesTriggered);
		}
		
		private function suppliesMinusTrigerred():void
		{
			if (suppliesNumber > 0)
			{
				suppliesNumber -= 1;
				priceForSupplies = suppliesNumber * priceOfSupplies;
				updateSuppliesNumber();
			}
		}
		
		private function suppliesPlusTriggered():void
		{
			if (suppliesNumber < maxNumberOfSupplies - numberOfSupplies)
			{
				suppliesNumber += 1;
				priceForSupplies = suppliesNumber * priceOfSupplies;
				updateSuppliesNumber();
			}
		}
		
		private function updateSuppliesNumber():void
		{
			removeChild(priceForSuppliesText);
			priceForSuppliesText = new TextField (210, 140, priceForSupplies.toString(10), "", 60, 0xFFFFFF);
			priceForSuppliesText.x = 870;
			priceForSuppliesText.y = 750;
			addChild(priceForSuppliesText);
			
			removeChild(suppliesNumberTextField);
			suppliesNumberTextField = new TextField (510, 200, suppliesNumber.toString(10),"",100, 0x333333);
			suppliesNumberTextField.x = 830;
			suppliesNumberTextField.y = 450;
			addChild(suppliesNumberTextField);			
		}
		
		private function buySuppliesTriggered():void
		{
			if (priceForSupplies < View.View.getInstance().getTopBar().budget)
			{
				View.View.getInstance().getTopBar().budget -= priceForSupplies;
				View.View.getInstance().setBudget(View.View.getInstance().getTopBar().budget);
				View.View.getInstance().updateTopBar();

				numberOfSupplies += suppliesNumber;
				View.View.getInstance().setNumberOfSupplies(numberOfSupplies);
				View.View.getInstance().updateTopBar();
				
				priceForSupplies = 0;
				suppliesNumber = 0;
				updateSuppliesNumber();
			} else
			{
				removeSuppliesEventListeners();
				notEnoughMoneyForSupplies();
			}
		}
		
		private function notEnoughMoneyForSupplies():void
		{
			lackOfMoney = new Image (asset.getTexture("NoMoney"));
			lackOfMoney.x = 800;
			lackOfMoney.y = 400;
			close = new Button (asset.getTexture("Close"));
			close.x = 1000;
			close.y = 680;
			close.addEventListener(Event.TRIGGERED, closeLackOfMoneyForSupplies);
			addChild(lackOfMoney);
			addChild(close);
		}
		
		private function closeLackOfMoneyForSupplies():void
		{
			removeChild(lackOfMoney);
			removeChild(close);
			addSuppliesEventListeners();
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
		 
	}
	
}
