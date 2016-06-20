package utils{
	
	public class UtilsMath {
		
		public static function deg2rad(angle:Number):Number {
			return angle * (Math.PI / 180);
		}
		
		public static function rad2deg(rads:Number):Number {
			return rads / (Math.PI / 180);
		}
		
		public static function distance2p(x1:Number, x2:Number, y1:Number, y2:Number):Number {
			return Math.sqrt(Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2));
		}
		
		public static function distance2obj(first:Object, second:Object):Number {
			return UtilsMath.distance2p(first.x, second.x, first.y, second.y);
		}
		
		public static function angularStep(target:Object, xCenter:Number, yCenter:Number, radius:Number, angle:Number):void {
			var radian:Number = UtilsMath.deg2rad(angle);
			target.x = xCenter + radius * Math.cos(radian);
			target.y = yCenter + radius * Math.sin(radian);
		}
		
		public static function faceObject(target:Object, angle:Object):Number {
			var radAngle:Number = Math.atan2(target.y - angle.y, target.x - angle.x);
			return UtilsMath.rad2deg(radAngle);
		}
	
	}

}