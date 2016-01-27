package General
{
	import Level1.Level1;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * Class responsible for placing the images in the right place.
	 */
	public class Placeholder extends Sprite{
		//individual rooms, including x/y position in array
		private var position1:Array = new Array();
		private var position2:Array = new Array();
		private var position3:Array = new Array();
		private var position4:Array = new Array();
		private var position5:Array = new Array();
		//rooms in array to identify which room is pressed in Level1
		private var TreatRooms:Array  = new Array();
		private var WaitRooms:Array  = new Array();
		private var SupplyRooms:Array  = new Array();
		//all rooms stored in a single array
		private var Rooms:Array = new Array();
		//all none grid rooms
		private var noneGridRooms:Array = new Array();
		
		/**
		 * method to initialize variables that hold room information
		 * @false: No room assigned
		 * @x/y: positions of the room
		 */
		public function Placeholder(){
			position1.push(false);
			position1.push(1070);
			position1.push(584);
						
			position2.push(false);
			position2.push(695);
			position2.push(584);
			
			position3.push(false);
			position3.push(220);
			position3.push(584);
			
			position4.push(false);
			position4.push(420);
			position4.push(155);
			
			position5.push(false);
			position5.push(45);
			position5.push(155);
		}
		
		/**
		 * method to add rooms depending on availability
		 * @param texture: the image to display
		 * @param identifier: the specific room to load (0 = treatment, 1 = supply, 2 = waiting)
		 * position 1 to 5 is checked whether it has been filled or not, if filled continue at next position
		 * return ends the function
		 */
		public function Add(texture:Image, identifier:int):void{
			if(identifier == 0) addTreat(texture);
			if(identifier == 1) addSupply(texture);
			if(identifier == 2) addWaiting(texture);
			//room 1
			if(!position1[0]){
				position1[0] = texture;
				texture.x = position1[1];
				texture.y = position1[2];
				Rooms.push(position1[0]);
				return;
			}
			
			//room 2
			if(!position2[0]){
				position2[0] = texture;
				texture.x = position2[1];
				texture.y = position2[2];
				Rooms.push(position2[0]);
				return;
			}
			
			//room 3
			if(!position3[0]){
				position3[0] = texture;
				texture.x = position3[1];
				texture.y = position3[2];
				Rooms.push(position3[0]);
				GeneralChecker.getInstance().setHallwayH(0, true);
				return;
			}
			
			//room 4
			if(!position4[0]){
				position4[0] = texture;
				texture.x = position4[1];
				texture.y = position4[2];
				Rooms.push(position4[0]);
				return;
			}
			
			//room 5
			if(!position5[0]){
				position5[0] = texture;
				texture.x = position5[1];
				texture.y = position5[2];
				Rooms.push(position5[0]);
				return;
			}
		}
		
		/**
		 * method to synchronise with stage
		 * @return Array: returns all rooms added
		 */
		public function Synchronise():Array{
			return Rooms;
		}
		
		/**add/get methods to add specific rooms **/
		public function addSupply(object:Image):void{
			this.SupplyRooms.push(object);
		}
		
		public function getSupply():Array{
			return this.SupplyRooms;
		}
		
		public function addTreat(object:Image):void{
			this.TreatRooms.push(object);
		}
		
		public function getTreat():Array{
			return this.TreatRooms;
		}
		
		public function addWaiting(object:Image):void{
			this.WaitRooms.push(object);
		}
		
		public function getWaiting():Array{
			return this.WaitRooms;
		}
		
		/**
		 * method that overwrites grid with actual room texture
		 */
		public function overwriteGrid(texture:Image):void{
			this.noneGridRooms.push(texture);
		}
		
		public function getOverwrite():Array{
			return this.noneGridRooms;
		}
	}
}