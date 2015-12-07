package  ScreenSwitcher{
	import flash.filesystem.File;
	
	import MainMenu.MainMenu;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.utils.AssetManager;
	
	/**
	 * the class that takes care of switching screens in the application (i.e. menu, game, credits)
	 * 
	 *
	 */
	public class ScreenSwitcher extends Sprite
	{
		private static var instance:ScreenSwitcher = new ScreenSwitcher();
		private var screen:Sprite;
		
		/**
		 * The constructor
		 * Tells this class to initialize once it is placed onto the stage
		 *
		 */
		public function ScreenSwitcher() 
		{
			addEventListener( Event.ADDED_TO_STAGE, initialize );
		}
		
		public static function getInstance():ScreenSwitcher{
			return instance;
		}
		
		/**
		 * The initialization consists of: 
		 * Making sure the first screen is loaded
		 */
		private function initialize( event:Event ):void
		{
			loadScreen( MainMenu );
		}
		
		/**
		 * One function to load any screen passed into it.
		 * The screen to load is passed as its class name.
		 * so, this function is called like: 
		 * loadScreen( Game ) or loadScreen( Menu )
		 *
		 */
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