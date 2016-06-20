package interfaces {
	import flash.display.DisplayObject;
	
	public interface IGameState extends ICoreObject{
		function registerBackground(bg:IGameObject, scroll:Boolean = false):void;
	}

}