package Movement{
	import General.GeneralChecker;
	
	import flash.geom.Point;
	
	import starling.display.MovieClip;
	import starling.events.Event;
	
	public class Movement{
		//destionation
		private var destination:Point = new Point(0, 0);
		
		private var destinationTriggers:Array = new Array;
		private var destinationBooleans:Array = new Array;
		
		//instance of doctor
		private var doctorInstance:MovieClip;
		
		public function Movement(doc:MovieClip){
				this.doctorInstance = doc;
				destinationTriggers.push(new Point(doc.x, 450));
				destinationBooleans.push(true);
				destinationTriggers.push(new Point(1620,450));	//960x
				destinationBooleans.push(false);
				destinationTriggers.push(new Point(1620,300));	//960x
				destinationBooleans.push(false);
				destinationTriggers.push(new Point(1620,450));	//960x
				destinationBooleans.push(false);
				destinationTriggers.push(new Point(1000,450));	//960x
				destinationBooleans.push(false);
				doctorInstance.addEventListener(Event.ENTER_FRAME, movedoctor);
		}
		
		public function newTarget(target:Point):void{
			destinationTriggers.push(target);
			destinationBooleans.push(false);
		}
		
		/**
		 * method to move the doctor
		 */
		private function movedoctor(e:Event):void 
		{		
				// -1 means default flag. if -1 is not changed then all destinations have been walked
				var index:int = -1;
				
				for each(var instance:Boolean in destinationBooleans){
					//destination is not yet walked
					if(instance){
						// replace destination x/y with new destination
						destination.x = destinationTriggers[destinationBooleans.indexOf(instance)].x;
						destination.y = destinationTriggers[destinationBooleans.indexOf(instance)].y;
						// destination is not yet reached, change default flag
						index = destinationBooleans.indexOf(instance);
					}
				}
				
				//if still default flag, all destinations have been walked, stop the function
				if(index == -1) return;
				
				//fill local destination value x/y
				var distanceX:Number = doctorInstance.x - destination.x;
				
				var distanceY:Number = doctorInstance.y - destination.y;
				
				// calculate rotation based on the geometry of player, destination, x and y
				var rotation:Number = Math.atan2(doctorInstance.y - destination.y,doctorInstance.x - destination.x) / Math.PI * 180;

				// calculate distance based on destination and doctor difference x and y
				var distance:Number = Math.sqrt((distanceX*distanceX)+(distanceY*distanceY));
				
				//set the speed inwhich the doctor should walk
				var playerSpeed:Number = 10;
				
				// if distance is smaller then the doctor speed 
				if(distance < playerSpeed){
					//teleport to destination
					doctorInstance.x = destination.x;
					doctorInstance.y = destination.y;
					//tell the array destination is reached
					destinationBooleans[index] = false;
					// tell the array that a new destination exists
					if(destinationBooleans.length > index + 1){
						//tell the array that a new destination should be reached next time
						destinationBooleans[index + 1] = true;
					}
					else{
						trace('[MOVEMENT] length of destination: ' + destinationBooleans.length);
						trace('[MOVEMENT] OUTOFBOUNDS');
					}
				}
				//if the doctor is east of the destination go west
				else if(doctorInstance.x <= destination.x){
					trace('go right');
					
					if(destination.y == doctorInstance.y){
						if(check(destination.x - 5, doctorInstance.x , destination.x + 5)){
							doctorInstance.x = destination.x;	
						}
						else if(doctorInstance.x <= destination.x){
							doctorInstance.x = doctorInstance.x + playerSpeed;
						}
						else{
							doctorInstance.x = doctorInstance.x - playerSpeed;
						}
					}
					
					if(check(destination.y - 5, doctorInstance.y , destination.y + 5)){
						doctorInstance.y = destination.y;	
					}
					else if(doctorInstance.y <= destination.y){
						doctorInstance.y = doctorInstance.y + playerSpeed;
					}
					else{
						doctorInstance.y = doctorInstance.y - playerSpeed;
					}
					
				}
				//if the doctor is west of the destination go east
				else{
					trace('go left');
					if(destination.y == doctorInstance.y){
						if(check(destination.x - 5, doctorInstance.x , destination.x + 5)){
							doctorInstance.x = destination.x;	
						}
						else if(doctorInstance.x <= destination.x){
							doctorInstance.x = doctorInstance.x + playerSpeed;
						}
						else{
							doctorInstance.x = doctorInstance.x - playerSpeed;
						}
					}					
					if(check(destination.y - 5, doctorInstance.y , destination.y + 5)){
						doctorInstance.y = destination.y;	
					}
					else if(doctorInstance.y <= destination.y){
						doctorInstance.y = doctorInstance.y + playerSpeed;
					}
					else{
						doctorInstance.y = doctorInstance.y - playerSpeed;
					}
				}
		}
		
		/**
		 * meathod to return boolean when between
		 */
		private function check(min:Number , value:Number , max:Number):Boolean{
			return min > value ? false : ( max < value ? false : true );
		}
		
		private function chooseDestination():void{
			
		}
	}
}