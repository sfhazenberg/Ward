package  Level1{
	import flash.filesystem.File;
	
	import MainInfo.MainInfo;
	
	import ScreenSwitcher.ScreenSwitcher;
	
	import Shop.ShopMenu;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	
	public class Level1 extends MainInfo {
		
		[Embed(source="assets/spritesheet_doctor.xml", mimeType="application/octet-stream")]
		public static const AtlasXML:Class;
		[Embed(source="assets/spritesheet_doctor.png")]
		public static const AtlasTexture:Class;
		public static var asset:AssetManager;
		private var doctor1:MovieClip;
		var texture:Texture = Texture.fromEmbeddedAsset(AtlasTexture);
		var xml:XML = XML(new AtlasXML());
		var atlas:TextureAtlas = new TextureAtlas(texture, xml);
		
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
			var shopButton:Button = new Button (asset.getTexture("ExitButtonUp"), "", asset.getTexture("ExitButtonDown"));
			shopButton.x = stage.stageWidth - 100;
			shopButton.y = 50;
			shopButton.addEventListener( Event.TRIGGERED, goToShop)
			addChild(shopButton);
			
			var waitingRoom:Image = new Image(asset.getTexture("waiting_room"));
			waitingRoom.x = stage.stageWidth - 375;
			waitingRoom.y = stage.stageHeight - 329;
			addChild(waitingRoom);
			
			var supplyRoom:Image = new Image(asset.getTexture("supply_room"));
			supplyRoom.x = stage.stageWidth - 755;
			supplyRoom.y = stage.stageHeight - 329;
			addChild(supplyRoom);
			
			var treatmentRoom:Image = new Image(asset.getTexture("treatment_room"));
			treatmentRoom.x = stage.stageWidth - 1135;
			treatmentRoom.y = stage.stageHeight - 329;
			addChild(treatmentRoom);
			
			
			//doctor1 = new MovieClip(asset.getTextures("Doctor"), 6);
			//doctor1.x = doctor1.y = 300;
			//addChild( doctor1 );
			//Starling.juggler.add( doctor1 );
			doctor1 = new MovieClip(atlas.getTextures("Doctor_Front000"), 6);
			doctor1.x = doctor1.y = 300;
			addChild( doctor1 );
			Starling.juggler.add( doctor1 );
			
			
		}
		
		private function goToShop (e:Event):void
		{
			ScreenSwitcher.ScreenSwitcher.getInstance().loadScreen( ShopMenu );
		}
		
		
	}
	
}
