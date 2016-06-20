package entities {
	import entities.core.CoreObject;
	
	public class Particle extends CoreObject {
		private var fadeSpeed:Number;
		
		public function Particle(data:Object) {
			super(data);
			
			addChild(new ParticleGfx());
			wrappable = false;
		}
		
		override public function reset(data:Object = null):void {
			super.reset(data);
			
			rotation = Math.random() * 360;
			alpha = Math.random() * .5 + .5;
			var maxSpeed:Number = data.maxSpeed;
			
			velocity.x = Math.random() * maxSpeed - Math.random() * maxSpeed;
			velocity.y = Math.random() * maxSpeed - Math.random() * maxSpeed;
			velocity.x *= maxSpeed;
			velocity.y *= maxSpeed;
			
			fadeSpeed = Math.random() * data.fadeSpeed;
			fadeSpeed = Math.max(fadeSpeed, 0.02);
		}
		
		override public function update():void {
			super.update();
			
			alpha -= fadeSpeed;
			if (alpha <= 0) {
				destroy();
			}
		}
	
	}

}