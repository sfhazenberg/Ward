package General
{
	public class GeneralChecker
	{
		private static var instance:GeneralChecker;
		private static var gridView:Boolean = false;
		
		/** An array holding room information **/
		private var Rooms:Array;
		private var Texture:Array;
		private var hallwayH:Array;
		
		public function GeneralChecker()
		{
			trace("loading constructor");
			Rooms = new Array();
			Rooms["TRE"] = false;
			Rooms["WAI"] = false;
			Rooms["SUP"] = false;
			Texture = new Array();
			Texture["TRE"] = false;
			Texture["WAI"] = false;
			Texture["SUP"] = false;
			hallwayH = new Array;
			hallwayH["0"] = false;
		}
		
		public static function getInstance():GeneralChecker
		{
			if(instance == null)
			{
				instance = new GeneralChecker();
			}
			return instance;
		}
		
		public function setGridView(identifier:Boolean):void
		{
			gridView = identifier;
		}
		
		public function getGridView():Boolean
		{
			return gridView;
		}
		
		/**
		 * method to alter state of room(s)
		 * @param room:	can be: TRE,WAI,SUP
		 * @param value:	true (show), false (don't show)
		 */
		public function setRooms(room:String, value:Boolean):void
		{
			this.Rooms[room] = value;
		}
		
		/**
		 * method to set room textures within the hospital from Shop
		 * @param room: can be TRE, WAI, SUP
		 * @param value: true (show), false (don't show)
		 */
		public function setTextureRooms(room:String, value:Boolean):void
		{
			this.Texture[room] = value;
		}
		
		/**
		 * method to set newly added hallways when newly added rooms are out of reach of a hallway
		 * @param hallway: can be 0, 1, 2, etc
		 * @param value: true (show), false (don't show)
		 */
		public function setHallwayH(room:String, value:Boolean):void
		{
			this.hallwayH[room] = value;
		}
		
		/**
		 * method to get the states of the rooms
		 */
		public function getRooms():Array
		{
			return this.Rooms;
		}
		
		/**
		 * method to get the texture of the rooms
		 */
		public function getTexture(Name:String):Boolean
		{
			return this.Texture[Name];
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