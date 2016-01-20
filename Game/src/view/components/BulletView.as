package view.components
{
	import caurina.transitions.Tweener;
	
	import events.EventDispatchHandler;
	import events.EventHandler;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import utils.ApplicationUtils;
	import utils.ImageLoader;

	public class BulletView extends MovieClip
	{
		private var start_bitmap:Bitmap;
		
		private var end_bitmap:Bitmap;
		
		private var timer_end_loader:Timer;
		
		public function BulletView( _start_bitmap :Bitmap, _end_bitmap : Bitmap, _width:int, _height:int)
		{
			this.start_bitmap = _start_bitmap;
			this.start_bitmap.x = ApplicationUtils.setRandom( _width*3/4) + _width/4;
			this.start_bitmap.y = _height - this.start_bitmap.height; 
			this.addChild( this.start_bitmap );
			
			this.end_bitmap = _end_bitmap; 
			this.end_bitmap.scaleX = this.end_bitmap.scaleY =  0.2;
			
			Tweener.addTween( this.start_bitmap, { y : ApplicationUtils.setRandom(_height/2) + 100, time : 0.3, transition : 'easeoutcubic', onComplete: changeLoader});
		}
		
		private function changeLoader() : void
		{
			this.removeChild( this.start_bitmap );
			
			this.end_bitmap.x = this.start_bitmap.x+this.start_bitmap.width/2 - this.end_bitmap.width/2;
			this.end_bitmap.y = this.start_bitmap.y- this.end_bitmap.height/2;
			this.addChild( this.end_bitmap );

			this.timer_end_loader = new Timer(100, 1);
			this.timer_end_loader.addEventListener(TimerEvent.TIMER, this.clear);
			this.timer_end_loader.start();
		}
		
		private function clear( event:TimerEvent ) : void
		{
			EventDispatchHandler.instance.dispatchEvent( new EventHandler(EventHandler.BULLET_BANG_START, {'x': this.start_bitmap.x + this.start_bitmap.width/2, 'y':this.start_bitmap.y }));
			
			this.timer_end_loader.removeEventListener(TimerEvent.TIMER, this.clear);
			this.timer_end_loader.stop();
			this.timer_end_loader = null;
			
			this.removeChild( this.end_bitmap );
			
			this.start_bitmap = null;
			this.end_bitmap = null;
			
			this.parent.removeChild( this );
		}
			
	}
}