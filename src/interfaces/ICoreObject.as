package interfaces {
	import flash.display.DisplayObject;
	
	public interface ICoreObject {
		function update():void;
		function destroy():void;
		function get displayObject():DisplayObject;
	}

}