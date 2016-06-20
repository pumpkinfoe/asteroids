package events {
	import flash.events.Event;
	
	public class GameEvent extends Event {
		public static const CHANGE_STATE:String = "change_state";
		public static const DELETE_ENTITY:String = "delete_entity";
		public static const PLAYER_DESTROYED:String = "player_destroyed";
		public static const NEW_LEVEL:String = "new_level";
		public static const GAME_OBJECTS_UPDATE:String = "game_obj_update";
		public static const POOL_UPDATE:String = "pool_update";
		public static const ENEMY_DESTROYED:String = "asteroid_destroyed";
		private var data:*;
		
		public function GameEvent(type:String, data:* = null, bubbles:Boolean = false, cancelable:Boolean = false):void {
			super(type, bubbles, cancelable);
			this.data = data;
		}
		
		public function getData():* {
			return data;
		}
		
		override public function clone():Event {
			return new GameEvent(type, data, bubbles, cancelable);
		}
		
		override public function toString():String {
			return formatToString("CustomEvent", "type", "data", "bubbles", "cancelable", "eventPhase");
		}
	}
}