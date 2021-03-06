﻿package Shop
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
		public var numberOfDoctors:int = View.View.getInstance().getDoctors();
		private var amountOfDoctors:Image;
		private var amountOfDoctorsText:TextField;
		public var suppliesNumber:int = 0;
		private var suppliesNumberTextField:TextField;
		private var priceForSuppliesText:TextField;
		private var priceOfSupplies:int = 500;
		private var priceForSupplies:int = 0;
		private var maxNumberOfSupplies:int = View.View.getInstance().getMaxNumberOfSupplies();
		private var numberOfSupplies:int = View.View.getInstance().getNumberOfSupplies();
		private var infectivity:Number = View.View.getInstance().getInfectivity();
		private var suppliesBought:int = numberOfSupplies;
		private var doctors:int = View.View.getInstance().getDoctors();
		
		private var close:Button;
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
		
		private static var instance:ShopMenu = new ShopMenu();

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
			/*var budget:int = View.View.getInstance().getBudget();
			budget -= numberOfDoctors * 1000;
			View.View.getInstance().setBudget(budget);
			View.View.getInstance().updateTopBar();
			trace ("budget"+ budget);*/
			
			addChild(View.View.getInstance().getTopBar());
			View.View.getInstance().getTopBar().update();
			View.View.getInstance().updateInf();
			
			backToGame = new Button (asset.getTexture("BackButton"));
			backToGame.x = 1720;
			backToGame.y = 8;
			backToGame.addEventListener( Event.TRIGGERED, exitShop );
			addChild( backToGame );
			
			upgradeButton = new Button ( asset.getTexture("UpgradeButtonOff"));
			upgradeButton.x = 5;
			upgradeButton.y = 170;
			addChild(upgradeButton);
			
			staffButton = new Button ( asset.getTexture("StaffButtonOff"));
			staffButton.x = 5;
			staffButton.y = 395;
			addChild(staffButton);
			
			suppliesButton = new Button ( asset.getTexture("SuppliesButtonOff"));
			suppliesButton.x = 5;
			suppliesButton.y = 620;
			addChild(suppliesButton);
			
			statsButton = new Button ( asset.getTexture("DailyReportOff"));
			statsButton.x = 5;
			statsButton.y = 845;
			addChild(statsButton);
			
			sprite = new Sprite();
			sprite.x = 500;
			sprite.y = 500;
			addChild(sprite);
			
			infoScreen();
			
			addMainEventListeners();
		}
		
		private function exitShop (e:Event):void
		{
			Destroy();
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
		

		/*private function supplyTriggered():void		//should happen at the same time a new supply room has been put into the hospital screen.
		{
			maxNumberOfSupplies += 30;
			View.View.getInstance().setMaxNumberOfSupplies(maxNumberOfSupplies);
			View.View.getInstance().updateTopBar();
		}*/
		
		/**
		 * method called when treatment room is pushed
		 */
		private function onTouchedTreatment(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this);
			if(touch){
				switch(touch.phase){
					case TouchPhase.ENDED:
					//var tmp:Image = new Image(asset.getTexture('grid_treatmentroom'));
					var tmp:Image = new Image(asset.getTexture('treatment_room'));
					GeneralChecker.getInstance().getPlaceHolder().Add(tmp, 0);
					break;
				}
			}
		}
		
		/**
		 * method called when supply room is pushed
		 */
		private function onTouchedSupply(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this);
			if(touch){
				switch(touch.phase){
					case TouchPhase.ENDED:
						//var tmp:Image = new Image(asset.getTexture('grid_supplyroom'));
						var tmp:Image = new Image(asset.getTexture('supply_room'));
						GeneralChecker.getInstance().getPlaceHolder().Add(tmp, 1);
						
						maxNumberOfSupplies += 30;
						View.View.getInstance().setMaxNumberOfSupplies(maxNumberOfSupplies);
						View.View.getInstance().updateTopBar();
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
						//var tmp:Image = new Image(asset.getTexture('grid_waitingroom'));
						var tmp:Image = new Image(asset.getTexture('waiting_room'));
						GeneralChecker.getInstance().getPlaceHolder().Add(tmp, 2);
						break;
				}
			}
		}
		
		private function workshopTriggered():void
		{
			if (View.View.getInstance().getTopBar().budget >= 5000)
			{
				if (infectivity > 0)
				{
				infectivity -= 0.1;
				infectivity = Math.round(infectivity * 10) / 10;
				View.View.getInstance().setInfectivity(infectivity);
				View.View.getInstance().updateInf();
				}
				
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
				if (infectivity > 0.1)
				{
					infectivity -= 0.2;
					infectivity = Math.round(infectivity * 100) / 100;
					View.View.getInstance().setInfectivity(infectivity);
					View.View.getInstance().updateInf();
				} else if (infectivity == 0.1)
				{
					infectivity -= 0.1;
					infectivity = Math.floor(infectivity * 100) / 100;
					View.View.getInstance().setInfectivity(infectivity);
					View.View.getInstance().updateInf();
				}
				
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
			sprite.addChild(lackOfMoney);
			sprite.addChild(close);
		}
		
		private function closeLackOfMoney():void
		{
			sprite.removeChild(lackOfMoney);
			sprite.removeChild(close);
			addUpgradesEventListeners();
		}
		
// *STAFF************************************************************************
		private function staffScreen (e:Event):void
		{
			sprite.dispose();
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
			fireDoctor.y = 450;
			fireDoctor.addEventListener(Event.TRIGGERED, fireDoctorTriggered);
			sprite.addChild(fireDoctor);
			
			amountOfDoctors = new Image (asset.getTexture("amount"));
			amountOfDoctors.x = 400;
			amountOfDoctors.y = 600;
			sprite.addChild(amountOfDoctors);
			
			amountOfDoctorsText = new TextField (150, 150, numberOfDoctors.toString(10), "Stencil", 60, 0xFFFFFF);
			amountOfDoctorsText.x = 1000;
			amountOfDoctorsText.y = 562;
			sprite.addChild(amountOfDoctorsText);
		}
		
		private function hireDoctorTriggered():void
		{
			if ( numberOfDoctors < 25 )
			{
				numberOfDoctors += 1;
				View.View.getInstance().setDoctors(numberOfDoctors);
				sprite.removeChild(amountOfDoctorsText);
				amountOfDoctorsText = new TextField (150, 150, numberOfDoctors.toString(10), "Stencil", 60, 0xFFFFFF);
				amountOfDoctorsText.x = 1000;
				amountOfDoctorsText.y = 562;
				sprite.addChild(amountOfDoctorsText);
			}
		}
		
		private function fireDoctorTriggered():void
		{
			if (numberOfDoctors > 0)
			{
				numberOfDoctors -= 1;
				View.View.getInstance().setDoctors(numberOfDoctors);
				sprite.removeChild(amountOfDoctorsText);
				amountOfDoctorsText = new TextField (150, 150, numberOfDoctors.toString(10), "Stencil", 60, 0xFFFFFF);
				amountOfDoctorsText.x = 1000;
				amountOfDoctorsText.y = 562;
				sprite.addChild(amountOfDoctorsText);
			}
		}
		

// *SUPPLIES*********************************************************************************		
		private function suppliesScreen (e:Event):void
		{
			sprite.dispose();
			removeChild(sprite);
			sprite = new Sprite();
			sprite.x = 315;
			sprite.y = 170;
			addChild(sprite);
			
			var suppliesBackground:Image = new Image (asset.getTexture("SuppliesScreen"));
			sprite.addChild(suppliesBackground);
			
			suppliesMinus = new Button (asset.getTexture("MinusButton"));
			suppliesMinus.x = 220;
			suppliesMinus.y = 250;
			sprite.addChild(suppliesMinus);
			
			var suppliesNumberBox:Image = new Image (asset.getTexture("NumberBox"));
			suppliesNumberBox.x = 550;
			suppliesNumberBox.y = 250;
			sprite.addChild(suppliesNumberBox);
			
			suppliesNumberTextField = new TextField (510, 200, suppliesNumber.toString(10),"",100, 0x333333);
			suppliesNumberTextField.x = 550;
			suppliesNumberTextField.y = 250;
			sprite.addChild(suppliesNumberTextField);
			
			//button with +5 or +10 supplies perhaps? Constant tapping might get tedious at the higher supply capacities.
			suppliesPlus = new Button (asset.getTexture("PlusButton"));
			suppliesPlus.x = 1120;
			suppliesPlus.y = 250;
			sprite.addChild(suppliesPlus);
			
			buySupplies = new Button (asset.getTexture("buyButton"));
			buySupplies.x = 580;
			buySupplies.y = 530;
			sprite.addChild(buySupplies);
			
			priceForSuppliesText = new TextField (210, 140, priceForSupplies.toString(10), "", 60, 0xFFFFFF);
			priceForSuppliesText.x = 590;
			priceForSuppliesText.y = 530;
			sprite.addChild(priceForSuppliesText);
			
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
			sprite.removeChild(priceForSuppliesText);
			priceForSuppliesText = new TextField (210, 140, priceForSupplies.toString(10), "", 60, 0xFFFFFF);
			priceForSuppliesText.x = 590;
			priceForSuppliesText.y = 530;
			sprite.addChild(priceForSuppliesText);
			
			sprite.removeChild(suppliesNumberTextField);
			suppliesNumberTextField = new TextField (510, 200, suppliesNumber.toString(10),"",100, 0x333333);
			suppliesNumberTextField.x = 550;
			suppliesNumberTextField.y = 250;
			sprite.addChild(suppliesNumberTextField);			
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
			sprite.addChild(lackOfMoney);
			sprite.addChild(close);
		}
		
		private function closeLackOfMoneyForSupplies():void
		{
			sprite.removeChild(lackOfMoney);
			sprite.removeChild(close);
			addSuppliesEventListeners();
		}
		
// *STATS************************************************************************************
		
		private function statsScreen (e:Event):void
		{
			infoScreen();
		}
		
		private function infoScreen ():void
		{
			sprite.dispose();
			removeChild(sprite);
			sprite = new Sprite();
			sprite.x = 315;
			sprite.y = 170;
			addChild(sprite);
			
			var dayReport:Image = new Image (asset.getTexture("DailyReportScreen"));
			sprite.addChild(dayReport);
			
			// *DOCTORS AND FINANCIAL************************************************
			
			suppliesBought += 15;
			trace("suppliesBought  " + suppliesBought);
			
			if (suppliesBought == maxNumberOfSupplies && suppliesBought - doctors * 15 == 0)
			{
				var balancedDoctors:Image = new Image (asset.getTexture("BalancedGoodJob"));
				balancedDoctors.x = 350;	//335
				balancedDoctors.y = 750;
				addChild(balancedDoctors);
				
				var stable:Image = new Image (asset.getTexture("StableIncome"));
				stable.x = 1425;
				stable.y = 750;
				addChild(stable);
			}  
			else if (suppliesBought - doctors * 15 < 0)
			{
				var overstaff:Image = new Image (asset.getTexture("OverstaffedRumours"));
				overstaff.x = 350;	//335
				overstaff.y = 750;
				addChild(overstaff); 
				
				var moreThenExpected:Image = new Image (asset.getTexture("MoreThenExpected"));
				moreThenExpected.x = 1425;
				moreThenExpected.y = 740;
				addChild(moreThenExpected);
			}
			else
			{
				var exhaustedDoctors:Image = new Image (asset.getTexture("UnderstaffedExhausted"));
				exhaustedDoctors.x = 350;	//335
				exhaustedDoctors.y = 740;
				addChild(exhaustedDoctors);
				
				var lessPatientsExpected:Image = new Image (asset.getTexture("LessPatientsExpected"));
				lessPatientsExpected.x = 1425;
				lessPatientsExpected.y = 740;
				addChild(lessPatientsExpected);
			}			
			
			// *INFECTIVITY*********************************************************
			var inf:Number = View.View.getInstance().getInfectivity();

			if (inf  <= 0.3)
			{
				var min:Image = new Image (asset.getTexture("InfectivityMinimunIncr"));
				min.x = 580;
				min.y = 570;
				sprite.addChild(min);
				
			} else if (inf > 0.3 && inf <= 0.5)
			{
				var rapidly:Image = new Image (asset.getTexture("InfectivityRapidlyIncr"));
				rapidly.x = 580;
				rapidly.y = 570;
				sprite.addChild(rapidly);
				
			} else if (inf <= 0.7)
			{
				var massive:Image = new Image (asset.getTexture("InfectivityMassiveIncr"));
				massive.x = 580;
				massive.y = 570;
				sprite.addChild(massive);
				
			} else if (inf <= 0.9)
			{
				var warning:Image = new Image (asset.getTexture("InfectivityWarning"));
				warning.x = 580;
				warning.y = 570;
				sprite.addChild(warning);
			}
			
			// *FINANCIAL**************************************************************
			
			
		}
		
		private function Destroy():void{
			asset.dispose();
		}
		
		public static function getInstance():ShopMenu
		{
			return instance;
		}
		 
	}
	
}
