package View
{
	import Level1.Level1;
	
	import MainInfo.GameOver;
	import MainInfo.TopBar;
	
	import MainMenu.MainMenu;
	
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
		
		public function getNumberOfSupplies():int
		{
			return this.topBar.numberOfSupplies;
		}
		
		public function setNumberOfSupplies(n:int):void
		{
			this.topBar.numberOfSupplies = n;
		}
		
		public function suppliesNumberWhenDayStarts():int
		{
			return this.topBar.suppliesBought;
		}
		
		public function getMaxNumberOfSupplies():int
		{
			return this.topBar.maxNumberOfSupplies;
		}
		
		public function setMaxNumberOfSupplies(n:int):void
		{
			this.topBar.maxNumberOfSupplies = n;
		}
		
		public function getInfectivity():Number
		{
			return this.topBar.currentInfectivity;
		}
		
		public function setInfectivity(i:Number):void
		{
			this.topBar.currentInfectivity = i;
		}
		
		public function updateInf():void
		{
			topBar.updateInfectivity();
		}
		
		public function updateInfPlus():void
		{
			topBar.changeInf();
		}
		
		public function getDoctors():int
		{
			return this.topBar.numberOfDoctors;
		}
		
		public function setDoctors(d:int):void
		{
			this.topBar.numberOfDoctors = d;
		}
		
		public function destroy():void
		{
			while (numChildren > 0) {
				removeChildAt(0);
			}
			loadScreen(GameOver);
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