package com.unitedmindset.events
{
	import flash.events.Event;
	
	public class ModelUpdateEvent extends Event
	{
		public static const BOX_OFFICE_LOADING_CHANGED:String = "boxOfficeLoadingChanged";
		public static const BOX_OFFICE_LIST_CHANGED:String = "boxOfficeListChanged";
		public static const BOX_OFFICE_FAULT:String = "boxOfficeFault";
		
		public static const CURRENT_DVD_LOADING_CHANGED:String = "currentDvdLoadingChanged";
		public static const CURRENT_DVD_LIST_CHANGED:String = "currentDvdListChanged";
		public static const CURRENT_DVD_FAULT:String = "currentDvdFault";
		
		public static const IN_THEATER_LOADING_CHANGED:String = "inTheaterLoadingChanged";
		public static const IN_THEATER_LIST_CHANGED:String = "inTheaterListChanged";
		public static const IN_THEATER_FAULT:String = "inTheaterFault";
		
		public static const NEW_DVD_LOADING_CHANGED:String = "newDvdLoadingChanged";
		public static const NEW_DVD_LIST_CHANGED:String = "newDvdListChanged";
		public static const NEW_DVD_FAULT:String = "newDvdFault";
		
		public static const OPENING_NOW_LOADING_CHANGED:String = "openingNowLoadingChanged";
		public static const OPENING_NOW_LIST_CHANGED:String = "openingNowListChanged";
		public static const OPENING_NOW_FAULT:String = "openingNowFault";
		
		public static const TOP_RENTALS_LOADING_CHANGED:String = "topRentalsLoadingChanged";
		public static const TOP_RENTALS_LIST_CHANGED:String = "topRentalsListChanged";
		public static const TOP_RENTALS_FAULT:String = "topRentalsFault";
		
		public static const UPCOMING_DVD_LOADING_CHANGED:String = "upcomingDvdLoadingChanged";
		public static const UPCOMING_DVD_LIST_CHANGED:String = "upcomingDvdListChanged";
		public static const UPCOMING_DVD_FAULT:String = "upcomingDvdFault";
		
		public static const UPCOMING_THEATER_LOADING_CHANGED:String = "upcomingTheaterLoadingChanged";
		public static const UPCOMING_THEATER_LIST_CHANGED:String = "upcomingTheaterListChanged";
		public static const UPCOMING_THEATER_FAULT:String = "upcomingTheaterFault";
		
		public static const SEARCH_LOADING_CHANGED:String = "searchLoadingChanged";
		public static const SEARCH_LIST_CHANGED:String = "searchListChanged";
		public static const SEARCH_FAULT:String = "searchFault";
		
		public static const REVIEWS_LOADING_CHANGED:String = "reviewsLoadingChanged";
		public static const REVIEWS_LIST_CHANGED:String = "reviewsListChanged";
		public static const REVIEWS_FAULT:String = "reviewsFault";
		
		private var _value:Object;
		public function get value():Object { return _value; }
		
		public function ModelUpdateEvent(type:String, value:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_value = value;
		}
		
		override public function clone():Event
		{
			return new ModelUpdateEvent(type, value, bubbles, cancelable);
		}
	}
}