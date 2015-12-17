package MainInfo
{
	import flash.filesystem.File;
	
	import View.View;
	
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
		public var amountOfSupplies:int = 30;
		
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
			supplies.x = 30;
			supplies.y = 15;
			addChild(supplies);
			
			infectivityBar = new Image (asset.getTexture("Infectivity"));
			infectivityBar.x = 440;
			infectivityBar.y = 12;
			addChild(infectivityBar);
			
			money = new Image (asset.getTexture("Money"));
			money.x = 1100;
			money.y = 15;
			addChild(money);
			
			budgetTextField = new TextField(533, 130, budget.toString(10),"",100,0x333333);
			budgetTextField.x = 1200;
			budgetTextField.y = 15;
			addChild(budgetTextField);
			
		}
		
		public function update():void
		{
			updateBudget();
		}
		
		private function updateBudget():void
		{
			removeChild(budgetTextField);
			budgetTextField = new TextField(533, 130, budget.toString(10),"",100,0x333333);
			budgetTextField.x = 1200;
			budgetTextField.y = 15;
			
			addChild(budgetTextField);
		}
	}
}