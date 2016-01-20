package events
{
	import flash.events.EventDispatcher;

	public class EventDispatchHandler extends EventDispatcher
	{
		
		private static var _instance	: EventDispatchHandler;
		
		public var data	: Object;
		
		public static function get instance() :EventDispatchHandler{
			if(!_instance) _instance = new EventDispatchHandler();
			return _instance;
		}
		
	}
}