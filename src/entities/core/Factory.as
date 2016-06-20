package entities.core {
	import entities.*;
	import events.GameEvent;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.utils.getDefinitionByName;
	import interfaces.IGameObject;
	
	public class Factory extends Sprite {
		
		StarField;
		HUDElement;
		Particle;
		Explosion;
		PlayerShip;
		Asteroid;
		
		public static const ASTEROID:String = "Asteroid";
		public static const BULLET:String = "Bullet";
		public static const PLAYER_SHIP:String = "PlayerShip";
		public static const PARTICLE:String = "Particle";
		public static const STAR_FIELD:String = "StarField";
		public static const EXPLOSION:String = "Explosion";
		public static const HUD_TEXT:String = "HUDElement";
		private static const pathToEntities:String = "entities.";
		private static var instance:Factory;
		
		private var pool:Vector.<IGameObject> = new Vector.<IGameObject>;
		
		public function Factory() {
			if (instance) throw Error("Factory cannot be created more than once, don't do this, please");
			else {
				instance = this;
			}
		}
		
		public static function getInstance():Factory {
			if (!instance) {
				instance = new Factory();
			}
			return instance;
		}
		
		public function createEntity(type:String, data:Object):IGameObject {
			try {
				var className:Class = getDefinitionByName(pathToEntities + type) as Class;
			} catch (e:Error) {
				throw Error(type + " does'nt exist!");
			}
			for each (var object:IGameObject in pool) {
				if (object is className && !object.isAlive()) {
					object.reset(data);
					return object;
				}
			}
			object = new className(data);
			pool.push(object);
			dispatchEvent(new GameEvent(GameEvent.POOL_UPDATE, pool.length, true));
			return object;
		}
		
		public function getPoolSize():int {
			return pool.length;
		}
	}

}