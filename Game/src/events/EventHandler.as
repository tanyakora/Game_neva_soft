package events
{
	import flash.events.Event;

	/*
	событие для взаимодействия со связями
	*/
	public class EventHandler extends Event
	{
		
		public static const	MOUSE_CLICK		:String = 'mouse_click';
		
		public static const	BULLET_BANG_START		:String = 'bullet_bang_start';
		
		public static const	PARTICLE_BANG_START		:String = 'particle_bang_start';
		
		//данные для передачи
		private var _data					: Object;	
		public function get data() : Object{ return this._data;}
		
		
		public function EventHandler(_type:String, __data : Object = null)
		{
			
			super(_type);
			
			this._data = __data;
		}
		
		override public function clone() :Event{
			
			return new EventHandler(this.type, this._data);
		}
		
	}
}