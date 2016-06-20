package entities {
	import entities.core.CoreObject;
	import events.GameEvent;
	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	import utils.UtilsMath;
	
	public class PlayerShip extends CoreObject {
		
		private var acceleration:Number = .5;
		private var friction:Number = .95;
		private var rotateSpeed:Number = 5;
		private var key:Object;
		private var thrust:MovieClip;
		private var keysDown:Object;
		
		public function PlayerShip(data:Object = null) {
			super(data);
			
			thrust = addChild(new PlayerShipGfx()) as MovieClip;
		}
		
		override public function reset(data:Object = null):void {
			super.reset(data); 
			if (data) {
				keysDown = data.keysDown;
			}
		}
		
		override public function update():void {
			handleTrustAnimation();
			handleControls();

			velocity.x *= friction;
			velocity.y *= friction;
			
			super.update();
		}
		
		private function handleControls():void 
		{
			if (keysDown[Keyboard.UP]) {
				var angle:Number = UtilsMath.deg2rad(rotation);
				velocity.x += Math.cos(angle) * acceleration;
				velocity.y += Math.sin(angle) * acceleration;
			}
			if (keysDown[Keyboard.RIGHT]) {
				rotation += rotateSpeed;
			} else if (keysDown[Keyboard.LEFT]) {
				rotation -= rotateSpeed;
			}
		}
		
		private function handleTrustAnimation():void 
		{
			if (!thrust) {
				return;
			}
			if (keysDown[Keyboard.UP] | keysDown[Keyboard.LEFT] | keysDown[Keyboard.RIGHT]) {
				thrust.play();
			} else {
				thrust.gotoAndStop(1);
			}
		}
		
		override public function destroy():void {
			dispatchEvent(new GameEvent(GameEvent.PLAYER_DESTROYED, null, true));
			
			super.destroy();
		}
	}

}