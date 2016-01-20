package view.components
{
	import caurina.transitions.Tweener;
	
	import events.EventDispatchHandler;
	import events.EventHandler;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import utils.ApplicationUtils;

	public class BangParticleView extends MovieClip
	{
		private var particle:Bitmap;
		
		private var dispatch_event:Boolean;
		
		private var radius:int;
		
		private var radius_start:int;
		
		private var angle:Number;
		
		public function BangParticleView( _bitmap:Bitmap, _x:int, _y:int, _radius:int, _dispatch_event:Boolean )
		{
			this.dispatch_event = _dispatch_event;
			
			this.radius_start =  ApplicationUtils.setRandom( _radius ) + 50;
			this.radius = 0;
			
			this.angle = ApplicationUtils.setRandom( 360 );
			
			this.particle = _bitmap;
			this.particle.scaleX = this.particle.scaleY =  0.2;
			
			this.x = _x;
			this.y = _y;
			this.addChild(this.particle );
			
			this.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
		}
		
		private function onEnterFrame( event:Event ) : void
		{
			Tweener.removeTweens(this.particle);
			
			this.radius +=5;
			
			var end_y : Number = this.radius *Math.sin(this.angle);
			var end_x : Number = this.radius *Math.cos(this.angle);
			
			Tweener.addTween( this.particle, { y :end_y, x:end_x, time : 1, transition : 'easeoutcubic' });
			
			if( this.radius >= this.radius_start)
			{
				this.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
				this.clear();
			}
			
		}
		
		private function clear() : void
		{
			if( this.dispatch_event && ApplicationUtils.setRandom(100)%2 )
			{
				EventDispatchHandler.instance.dispatchEvent( new EventHandler(EventHandler.PARTICLE_BANG_START, {'x': x + particle.x, 'y':y + particle.y }));
			}
			this.removeChild( this.particle );
			this.parent.removeChild( this );
		}
		
	}
}