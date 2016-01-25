package view.mediators
{
	import events.EventDispatchHandler;
	import events.EventHandler;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	
	import utils.ApplicationUtils;
	import utils.ImageLoader;
	
	import view.components.BangParticleView;

	public class BangParticleMediator
	{
		
		private var container:MovieClip;
		
		private var bang_particle_loader:ImageLoader;
		
		private const count_first_particle : int = 60;
		
		private const count_second_particle :int = 30;
		
		private const radius_first :int = 100;
		
		private const radius_second:int = 100;
		
		public function BangParticleMediator( _container:MovieClip)
		{
			this.container = _container;
			
			this.bang_particle_loader = new ImageLoader( Game.CONNECTION_URL+'bang_icon.png', function( _loader:Loader ) : void 
			{
				setListeners();
			});
			this.bang_particle_loader.load();
		}
		
		
		private function setListeners() :void
		{
			EventDispatchHandler.instance.addEventListener(EventHandler.BULLET_BANG_START, this.onBulletBangStart );
			EventDispatchHandler.instance.addEventListener(EventHandler.PARTICLE_BANG_START, this.onParticleBangStart );
		}
		
		private function onBulletBangStart( event:EventHandler ) : void
		{
			for ( var i:int =0 ;i< this.count_first_particle; i++ )
			{
				var _particle:BangParticleView = new BangParticleView( ApplicationUtils.getCopyBitmap( this.bang_particle_loader.loader), event.data.x, event.data.y, this.radius_first, true);
				this.container.addChild( _particle );
			}
		}
		
		private function onParticleBangStart( event:EventHandler ) : void
		{
			for ( var i:int =0 ;i< this.count_second_particle; i++ )
			{
				var _particle:BangParticleView = new BangParticleView( ApplicationUtils.getCopyBitmap( this.bang_particle_loader.loader), event.data.x, event.data.y, this.radius_second, false );
				this.container.addChild( _particle );
			}
		}
		
		
	}
}