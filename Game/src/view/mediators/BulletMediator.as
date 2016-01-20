package view.mediators
{
	import events.EventDispatchHandler;
	import events.EventHandler;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.utils.ByteArray;
	
	import utils.ApplicationUtils;
	import utils.ImageLoader;
	
	import view.components.BulletView;

	public class BulletMediator
	{
		
		private var container:MovieClip;
		
		private var bullet_loader:ImageLoader;
		
		private var  bang_loader:ImageLoader;
		
		private var app_width:int;
		
		private var app_height:int;

		public function BulletMediator( _container :MovieClip ) 
		{
			this.container = _container;
			
			this.app_width = this.container.width;
			this.app_height = this.container.height;
			
			this.bullet_loader = new ImageLoader( Game.CONNECTION_URL+'bullet.png', function( _loader:Loader ) : void {});
			this.bullet_loader.load();
			
			this.bang_loader = new ImageLoader( Game.CONNECTION_URL+'bang_1_icon.png', function( _loader:Loader ) : void 
			{	
				EventDispatchHandler.instance.addEventListener(EventHandler.MOUSE_CLICK, onBulletStart );
			});
			this.bang_loader.load();
		}
		
		private function onBulletStart( event:EventHandler ) : void
		{
			var _bullet_view:BulletView = new BulletView( ApplicationUtils.getCopyBitmap(this.bullet_loader.loader), ApplicationUtils.getCopyBitmap(this.bang_loader.loader), this.app_width, this.app_height);
			this.container.addChild( _bullet_view);
		}
		
		
		
	}
}