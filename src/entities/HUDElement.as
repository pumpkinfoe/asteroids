package entities {
	import entities.core.CoreObject;
	import events.GameEvent;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import utils.UtilsAlign;
	
	public class HUDElement extends CoreObject {
		private var textField:TextField;
		private var label:String;
		private var value:String;
		private var event:String;
		private var alignFunc:Function;
		
		public function HUDElement(data:Object = null) {
			super(data);
		}
		
		private function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			if (event) {
				stage.addEventListener(event, onEvent);
			}
			updateText(value);
		}
		
		override public function reset(data:Object = null):void {
			super.reset(data);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			if (!textField) {
				textField = new TextField();
				textField.selectable = false;
				textField.autoSize = TextFieldAutoSize.LEFT;
				addChild(textField);
			}
			
			if (data) {
				label = data.label;
				value = data.value;
				event = data.event;
				alignFunc = data.align;
			}
		}
		
		private function onEvent(e:GameEvent):void {
			updateText(e.getData());
		}
		
		private function updateText(value:String = null):void {
			textField.htmlText = value ? label + '<font color="#00ff00">' + value + '</font>' : label;
			if (stage && alignFunc is Function) {
				alignFunc(this);
			}
		}
		
		override public function update():void {
		}
		
		override public function destroy():void {
			super.destroy();
			if (event) {
				stage.removeEventListener(event, onEvent);
			}
		}
	
	}

}