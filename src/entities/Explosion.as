package entities {
	import entities.Particle;
	import entities.core.CoreObject;
	import entities.core.Factory;
	import events.GameEvent;
	import flash.display.Sprite;
	import flash.geom.Point;
	import interfaces.IGameObject;
	import config.Settings;
	
	public class Explosion extends CoreObject {
		private var particles:Vector.<IGameObject> = new Vector.<IGameObject>;
		private var maxSpeed:Number = 1;
		private var fadeSpeed:Number = .12;
		
		public function Explosion(data:Object = null) {
			super(data);
		}
		
		override public function reset(data:Object = null):void {
			super.reset(data);
			
			while (numChildren) {
				removeChildAt(0);
			}
			
			create();
			addEventListener(GameEvent.DELETE_ENTITY, onDeleteParticle);
		}
		
		private function create():void {
			var factory:Factory = Factory.getInstance();
			for (var i:Number = 0; i < Settings.EXPLOSION_INTENSITY; i++) {
				var particle:IGameObject = factory.createEntity(Factory.PARTICLE, { maxSpeed: maxSpeed, fadeSpeed: fadeSpeed});
				particles.push(particle);
				addChild(particle as Sprite);
			}
		}
		
		private function onDeleteParticle(e:GameEvent):void 
		{
			if (e.target is Particle) {
				var particle:Particle = e.target as Particle;
				var index:int = particles.indexOf(particle);
				particles.splice(index, 1);
				removeChild(particle);
			}
		}
		
		override public function update():void {
			for each (var particle:IGameObject in particles) {
				particle.update();
			}
			if (particles.length == 0) {
				destroy();
			}
		}
		
		override public function destroy():void {
			super.destroy();
			removeEventListener(GameEvent.DELETE_ENTITY, onDeleteParticle);
		}
	}

}