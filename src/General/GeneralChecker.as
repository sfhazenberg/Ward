package General
{
	import starling.display.Image;
	
	/**
	 * class responsible for handling static rooms
	 */
	public class GeneralChecker
	{
		private static var instance:GeneralChecker;
		//instance is created when GeneralChecker is first called
		private var instance_placeholder:Placeholder = new Placeholder();
		private static var gridView:Boolean = false;
		
		/** An array holding room information **/
		private var RoomGrids:Array;
		private var Texture:Array;
		private var hallwayH:Array;
		
		public function GeneralChecker()
		{
			//variablenaam[indextype] = variabletype
			trace("loading constructor");

			RoomGrids = new Array();
			RoomGrids[0] = true;	//TRE_1
			RoomGrids[1] = true;	//WAI_1
			RoomGrids[2] = true;	//SUP_1

			for(var loop:int = 0; loop < RoomGrids.length; loop++)
			{
				RoomGrids[loop] = false;
			}
			
			for each(var o:Boolean in RoomGrids)
			{
				trace(o);
			}
			
			hallwayH = new Array;
			hallwayH[0] = false;
		}
		
		/**
		 * singleton method that returns instance of generalChecker, this way the same generalChecker object can be called by any class
		 * @return Generalchecker, isntance of this class.
		 */
		public static function getInstance():GeneralChecker
		{
			if(instance == null)
			{
				instance = new GeneralChecker();
			}
			return instance;
		}
		
		/**
		 * method that returns placeholder, initiated when GeneralChecker is run first time
		 */
		public function getPlaceHolder():Placeholder{
			return instance_placeholder;
		}
		
		/**
		 * method to alter state of room(s)
		 * @param room:	can be: TRE,WAI,SUP
		 * @param value:	true (show), false (don't show)
		 */
		public function setRoomGrids(room:int, value:Boolean):void
		{
			this.RoomGrids[room] = value;
		}
		
		public function removeRoomGrids():void
		{
			for(var loop:int = 0; loop < RoomGrids.length; loop++)
			{
				RoomGrids[loop] = false;
			}
		}
		
		/**
		 * method to set newly added hallways when newly added rooms are out of reach of a hallway
		 * @param hallway: can be 0, 1, 2, etc
		 * @param value: true (show), false (don't show)
		 */
		public function setHallwayH(room:int, value:Boolean):void
		{
			this.hallwayH[room] = value;
		}
		
		/**
		 * method to get the states of the rooms
		 */
		public function getRoomGrids():Array
		{
			return this.RoomGrids;
		}
		
		/**
		 * method to get the texture(s) of the hallways
		 */
		public function getHallwayH(Name:String):Boolean
		{
			return this.hallwayH[Name];
		}
	}
}