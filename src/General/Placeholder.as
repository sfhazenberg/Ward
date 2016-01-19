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
		private var Rooms:Array  = new Array();
		
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
			
			Rooms = new Array();
		}
		
		/**
		 * method to add rooms depending on availability
		 * @param texture: the image to display
		 */
		public function Add(texture:Image):void{
			//room 1
			if(!position1[0]){
				position1[0] = texture;
				texture.x = position1[2];
				texture.y = position1[3];
				Rooms.push(position1[0]);
				return;
			}
			if(!position1[1]){
				position1[1] = texture;
				texture.x = position1[2];
				texture.y = position1[3];
				roomChecker(position1[0]);
				Rooms.push(position1[1]);
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
			if(!position2[1]){
				position2[1] = texture;
				texture.x = position2[2];
				texture.y = position2[3];
				roomChecker(position2[0]);
				Rooms.push(position2[1]);
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
			if(!position3[1]){
				position3[1] = texture;
				texture.x = position3[2];
				texture.y = position3[3];
				roomChecker(position3[0]);
				Rooms.push(position3[1]);
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
			if(!position4[1]){
				position4[1] = texture;
				texture.x = position4[2];
				texture.y = position4[3];
				roomChecker(position4[0]);
				Rooms.push(position4[1]);
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
			if(!position5[1]){
				position5[1] = texture;
				texture.x = position5[2];
				texture.y = position5[3];
				roomChecker(position5[0]);
				Rooms.push(position5[1]);
				return;
			}
		}
		
		/**
		 * method to synchronise with stage
		 */
		public function Synchronise():Array{
			return Rooms;
		}
		
		private function roomChecker(object:Image):void{
			for(var loop:int = 0; loop < Rooms.length; loop++){
				if(Rooms[loop] == object){
					Rooms[loop] = null;
					return;
				}
			}
		}
	}
}