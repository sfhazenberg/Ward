package General
{
	public class GeneralChecker
	{
		private static var instance:GeneralChecker;
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
			//RoomGrids["TRE_1"] = false;
			//RoomGrids["WAI_1"] = false;
			//RoomGrids["SUP_1"] = false;
			
			Texture = new Array();
			Texture["TRE_1"] = false;
			Texture["WAI_1"] = false;
			Texture["SUP_1"] = false;
			
			//trace('sizeofTexture: ' + Texture.length);

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
		 * method to set room textures within the hospital from Shop
		 * @param room: can be TRE, WAI, SUP
		 * @param value: true (show), false (don't show)
		 */
		public function setTextureRooms(room:int, value:Boolean):void
		{
			this.Texture[room] = value;
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
		 * method to get the texture of the rooms
		 */
		public function getTexture(Name:int):Boolean
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