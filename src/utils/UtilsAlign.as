package utils {
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class UtilsAlign {
		public static function toCenter(obj:DisplayObject):void {
			obj.x = obj.stage.stageWidth / 2 - obj.width / 2;
			obj.y = obj.stage.stageHeight / 2 - obj.height / 2;
			if (!getAnchorPoint(obj).equals(new Point(0,0))) {
				var bounds:Rectangle = obj.getBounds(obj);
				obj.x += bounds.width / 2;
				obj.y += bounds.height / 2;
			}
		}
		
		public static function toTopLeft(obj:DisplayObject):void {
			obj.x = obj.stage.x;
			obj.y = obj.stage.y;
		}
		
		public static function toLeft(obj:DisplayObject):void {
			obj.x = obj.stage.x;
		}
		
		public static function toRight(obj:DisplayObject):void {
			obj.x = obj.stage.stageWidth - obj.width;
		}
		
		public static function toTopCenter(obj:DisplayObject):void {
			obj.x = obj.stage.stageWidth / 2 - obj.width / 2;
			obj.y = obj.stage.y;
		}
		
		public static function toTopRight(obj:DisplayObject):void {
			obj.x = obj.stage.stageWidth - obj.width;
			obj.y = obj.stage.y;
		}
		
		public static function toBottomRight(obj:DisplayObject):void {
			obj.x = obj.stage.stageWidth - obj.width;
			obj.y = obj.stage.stageHeight - obj.height;
		}
		
		public static function toBottomCenter(obj:DisplayObject):void {
			obj.x = obj.stage.stageWidth / 2 - obj.width / 2;
			obj.y = obj.stage.stageHeight - obj.height;
		}
		
		public static function toBottomLeft(obj:DisplayObject):void {
			obj.x = obj.stage.x;
			obj.y = obj.stage.stageHeight - obj.height;
		}
		
		public static function getAnchorPoint(o:DisplayObject):Point {
			var res:Point = new Point();
			var rect:Rectangle = o.getRect(o);
			res.x = -1 * rect.x;
			res.y = -1 * rect.y;
			return res;
		}
	}

}