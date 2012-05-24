package com.unitedmindset.events
{
	import flash.events.Event;
	
	public class MoveToViewEvent extends Event
	{
		public static const PUSH_VIEW:String = "pushView";
		public static const POP_VIEW:String = "popView";
		
		private var _view:String;
		public function get view():String { return _view; }
		
		private var _data:Object;
		public function get data():Object { return _data; }
		
		private var _relatedObject:Object;
		public function get relatedObject():Object { return _relatedObject; }
		
		public function MoveToViewEvent(type:String, view:String=null, data:Object=null, relatedObject:Object = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_view = view;
			_data = data;
			_relatedObject = relatedObject;
		}
		
		override public function clone():Event
		{
			return new MoveToViewEvent(type, view, data, relatedObject, bubbles, cancelable);
		}
	}
}