package General
{
	import starling.display.Image;
	import starling.display.Sprite;

	public class Placeholder extends Sprite{
		//individual rooms
		private var position1:Array = new Array();
		private var position2:Array = new Array();
		private var position3:Array = new Array();
		private var position4:Array = new Array();
		private var position5:Array = new Array();
		//rooms in array
		private var TreatRooms:Array  = new Array();
		private var WaitRooms:Array  = new Array();
		private var SupplyRooms:Array  = new Array();
		
		private var Rooms:Array = new Array();
		
		
		/**
		 * method to initialize variables that hold room information
		 * @true/false: is the room assigned?
		 * @x/y: positions of the room
		 */
		public function Placeholder(){
			position1.push(false);
			position1.push(false);
			position1.push(1070);
			position1.push(584);
			
			position2.push(false);
			position2.push(false);
			position2.push(695);
			position2.push(584);
			
			position3.push(false);
			position3.push(false);
			position3.push(220);
			position3.push(584);
			
			position4.push(false);
			position4.push(false);
			position4.push(420);
			position4.push(155);
			
			position5.push(false);
			position5.push(false);
			position5.push(45);
			position5.push(155);
		}
		
		/**
		 * method to add rooms depending on availability
		 * @param texture: the image to display
		 */
		public function Add(texture:Image, identifier:int):void{
			if(identifier == 0) addTreatment(texture);
			if(identifier == 1) addSupply(texture);
			if(identifier == 2) addWaiting(texture);
			//room 1
			if(!position1[0]){
				position1[0] = texture;
				texture.x = position1[2];
				texture.y = position1[3];
				Rooms.push(position1[0]);
				return;
			}
			//room 2
			if(!position2[0]){
				position2[0] = texture;
				texture.x = position2[2];
				texture.y = position2[3];
				Rooms.push(position2[0]);
				return;
			}
			
			//room 3
			if(!position3[0]){
				position3[0] = texture;
				texture.x = position3[2];
				texture.y = position3[3];
				Rooms.push(position3[0]);
				return;
			}
			
			//room 4
			if(!position4[0]){
				position4[0] = texture;
				texture.x = position4[2];
				texture.y = position4[3];
				Rooms.push(position4[0]);
				return;
			}
			
			//room 5
			if(!position5[0]){
				position5[0] = texture;
				texture.x = position5[2];
				texture.y = position5[3];
				Rooms.push(position5[0]);
				return;
			}
		}
		
		/**
		 * method to synchronise with stage
		 */
		public function Synchronise():Array{
			return Rooms;
		}
		
		public function addSupply(object:Image):void{
			this.SupplyRooms.push(object);
		}
		
		public function getSupply():Array{
			return this.SupplyRooms;
		}
		
		public function addTreatment(object:Image):void{
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
	}
}