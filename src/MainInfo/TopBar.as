package MainInfo
{
	import flash.filesystem.File;
	
	import View.View;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.AssetManager;
	
	public class TopBar extends Sprite
	{
		private var asset:AssetManager;
		private var topBarBackground:Image;
		private var infectivityBar:Image;
		private var supplies:Image;
		private var money:Image;
		public var budget:int = 100000;
		public var budgetTextField:TextField;
		private var numberOfSuppliesText:TextField;
		public var numberOfSupplies:int = 10;
		private var maxNumberOfSuppliesText:TextField;
		public var maxNumberOfSupplies:int = 30;
		private var infectivityColor:Image;
		private var infectivityColorWhite:Image;
		public var currentInfectivity:Number = 0;
		private var curInf:Number;
		private var infPcentText:TextField;
		private var infPcent:int = 0;
		private var gameOver:Image;
		
		private var button:Button;
		
		public function TopBar()
		{
			addEventListener(Event.ADDED_TO_STAGE, Initialize);
		}
		
		private function Initialize():void{
			asset = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath("MainInfo/assets");
			asset.enqueue(folder);
			asset.loadQueue(onProgress);
		}
		
		private function onProgress(ratio:Number):void
		{
			if(ratio == 1)
			{
				start();
			}
		}
		
		private function start():void
		{
			topBarBackground = new Image(asset.getTexture("TopBarBackground"));
			addChildAt(topBarBackground, 0);
			
			supplies = new Image(asset.getTexture("Supplies"));
			supplies.x = 40;
			supplies.y = 12;
			addChild(supplies);
			
			numberOfSuppliesText = new TextField (100, 100, numberOfSupplies.toString(10), "", 70, 0x333333);
			numberOfSuppliesText.x = 190;
			numberOfSuppliesText.y = 30;
			addChild(numberOfSuppliesText);
			
			maxNumberOfSuppliesText = new TextField (100, 100, maxNumberOfSupplies.toString(10), "", 70, 0x333333);
			maxNumberOfSuppliesText.x = 360;
			maxNumberOfSuppliesText.y = 30;
			addChild(maxNumberOfSuppliesText);
			
			infectivityColorWhite = new Image (asset.getTexture("InfectivityColorWhite"));
			infectivityColorWhite.x = 600;
			infectivityColorWhite.y = 12;
			addChild(infectivityColorWhite);
			
			infectivityColor = new Image (asset.getTexture("InfectivityColor"));
			infectivityColor.x = 600;
			infectivityColor.y = 12;
			infectivityColor.scaleX = currentInfectivity;
			addChild(infectivityColor);
			
			infectivityBar = new Image (asset.getTexture("Infectivity"));
			infectivityBar.x = 600;
			infectivityBar.y = 12;
			addChild(infectivityBar);
			
			infPcentText = new TextField (220, 120, infPcent.toString(10) + "%", "Trajan Pro", 80, 0x333333);
			infPcentText.x = 900;
			infPcentText.y = 17;
			addChild(infPcentText);
			
			money = new Image (asset.getTexture("Money"));
			money.x = 1160;
			money.y = 12;
			addChild(money);
			
			budgetTextField = new TextField(533, 130, budget.toString(10),"Trajan Pro",100,0x333333);
			budgetTextField.x = 1230;
			budgetTextField.y = 15;
			addChild(budgetTextField);
			
			button = new Button (asset.getTexture("button"), "TRY");
			button.x = 100;
			button.y = 200;
			addChild(button);
			button.addEventListener(Event.TRIGGERED, changeInf);
			
		}
		
		public function update():void
		{
			updateBudget();
			updateSupplies();
		}
		
		private function updateBudget():void
		{
			removeChild(budgetTextField);
			budgetTextField = new TextField(533, 130, budget.toString(10),"Trajan Pro",100,0x333333);
			budgetTextField.x = 1230;
			budgetTextField.y = 15;
			addChild(budgetTextField);
		}
		
		private function updateSupplies():void
		{
			removeChild(numberOfSuppliesText);
			numberOfSuppliesText = new TextField (100, 100, numberOfSupplies.toString(10), "", 70, 0x333333);
			numberOfSuppliesText.x = 190;
			numberOfSuppliesText.y = 30;
			addChild(numberOfSuppliesText);
			
			removeChild(maxNumberOfSuppliesText);
			maxNumberOfSuppliesText = new TextField (100, 100, maxNumberOfSupplies.toString(10), "", 70, 0x333333);
			maxNumberOfSuppliesText.x = 360;
			maxNumberOfSuppliesText.y = 30;
			addChild(maxNumberOfSuppliesText);
		}
		
		private function changeInf():void
		{
			if (currentInfectivity < 0.9)
			{
				currentInfectivity += 0.1;
				currentInfectivity = Math.floor(currentInfectivity * 100) / 100;
				trace("is changeInf  "+currentInfectivity);

				updateInfectivity();
			}
			else if (currentInfectivity == 0.9) 
				{
					currentInfectivity += 0.1;
					currentInfectivity = Math.floor(currentInfectivity * 100) / 100;
					updateInfectivity();
					gameOver = new Image (asset.getTexture("GameOver"));
					addChild(gameOver);
			}
		}
		
		public function updateInfectivity():void
		{
			trace("updatas  "+currentInfectivity);
			infectivityColor.scaleX = currentInfectivity;
			infPcent = currentInfectivity * 100;
			removeChild(infPcentText);
			infPcentText = new TextField (220, 120, infPcent.toString(10) + "%", "Trajan Pro", 80, 0x333333);
			infPcentText.x = 900;
			infPcentText.y = 17;
			addChild(infPcentText);
		}
		
	}
}






