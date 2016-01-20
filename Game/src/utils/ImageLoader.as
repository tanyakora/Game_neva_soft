package utils
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.system.SecurityDomain;

	public class ImageLoader
	{
		private var _loader    :Loader;
		private var _request   :URLRequest;
		private var _callBack  : Function;
		private var _cnt:LoaderContext;
		
		public function get loader():Loader
		{
			return this._loader;
		}

		public function ImageLoader( url: String, callBack: Function )
		{
			Security.allowDomain('*');
			
			_callBack  = callBack;
			
			_loader    = new Loader();
			_request = new URLRequest(url);
			
			_cnt = new LoaderContext(true);
			_cnt.checkPolicyFile = true;
			
			//******************************************************88
			//_cnt.securityDomain = SecurityDomain.currentDomain;
			//********************************************************888
			_cnt.applicationDomain = ApplicationDomain.currentDomain;
			
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,                    onComplite);
			_loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,             onError);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.NETWORK_ERROR,        onError);
		}
		
		
		public function load() :void
		{
		  	_loader.load(_request, _cnt);
		}
		
		private function onComplite(event:Event):void
		{
		  _callBack(_loader);
		}
		

		private function onError(event:Event):void
		{
			trace('image error  ' + event )
		}
	 }
}