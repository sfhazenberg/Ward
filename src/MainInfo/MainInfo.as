package  MainInfo{
	
	import flash.filesystem.File;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	import starling.display.DisplayObject;
	
	public class MainInfo extends Sprite{

		private var asset:AssetManager;
		public static var conceptBar:Image;
		//public static var conceptBar:DisplayObject;
		
		public function MainInfo() 
		{
			asset = new AssetManager;
			var folder:File = File.applicationDirectory.resolvePath("Main/assets");
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
			conceptBar = new Image(asset.getTexture("TopBar"));
			addChild(conceptBar);
		}
	}
}

