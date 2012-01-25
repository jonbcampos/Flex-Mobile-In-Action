package com.unitedmindset.events
{
	import flash.events.Event;
	
	public class ServiceResponseEvent extends Event
	{
		public static const BOX_OFFICE_RESULT:String = "boxOfficeResult";
		public static const CURRENT_DVD_RESULT:String = "currentDvdResult";
		public static const IN_THEATERS_RESULT:String = "inTheatersResult";
		public static const NEW_DVD_RESULT:String = "newDvdResult";
		public static const OPENING_NOW_RESULT:String = "openingNowResult";
		public static const TOP_RENTALS_RESULT:String = "topRentalsResult";
		public static const UPCOMING_DVD_RESULT:String = "upcomingDvdResult";
		public static const UPCOMING_THEATER_RESULT:String = "upcomingTheaterResult";
		
		public static const SEARCH_RESULT:String = "searchResult";
		public static const REVIEWS_RESULT:String = "reviewsResult";
		
		private var _payload:Object;
		public function get payload():Object { return _payload; }
		
		public function ServiceResponseEvent(type:String, payload:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_payload = payload;
		}
		
		override public function clone():Event
		{
			return new ServiceResponseEvent(type, payload, bubbles, cancelable);
		}
	}
}