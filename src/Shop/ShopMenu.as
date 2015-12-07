﻿package  Shop{
	
	import flash.filesystem.File;
	
	import ScreenSwitcher.ScreenSwitcher;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	public class ShopMenu extends Sprite {
		
		private var asset:AssetManager;
		private var screenSwitcher:ScreenSwitcher;
		private var sprite:Sprite;

		public function ShopMenu( screenSwitcher:ScreenSwitcher ) {
			
			this.screenSwitcher = screenSwitcher;
			addEventListener( Event.ADDED_TO_STAGE, initialize );
		}
		
		public function initialize (event:Event):void 
		{			
			asset = new AssetManager;
			var folder:File = File.applicationDirectory.resolvePath("assets/game");
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
			var conceptBar:Image = new Image(asset.getTexture("ConceptBar"));
			addChild(conceptBar);
			
			var upgradeButton:Button = new Button ( asset.getTexture("up_upgrade"), "Upgrades", asset.getTexture("down_upgrade"));
			upgradeButton.y = 300;
			addChild(upgradeButton);
			
			var staffButton:Button = new Button ( asset.getTexture("up_staff"), "Staff", asset.getTexture("down_staff"));
			staffButton.y = 400;
			addChild(staffButton);
			
			var suppliesButton:Button = new Button ( asset.getTexture("up_supplies"), "Suplies", asset.getTexture("down_supplies"));
			suppliesButton.y = 500;
			addChild(suppliesButton);
			
			var statsButton:Button = new Button ( asset.getTexture("up_stats"), "Information", asset.getTexture("down_stats"));
			statsButton.y = 600;
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
		
		private function upgradeScreen (e:Event):void
		{
			removeChild(sprite);
			sprite = new Sprite();
			sprite.x = 500;
			sprite.y = 500;
			addChild(sprite);
			var upgradeImage:Image = new Image (asset.getTexture("shopScreenUpgrades_PH"));
			sprite.addChild(upgradeImage);
		}
		
		private function staffScreen (e:Event):void
		{
			removeChild(sprite);
			sprite = new Sprite();
			sprite.x = 500;
			sprite.y = 500;
			addChild(sprite);
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
	

