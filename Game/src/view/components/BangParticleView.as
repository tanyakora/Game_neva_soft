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
		
		private var radius_start:int;
		
		private var angle:Number;
		
		public function BangParticleView( _bitmap:Bitmap, _x:int, _y:int, _radius:int, _dispatch_event:Boolean )
		{
			this.dispatch_event = _dispatch_event;
			
			this.radius_start =  ApplicationUtils.setRandom( 100 ) + _radius;
			
			this.angle = ApplicationUtils.setRandom( 360 );
			
			this.particle = _bitmap;
			this.particle.scaleX = this.particle.scaleY =   ApplicationUtils.setRandom(100)/1000+0.01;
			
			this.x = _x;
			this.y = _y;
			this.addChild(this.particle );
			
			var end_y : Number = this.radius_start *Math.sin(this.angle);
			var end_x : Number = this.radius_start *Math.cos(this.angle);
			
			Tweener.addTween( this.particle, { y :end_y, x:end_x, time : 1, alpha:0, transition : 'easeoutcubic', onComplete: onTweenStop });
		}
		
		private function onTweenStop():void
		{
			Tweener.removeTweens( this.particle );
			
			if( this.dispatch_event && ApplicationUtils.setRandom(100)%5 == 0 )
			{
				EventDispatchHandler.instance.dispatchEvent( new EventHandler(EventHandler.PARTICLE_BANG_START, {'x': x + particle.x, 'y':y + particle.y }));
			}
			this.removeChild( this.particle );
			this.parent.removeChild( this );
			this.particle= null;
		}

		
	}
}