package interfaces {
	import flash.geom.Point;
	
	public interface IGameObject extends ICoreObject{
		function toggleWrapping(value:Boolean):void;
		function getPosition():Point;
		function isAlive():Boolean;
		function reset(data:Object = null):void;
	}

}