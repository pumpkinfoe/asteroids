package states.core {
	import config.Labels;
	import entities.core.Factory;
	import events.GameEvent;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import interfaces.IGameObject;
	import interfaces.IGameState;
	import config.Settings;
	import utils.UtilsAlign;
	
	public class CoreState extends Sprite implements IGameState {
		protected var backgroundCanvas:Sprite = new Sprite();
		protected var gameObjects:Vector.<IGameObject> = new Vector.<IGameObject>;
		protected var HUDCanvas:Sprite = new Sprite();
		protected var keysDown:Object = new Object();
		protected var objectsCanvas:Sprite = new Sprite();
		protected var factory:Factory = Factory.getInstance();
		
		public function CoreState() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			addChild(factory);
			addChild(backgroundCanvas);
			addChild(objectsCanvas);
			addChild(HUDCanvas);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeysUpdate);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeysUpdate);
			addEventListener(GameEvent.DELETE_ENTITY, deleteObject);
			
			initState();
		}
		
		protected function initState():void {
			addObject(Factory.HUD_TEXT, {label: Labels.OBJECTS, value: gameObjects.length, event:GameEvent.GAME_OBJECTS_UPDATE, align:UtilsAlign.toTopLeft}, 0, HUDCanvas);
			addObject(Factory.HUD_TEXT, {label: Labels.POOL, position: Labels.LOG_POOL_POS, value: factory.getPoolSize(), event:GameEvent.POOL_UPDATE, align:UtilsAlign.toLeft}, 0, HUDCanvas);
		}
		
		public function registerBackground(bg:IGameObject, scroll:Boolean = true):void {
			backgroundCanvas.addChild(bg.displayObject);
			bg.toggleWrapping(scroll);
			gameObjects.push(bg);
		}
		
		private function onKeysUpdate(e:KeyboardEvent):void {
			keysDown[e.keyCode] = e.type == KeyboardEvent.KEY_DOWN;
		}
		
		protected function deleteObject(e:Event):void {
			var gameObject:IGameObject = e.target as IGameObject;
			var index:int = gameObjects.indexOf(gameObject);
			if (index != -1) {
				gameObjects.splice(index, 1);
				dispatchEvent(new GameEvent(GameEvent.GAME_OBJECTS_UPDATE, gameObjects.length, true));
				gameObject.displayObject.parent.removeChild(gameObject.displayObject);
				reflow();
			}
		}
		
		protected function addObject(type:String, data:Object = null, index:int = -1, layer:Sprite = null):IGameObject {
			var object:IGameObject = factory.createEntity(type, data);
			var layer:Sprite = (layer) ? layer : objectsCanvas;
			if (index == -1) {
				index = layer.numChildren;
			}
			layer.addChildAt(object.displayObject, index);
			gameObjects.push(object);
			dispatchEvent(new GameEvent(GameEvent.GAME_OBJECTS_UPDATE, gameObjects.length, true));
			reflow();
			return object;
		}
		
		protected function reflow():void {	
		}
		
		public function update():void {
			for each (var gameObject:IGameObject in gameObjects) {
				gameObject.update();
			}
		}
		
		public function get displayObject():DisplayObject {
			return this;
		}
		
		public function destroy():void {
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeysUpdate);
			stage.removeEventListener(KeyboardEvent.KEY_UP, onKeysUpdate);
			removeEventListener(GameEvent.DELETE_ENTITY, deleteObject);
			for each (var object:IGameObject in gameObjects) {
				object.destroy();
			}
			keysDown = null;
		}
	
	}

}