package utils {
	import flash.display.DisplayObject;
	import flash.display.Stage;
	
	public class UtilsMovement {
		public static function wrapAround(target:DisplayObject, clipping:Number = 4):void {
			var stage:Stage = target.stage;
			if (!stage) {
				return;
			}
			
			var stageWidth:Number = stage.stageWidth;
			var stageHeight:Number = stage.stageHeight;
			var spriteWidth:Number = target.width / clipping;
			var spriteHeight:Number = target.height / clipping;
			if (target.x > stageWidth + spriteWidth) {
				target.x = -spriteWidth;
			} else if (target.x < -spriteWidth) {
				target.x = stageWidth + spriteWidth;
			}
			if (target.y > stageHeight + spriteHeight) {
				target.y = -spriteHeight;
			} else if (target.y < -spriteHeight) {
				target.y = stageHeight + spriteHeight;
			}
		}
	}

}