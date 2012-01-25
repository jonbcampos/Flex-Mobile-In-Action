package com.unitedmindset.events
{
	import flash.events.Event;
	
	public class RequestDataEvent extends Event
	{
		public static const BOX_OFFICE_LIST:String = "boxOfficeList";
		public static const CURRENT_DVD_LIST:String = "currentDvdList";
		public static const IN_THEATERS_LIST:String = "inTheatersList";
		public static const NEW_DVD_LIST:String = "newDvdList";
		public static const OPENING_NOW_LIST:String = "openingNowList";
		public static const TOP_RENTALS_LIST:String = "topRentalsList";
		public static const UPCOMING_DVD_LIST:String = "upcomingDvdList";
		public static const UPCOMING_THEATER_LIST:String = "upcomingTheaterList";
		public static const SEARCH_LIST:String = "searchList";
		public static const REVIEWS_LIST:String = "reviewsList";
		
		private var _page:int;
		public function get page():int { return _page; }
		
		private var _numOfResults:int;
		public function get numOfResults():int { return _numOfResults; }
		
		private var _term:String;
		public function get term():String { return _term; }
		
		public function RequestDataEvent(type:String, page:int, numOfResults:int, term:String=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_page = page;
			_numOfResults = numOfResults;
			_term = term;
		}
		
		override public function clone():Event
		{
			return new RequestDataEvent(type, page, numOfResults, term, bubbles, cancelable);
		}
	}
}