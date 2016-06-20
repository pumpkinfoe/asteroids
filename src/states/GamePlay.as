package states {
	import com.CollisionDetection;
	import com.greensock.TweenLite;
	import entities.Asteroid;
	import entities.Bullet;
	import entities.PlayerShip;
	import entities.core.Factory;
	import events.GameEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	import interfaces.IGameObject;
	import config.Settings;
	import states.core.CoreState;
	import states.core.GameStates;
	import utils.UtilsAlign;
	import utils.UtilsMath;
	
	public class GamePlay extends CoreState {
		private var frendies:Vector.<IGameObject> = new Vector.<IGameObject>;
		private var enemies:Vector.<IGameObject> = new Vector.<IGameObject>;
		private var ship:IGameObject;
		
		private var currentTime:Number = 0;
		private var lastFired:Number = 0;
		private var currentLevel:int = 0;
		
		override protected function initState():void {
			super.initState();
			
			ship = addObject(Factory.PLAYER_SHIP, {rotation: -90, keysDown: keysDown});
			UtilsAlign.toCenter(ship.displayObject);
			
			addEventListener(GameEvent.PLAYER_DESTROYED, onPlayerDestroyed);
			addEventListener(GameEvent.ENEMY_DESTROYED, onEnemyDestroyed);
		}
		
		private function loadLevel():void {
			var numOfEnemies:int = 0;
			while (numOfEnemies < currentLevel + Settings.MIN_ASTEROID_PER_LEVEL) {
				var randomPoint:Point = new Point(Math.random() * stage.stageWidth, Math.random() * stage.stageHeight);
				var distance:Number = UtilsMath.distance2obj(ship, randomPoint);
				if (distance > Settings.SAFE_RADIUS && distance < Settings.BORING_RADIUS) {
					addObject(Factory.ASTEROID, {position: randomPoint, size: Asteroid.GIANT_SIZE}, 1);
					numOfEnemies++;
				}
			}
		}
		
		override public function update():void {
			super.update();
			
			calculateCollisions();
			controlFire();
			checkForVictory();
		}
		
		private function checkForVictory():void {
			if (enemies.length == 0) {
				currentLevel++;
				loadLevel();
			}
		}
		
		private function calculateCollisions():void {
			for each (var enemy:IGameObject in enemies) {
				for each (var friend:IGameObject in frendies) {
					if (enemy.displayObject.hitTestObject(friend.displayObject)) {
						var presiceCollision:Boolean = CollisionDetection.isColliding(enemy.displayObject, friend.displayObject, objectsCanvas, true);
						if (presiceCollision) {
							enemy.destroy();
							friend.destroy();
						}
					}
				}
			}
		}
		
		override protected function reflow():void {
			enemies = gameObjects.filter(function(obj:*, ... rest):Boolean {
				return obj is Asteroid;
			});
			frendies = gameObjects.filter(function(obj:*, ... rest):Boolean {
				return obj is Bullet || obj is PlayerShip;
			});
		}
		
		private function controlFire():void {
			if (!ship.isAlive()) {
				return;
			}
			currentTime = getTimer();
			
			if (keysDown[Keyboard.SPACE] && currentTime - lastFired > Settings.FIRING_DELAY) {
				lastFired = currentTime;
				addObject(Factory.BULLET, {position: ship.getPosition(), rotation: ship.displayObject.rotation}, 0);
			}
		}
		
		private function onPlayerDestroyed(e:GameEvent):void {
			TweenLite.delayedCall(Settings.DELAY_BEFORE_GAME_OVER, function():void {
				dispatchEvent(new GameEvent(GameEvent.CHANGE_STATE, GameStates.GAME_OVER, true))
			});
			addExplosion(ship.getPosition());
		}
		
		private function onEnemyDestroyed(e:GameEvent):void {
			var enemy:IGameObject = e.target as IGameObject;
			var position:Point = enemy.getPosition();
			if (enemy is Asteroid) {
				var size:uint = (enemy as Asteroid).getSize();
				if (size != Asteroid.SMALL_SIZE) {
					var numOfDebris:int = Settings.MAX_DEBRIS / (size - 1);
					for (var i:int = 0; i < numOfDebris; i++) {
						addObject(Factory.ASTEROID, {position: position, size: (size - 1)});
					}
				}
			}
			addExplosion(position);
		}
		
		private function addExplosion(position:Point):void {
			addObject(Factory.EXPLOSION, {position: position});
		}
		
		override public function destroy():void {
			ship = null;
			removeEventListener(GameEvent.PLAYER_DESTROYED, onPlayerDestroyed);
			removeEventListener(GameEvent.ENEMY_DESTROYED, onEnemyDestroyed);
			super.destroy();
		}
	}

}