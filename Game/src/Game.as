package
{
	import events.EventDispatchHandler;
	import events.EventHandler;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import utils.ApplicationUtils;
	
	import view.mediators.BangParticleMediator;
	import view.mediators.BulletMediator;
	
	[SWF(width=1000, height=700, frameRate=36 )]
	
	public class Game extends Sprite
	{
		
		private var layer:MovieClip;
		
		private const app_width:int = 1000;
		
		private const app_height :int = 700;
		
		public static const CONNECTION_URL  :String = "http://www.tanya.x25.org/neva_soft/";
		
		public function Game()
		{
			if ( stage ) 
			{
				init();
			}
			else 
			{
				addEventListener(Event.ADDED_TO_STAGE, init);		
			}
		}
		
		
		private function init( _event :Event = null ) : void
		{
			this.initLayer();
			
			this.initMediators();
			
			this.stage.addEventListener(MouseEvent.CLICK, this.onMouseClick);
		}
		
		
		private function initLayer() :void
		{
			this.layer = new MovieClip();
			this.layer.addChild( ApplicationUtils.createBackground( 0x1b7ff0, 1, 0,0, this.app_width, this.app_height ));
			this.addChild( this.layer );
		}
		
		
		private function initMediators() : void
		{
			new BulletMediator( this.layer);
			new BangParticleMediator( this.layer );
		}
		
		
		private function onMouseClick( event:MouseEvent ) : void
		{
			EventDispatchHandler.instance.dispatchEvent( new EventHandler(EventHandler.MOUSE_CLICK));
		}
	}
}