package  MainInfo{
	
	import flash.filesystem.File;
	
	import Level1.Level1;
	
	import Shop.ShopMenu;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	public class MainInfo extends Sprite{

		private var asset:AssetManager;
		//public static var conceptBar:Image;
		//public static var conceptBar:DisplayObject;
		
		public function MainInfo() 
		{
			asset = new AssetManager;
			var folder:File = File.applicationDirectory.resolvePath("MainInfo/assets");
			asset.enqueue( folder );
			asset.loadQueue( onProgress );
		}
			
		private function onProgress( ratio:Number ):void
		{
			if( ratio == 1 )
			{
				addConceptBar();
			}
		}	
			
		public function addConceptBar():void
		{	
			var conceptBar:Image = new Image(asset.getTexture("TopBar"));
			addChildAt(conceptBar, 0);
			
			var infectivityBar:Image = new Image (asset.getTexture("Infectivity"));
			infectivityBar.x = stage.stageWidth - 1390;
			infectivityBar.y = 12;
			addChild(infectivityBar);
			
		}
		
		/*private function staffScreen (e:Event):void
		{
			//removeChild(sprite);
			
		}*/
	}
}

