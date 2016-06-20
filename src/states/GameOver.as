package states {
	import config.Labels;
	import entities.core.Factory;
	import events.GameEvent;
	import flash.geom.Point;
	import flash.text.TextFormatAlign;
	import flash.ui.Keyboard;
	import interfaces.IGameObject;
	import interfaces.IGameState;
	import config.Settings;
	import states.core.CoreState;
	import states.core.GameStates;
	import utils.UtilsAlign;
	
	public class GameOver extends CoreState implements IGameState {
		
		override protected function initState():void {
			super.initState();
			
			addObject(Factory.HUD_TEXT, {label:Labels.GAME_OVER, align:UtilsAlign.toCenter}, 0, HUDCanvas);
		}
		
		override public function update():void {
			super.update();
			
			if (keysDown[Keyboard.SPACE]) {
				dispatchEvent(new GameEvent(GameEvent.CHANGE_STATE, GameStates.GAMEPLAY, true));
			}
		}
		
		override public function registerBackground(bg:IGameObject, scroll:Boolean = true):void {
			super.registerBackground(bg, false);
		}
	}

}