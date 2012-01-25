package com.unitedmindset.events
{
	import flash.events.Event;
	
	public class TrackingEvent extends Event
	{
		public static const PAGE:String = "page";
		public static const EVENT:String = "event";
		
		private var _category:String;
		/**
		 * A string representing groups of events or the page viewed.
		 * @return 
		 * 
		 */		
		public function get category():String { return _category; }
		
		private var _action:String;
		/**
		 * A string that is paired with each category and is typically used to track activities. 
		 * @return 
		 * 
		 */		
		public function get action():String { return _action; }
		
		private var _label:String;
		/**
		 * An optional string that provides additional scoping to the category/action pairing. 
		 * @return 
		 * 
		 */		
		public function get label():String { return _label; }
		
		private var _value:Number;
		/**
		 * An optional non-negative integer that associates numerical data with a tracking event. 
		 * @return 
		 * 
		 */		
		public function get value():Number { return _value; }
		
		public function TrackingEvent(type:String, category:String, action:String=null, label:String=null, value:Number=NaN, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_category = category;
			_action = action;
			_label = label;
			_value = value;
		}
		
		override public function clone():Event
		{
			return new TrackingEvent(type, category, action, label, value, bubbles, cancelable);
		}
	}
}