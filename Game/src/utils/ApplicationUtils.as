package utils
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	


	public class ApplicationUtils
	{
	
		public static function createBackground( _color :int, _alpha : Number, _x : int, _y : int, _width: int, _height :int) :Sprite
		{
			var back :Sprite = new Sprite();
			back.graphics.beginFill( _color, _alpha);
			back.graphics.drawRect( _x, _y, _width, _height);
			back.graphics.endFill();	
			
			return back;
		}
		
		
		
		public static function getCopyBitmap( _loader:Loader ) : Bitmap
		{
			var image:Bitmap = Bitmap( _loader.content );
			return new Bitmap(image.bitmapData.clone());
		}
		
		/**
		 * вспомогательная ф-ция для случайного числа
		 */
		public static function setRandom( _count : int ) : int 
		{
			var number	: int = int( Math.random() * ( _count));
			return number;
		}
		
	}
}