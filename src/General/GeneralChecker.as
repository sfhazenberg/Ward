package General
{
	public class GeneralChecker
	{
		private static var instance:GeneralChecker;
		private static var gridView:Boolean = false;
		/** An array holding room information **/
		private var Rooms:Array;
		
		public function GeneralChecker(){
			trace("loading constructor");
			Rooms = new Array();
			Rooms["TRE"] = false;
			Rooms["WAI"] = false;
			Rooms["SUP"] = false;
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
		
		/**
		 * method to alter state of room(s)
		 * @param room:	can be: TRE,WAI,SUP
		 * @param value:	true (show), false (don't show)
		 */
		public function setRooms(room:String, value:Boolean):void{
			this.Rooms[room] = value;
		}
		
		/**
		 * method to get the states of the rooms
		 */
		public function getRooms():Array{
			return this.Rooms;
		}
	}
}