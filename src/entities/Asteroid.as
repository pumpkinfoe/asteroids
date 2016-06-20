package entities {
	import entities.core.CoreObject;
	import events.GameEvent;
	import utils.UtilsMath;
	
	public class Asteroid extends CoreObject {
		public static const GIANT_SIZE:int = 3;
		public static const MIDDLE_SIZE:int = 2;
		public static const SMALL_SIZE:int = 1;
		private var direction:int;
		private var rotationSpeed:Number = .5;
		private var size:uint;
		
		public function Asteroid(data:Object = null) {
			super(data);
		}
		
		override public function reset(data:Object = null):void {
			super.reset(data);
			
			while (numChildren) {
				removeChildAt(0);
			}
			
			size = data.size;
			rotationSpeed = 1.5 / size;
			
			switch (size) {
			case SMALL_SIZE: 
				addChild(new SmallRoid());
				break;
			case MIDDLE_SIZE: 
				addChild(new MiddleRoid());
				break;
			case GIANT_SIZE: 
			default: 
				addChild(new GiantRoid());
				break;
			}
			
			UtilsMath.angularStep(velocity, 0, 0, 4 / size, Math.random() * 360);
			direction = (Math.random() > .5) ? 1 : -1;
		}
		
		override public function update():void {
			super.update();
			
			rotation += rotationSpeed * direction;
		}
		
		public function getSize():int {
			return size;
		}
		
		override public function destroy():void {
			dispatchEvent(new GameEvent(GameEvent.ENEMY_DESTROYED, null, true));
			super.destroy();
		}
		
	}

}