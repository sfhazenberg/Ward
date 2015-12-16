package General
{
	public class GeneralChecker
	{
		private static var instance:GeneralChecker;
		private static var gridView:Boolean = false;
		
		public function GeneralChecker(){
			trace("loading constructor");
		}
		
		public static function getInstance():GeneralChecker{
			if(instance == null){
				instance = new GeneralChecker();
			}
			return instance;
		}
		
		public function setGridView(identifier:Boolean):void{
			gridView = identifier;
		}
		
		public function getGridView():Boolean{
			return gridView;
		}
		
	}
}