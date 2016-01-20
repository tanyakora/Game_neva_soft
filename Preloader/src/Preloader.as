package
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.SecurityDomain;
	import flash.text.TextField;
	
	[SWF(width=1000, height=700, frameRate=36 )]
	
	public class Preloader extends Sprite
	{
		
		private var text_percent	:TextField;
		
		public function Preloader()
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
			this.setTextField();			
			
			var request:URLRequest = new URLRequest("Game.swf");
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadProgress);

			var _cnt:LoaderContext = new LoaderContext(true);
			_cnt.checkPolicyFile = false;
			
			//******************************************************88
			//_cnt.securityDomain = SecurityDomain.currentDomain;
			//********************************************************888
			_cnt.applicationDomain = ApplicationDomain.currentDomain;
			
			function loadProgress(event:ProgressEvent):void 
			{
				var percentLoaded:Number = event.bytesLoaded / event.bytesTotal;
				percentLoaded = Math.round(percentLoaded * 100);
				
				text_percent.text = 'Загрузка: ' + String(uint(percentLoaded)) + "%";
			}
			
			loader.load(request,_cnt);
			this.addChild(loader);
		}
		
		
		private function setTextField() : void
		{
			this.text_percent = new TextField();
			this.text_percent.selectable = false;
			this.text_percent.x = this.width/2 - 30;
			this.text_percent.y = 410;
			this.text_percent.width = 50;
			this.addChild( this.text_percent );
		}
		
		
		
	}
}