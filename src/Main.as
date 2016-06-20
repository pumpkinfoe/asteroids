package {
	import com.Stats;
	import entities.core.Factory;
	import events.GameEvent;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	import interfaces.IGameObject;
	import interfaces.IGameState;
	import states.GameOver;
	import states.core.GameStates;
	import utils.UtilsAlign;
	
	/**
	 * ...
	 * @author DeVol
	 */
	
	[SWF(width="640", height="480", frameRate="30", backgroundColor="#000000")]
	
	public class Main extends Sprite {
		
		private var gameTimer:Timer;
		private var state:IGameState;
		private var background:IGameObject;
		
		public function Main() {
			init();
		}
		
		private function init():void {
			background = Factory.getInstance().createEntity(Factory.STAR_FIELD, {width: stage.stageWidth, height: stage.stageHeight});
			
			gameTimer = new Timer(1000 / stage.frameRate);
			gameTimer.addEventListener(TimerEvent.TIMER, onTimer);
			gameTimer.start();
			
			stage.addEventListener(GameEvent.CHANGE_STATE, onChangeState);
			UtilsAlign.toRight(addChild(new Stats()));
			switchState(GameStates.GAMEPLAY);
		}
		
		public function onTimer(e:TimerEvent):void {
			if (state) {
				state.update();
			}
			e.updateAfterEvent();
		}
		
		public function switchState(nextState:String):void {
			try {
				var stateClass:Class = getDefinitionByName(nextState) as Class;
			} catch (e:Error) {
				throw Error(nextState + "does'nt exist!");
			}
			if (state) {
				state.destroy();
				removeChild(state.displayObject);
			}
			state = new stateClass();
			state.registerBackground(background);
			addChildAt(state.displayObject, 0);
		}
		
		private function onChangeState(e:GameEvent):void {
			var nextState:String = e.getData();
			switchState(nextState);
		}
	
	}

}