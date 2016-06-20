package utils{
	
	public class UtilsObject {
		
		public static function logObject(data:Object, indent:String = ""):void {
			for (var field:String in data) {
				if (typeof(data[field]) == "object") {
					trace(indent + field + ":");
					logObject(data[field], indent + "  ");
				} else {
					trace(indent + field + ": " + data[field]);
				}
			}
		}
	}

}