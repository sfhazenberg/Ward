package View
{

	import MainInfo.TopBar;
	
	import MainMenu.MainMenu;
	
	import Shop.ShopMenu;
	
	import starling.display.Sprite;
	import starling.events.Event;	

	public class View extends Sprite
	{
		private static var instance:View = new View();
		private var screen:Sprite;
		private var topBar:TopBar = new TopBar();
		
	
		public function View() 
		{
			addEventListener( Event.ADDED_TO_STAGE, initialize );
		}
		
		public static function getInstance():View{
			return instance;
		}
		
		public function updateTopBar():void
		{
			topBar.update();
		}
		
		public function getTopBar():TopBar
		{
			return topBar;
		}
		
		public function getBudget():int
		{
			return this.topBar.budget;
		}
		
		public function setBudget(b:int):void
		{
			this.topBar.budget = b;
		}
		
		private function initialize( event:Event ):void
		{
			loadScreen( MainMenu );
		}

		public function loadScreen( screenToLoad:Class ):void
		{
			// if a previous screen is present, remove it first
			if( screen != null && contains( screen ) )
			{
				removeChild( screen, true );
			}
			
			// instantiate the screen to load with a reference to this classph
			screen = new screenToLoad();
			addChild( screen );
		}
	}
}