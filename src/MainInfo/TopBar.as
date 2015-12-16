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
		public var budget:int = 10000;
		public var money:TextField;
		private var conceptBar:Image;
		private var infectivityBar:Image;
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
			conceptBar = new Image(asset.getTexture("TopBar"));
			addChildAt(conceptBar, 0);
			
			infectivityBar = new Image (asset.getTexture("Infectivity"));
			infectivityBar.x = 530;
			infectivityBar.y = 12;
			addChild(infectivityBar);
			
			money = new TextField(533, 130, View.View.getInstance().getBudget()+"","",130,0xFFFFFF);
			money.x = 1300;
			money.y = 15;
			
			addChild(money);
			
		}
		
		public function update():void
		{
			updateBudget();
		}
		
		private function updateBudget():void
		{
			this.money.text = View.View.getInstance().getBudget().toString(10);
		}
	}
}