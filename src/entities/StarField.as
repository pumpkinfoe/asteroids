package entities {
	import com.BitmapScroller;
	import entities.core.CoreObject;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import config.Settings;
	
	public class StarField extends CoreObject {
		private var fieldWidth:int;
		private var fieldHeight:int;
		
		private var background:BitmapData;
		private var foreground:BitmapData;
		
		public function StarField(data:Object):void {
			if (data) {
				fieldWidth = data.width;
				fieldHeight = data.height;
			}
			
			createStars(Settings.BACKGROUND_DENSITY);
		}
		
		private function createStars(numberOfStars:int):void {
			background = new BitmapData(fieldWidth, fieldHeight, true, 0);
			foreground = new BitmapData(fieldWidth, fieldHeight, true, 0);
			addChild(new Bitmap(background));
			addChild(new Bitmap(foreground));
			
			var matrix:Matrix = new Matrix();
			var brush:MovieClip = new StarSmall();
			
			for (var j:int = 0; j < numberOfStars; j++) {
				matrix.tx = Math.random() * fieldWidth;
				matrix.ty = Math.random() * fieldHeight;
				background.draw(brush, matrix);
				matrix.tx = Math.random() * fieldWidth;
				matrix.ty = Math.random() * fieldHeight;
				foreground.draw(brush, matrix);
			}
		}
		
		override public function update():void {
			if (wrappable) {
				BitmapScroller.scroll(background, 1, -1);
				BitmapScroller.scroll(foreground, 1, 0);
			}
		}
	}

}