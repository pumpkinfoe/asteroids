package entities.core {
	import events.GameEvent;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import interfaces.IGameObject;
	import utils.UtilsMovement;
	
	public class CoreObject extends Sprite implements IGameObject {
		
		protected var velocity:Point = new Point(0, 0);
		protected var wrappable:Boolean = true;
		protected var alive:Boolean;
		
		public function CoreObject(data:Object = null) {
			reset(data);
		}
		
		public function update():void {
			x += velocity.x;
			y += velocity.y;
			
			if (wrappable) {
				UtilsMovement.wrapAround(this);
			}
		}
		
		public function toggleWrapping(value:Boolean):void {
			wrappable = value;
		}
		
		public function destroy():void {
			alive = false;
			dispatchEvent(new GameEvent(GameEvent.DELETE_ENTITY, null, true));
		}
		
		protected function setPosition(position:Point):void {
			if (!position) {
				position = new Point(0, 0);
			}
			this.x = position.x;
			this.y = position.y;
		}
		
		public function getPosition():Point {
			return new Point(x, y);
		}
		
		public function isAlive():Boolean {
			return alive;
		}
		
		public function reset(data:Object = null):void {
			if (data) {
				setPosition(data.position);
				if (data.rotation != null) {
					rotation = data.rotation;
				}
			}
			velocity = new Point(0, 0);
			alive = true;
		}
		
		public function get displayObject():DisplayObject {
			return this;
		}
	
	}

}