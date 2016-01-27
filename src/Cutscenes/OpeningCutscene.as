package Cutscenes
{
	import flash.display.Loader;
	import flash.net.URLRequest;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.MovieClip;

	public class OpeningCutscene extends MovieClip
	{	
		private var loader:Loader = new Loader();
		private var swfFile:URLRequest = new URLRequest("assets/Openingcrawl.swf");
		//public var checker:Boolean = false;
		public var checker:Boolean = new Boolean;
		
		public function OpeningCutscene(parent:DisplayObjectContainer):void
		{
			super(parent, 12);
			/*loader.load(swfFile);*/
			addChild(loader);
		}
		
		public function addChild(loader:Loader):void
		{
			if(checker == true){
			loader.load(swfFile);
			}
		}
	}
}