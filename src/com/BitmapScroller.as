package com {
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class BitmapScroller {
		public static function scroll(bitmapData:BitmapData, scrollX:int, scrollY:int):void {
			// wrap values
			while (scrollX > bitmapData.width) scrollX -= bitmapData.width;
			while (scrollX < -bitmapData.width) scrollX += bitmapData.width;
			while (scrollY > bitmapData.height) scrollY -= bitmapData.height;
			while (scrollY < -bitmapData.height) scrollY += bitmapData.height;
			
			// the 4 edges of the bitmap
			var xPixels:int = Math.abs(scrollX), yPixels:int = Math.abs(scrollY);
			var rectR:Rectangle = new Rectangle(bitmapData.width - xPixels, 0, xPixels, bitmapData.height);
			var rectL:Rectangle = new Rectangle(0, 0, xPixels, bitmapData.height);
			var rectT:Rectangle = new Rectangle(0, 0, bitmapData.width, yPixels);
			var rectB:Rectangle = new Rectangle(0, bitmapData.height - yPixels, bitmapData.width, yPixels);
			var pointL:Point = new Point(0, 0);
			var pointR:Point = new Point(bitmapData.width - xPixels, 0);
			var pointT:Point = new Point(0, 0);
			var pointB:Point = new Point(0, bitmapData.height - yPixels);
			
			var tmp:BitmapData = new BitmapData(bitmapData.width, bitmapData.height, bitmapData.transparent, 0x000000);
			
			// copy column, scroll, paste
			scrollX > 0 ? tmp.copyPixels(bitmapData, rectR, pointL) : tmp.copyPixels(bitmapData, rectL, pointR);
			bitmapData.scroll(scrollX, 0);
			scrollX > 0 ? bitmapData.copyPixels(tmp, rectL, pointL) : bitmapData.copyPixels(tmp, rectR, pointR);
			
			// copy row, scroll, paste
			scrollY > 0 ? tmp.copyPixels(bitmapData, rectB, pointT) : tmp.copyPixels(bitmapData, rectT, pointB);
			bitmapData.scroll(0, scrollY);
			scrollY > 0 ? bitmapData.copyPixels(tmp, rectT, pointT) : bitmapData.copyPixels(tmp, rectB, pointB);
			
			tmp.dispose();
		}
	}

}