package entities {
	import com.greensock.TweenLite;
	import entities.core.CoreObject;
	import flash.utils.getTimer;
	import config.Settings;
	import utils.UtilsMath;
	
	public class Bullet extends CoreObject {
		
		private var birthTime:Number;
		private var endTween:TweenLite;
		
		public function Bullet(data:Object) {
			super(data);
			
			addChild(new BulletGfx());
		}
		
		override public function reset(data:Object = null):void {
			super.reset(data);
			
			alpha = 1;
			birthTime = getTimer();
			UtilsMath.angularStep(velocity, 0, 0, Settings.BULLET_SPEED, rotation);
		}
		
		override public function update():void {
			if (!endTween) {
				handleLifeTime();
			}
			
			super.update();
		}
		
		override public function destroy():void {
			endTween = null;
			super.destroy();
		}
		
		private function handleLifeTime():void {
			var currentTime:Number = getTimer();
			if (currentTime - birthTime > Settings.BULLET_LIFE_TIME) {
				endTween = TweenLite.to(this, .3, {alpha: 0, onComplete: destroy});
			}
		}
	
	}

}