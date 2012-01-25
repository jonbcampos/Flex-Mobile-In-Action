package com.unitedmindset
{
	import com.unitedmindset.controllers.boxoffice.GetBoxOfficeCommand;
	import com.unitedmindset.controllers.boxoffice.GetBoxOfficeResultCommand;
	import com.unitedmindset.controllers.currentdvd.GetCurrentDvdCommand;
	import com.unitedmindset.controllers.currentdvd.GetCurrentDvdResultCommand;
	import com.unitedmindset.controllers.intheaters.GetInTheaterResultCommand;
	import com.unitedmindset.controllers.intheaters.GetInTheatersCommand;
	import com.unitedmindset.controllers.newdvd.GetNewDvdCommand;
	import com.unitedmindset.controllers.newdvd.GetNewDvdResultCommand;
	import com.unitedmindset.controllers.openingnow.GetOpeningNowCommand;
	import com.unitedmindset.controllers.openingnow.GetOpeningNowResultCommand;
	import com.unitedmindset.controllers.reviews.GetReviewsCommand;
	import com.unitedmindset.controllers.reviews.GetReviewsResultCommand;
	import com.unitedmindset.controllers.search.GetSearchCommand;
	import com.unitedmindset.controllers.search.GetSearchResultCommand;
	import com.unitedmindset.controllers.toprentals.GetTopRentalsCommand;
	import com.unitedmindset.controllers.toprentals.GetTopRentalsResultCommand;
	import com.unitedmindset.controllers.upcomingdvd.GetUpcomingDvdCommand;
	import com.unitedmindset.controllers.upcomingdvd.GetUpcomingDvdResultCommand;
	import com.unitedmindset.controllers.upcomingtheaters.GetUpcomingTheatersCommand;
	import com.unitedmindset.controllers.upcomingtheaters.GetUpcomingTheatersResultCommand;
	import com.unitedmindset.events.RequestDataEvent;
	import com.unitedmindset.events.ServiceResponseEvent;
	import com.unitedmindset.models.ApplicationStateModel;
	import com.unitedmindset.models.BoxOfficeModel;
	import com.unitedmindset.models.CurrentDvdModel;
	import com.unitedmindset.models.InTheatersModel;
	import com.unitedmindset.models.NewDvdModel;
	import com.unitedmindset.models.OpeningNowModel;
	import com.unitedmindset.models.SearchModel;
	import com.unitedmindset.models.SelectedMovieModel;
	import com.unitedmindset.models.TopRentalsModel;
	import com.unitedmindset.models.UpcomingDvdModel;
	import com.unitedmindset.models.UpcomingTheatersModel;
	import com.unitedmindset.services.IRotTomService;
	import com.unitedmindset.services.RotTomService;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.mvcs.Context;
	
	public class RottenTomatoesBaseContext extends Context
	{
		public function RottenTomatoesBaseContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
		
		override public function startup():void
		{
			//service calls
			commandMap.mapEvent(RequestDataEvent.BOX_OFFICE_LIST, GetBoxOfficeCommand, RequestDataEvent);
			commandMap.mapEvent(RequestDataEvent.CURRENT_DVD_LIST, GetCurrentDvdCommand, RequestDataEvent);
			commandMap.mapEvent(RequestDataEvent.IN_THEATERS_LIST, GetInTheatersCommand, RequestDataEvent);
			commandMap.mapEvent(RequestDataEvent.NEW_DVD_LIST, GetNewDvdCommand, RequestDataEvent);
			commandMap.mapEvent(RequestDataEvent.OPENING_NOW_LIST, GetOpeningNowCommand, RequestDataEvent);
			commandMap.mapEvent(RequestDataEvent.SEARCH_LIST, GetSearchCommand, RequestDataEvent);
			commandMap.mapEvent(RequestDataEvent.TOP_RENTALS_LIST, GetTopRentalsCommand, RequestDataEvent);
			commandMap.mapEvent(RequestDataEvent.UPCOMING_DVD_LIST, GetUpcomingDvdCommand, RequestDataEvent);
			commandMap.mapEvent(RequestDataEvent.UPCOMING_THEATER_LIST, GetUpcomingTheatersCommand, RequestDataEvent);
			commandMap.mapEvent(RequestDataEvent.REVIEWS_LIST, GetReviewsCommand, RequestDataEvent);
			
			//service responses
			commandMap.mapEvent(ServiceResponseEvent.BOX_OFFICE_RESULT, GetBoxOfficeResultCommand, ServiceResponseEvent);
			commandMap.mapEvent(ServiceResponseEvent.CURRENT_DVD_RESULT, GetCurrentDvdResultCommand, ServiceResponseEvent);
			commandMap.mapEvent(ServiceResponseEvent.IN_THEATERS_RESULT, GetInTheaterResultCommand, ServiceResponseEvent);
			commandMap.mapEvent(ServiceResponseEvent.NEW_DVD_RESULT, GetNewDvdResultCommand, ServiceResponseEvent);
			commandMap.mapEvent(ServiceResponseEvent.OPENING_NOW_RESULT, GetOpeningNowResultCommand, ServiceResponseEvent);
			commandMap.mapEvent(ServiceResponseEvent.SEARCH_RESULT, GetSearchResultCommand, ServiceResponseEvent);
			commandMap.mapEvent(ServiceResponseEvent.TOP_RENTALS_RESULT, GetTopRentalsResultCommand, ServiceResponseEvent);
			commandMap.mapEvent(ServiceResponseEvent.UPCOMING_DVD_RESULT, GetUpcomingDvdResultCommand, ServiceResponseEvent);
			commandMap.mapEvent(ServiceResponseEvent.UPCOMING_THEATER_RESULT, GetUpcomingTheatersResultCommand, ServiceResponseEvent);
			commandMap.mapEvent(ServiceResponseEvent.REVIEWS_RESULT, GetReviewsResultCommand, ServiceResponseEvent);
			
			//services
			injector.mapSingletonOf(IRotTomService, RotTomService);
			
			//models
			injector.mapSingleton(BoxOfficeModel);
			injector.mapSingleton(CurrentDvdModel);
			injector.mapSingleton(InTheatersModel);
			injector.mapSingleton(NewDvdModel);
			injector.mapSingleton(OpeningNowModel);
			injector.mapSingleton(SearchModel);
			injector.mapSingleton(TopRentalsModel);
			injector.mapSingleton(UpcomingDvdModel);
			injector.mapSingleton(UpcomingTheatersModel);
			injector.mapSingleton(SelectedMovieModel);
			injector.mapSingleton(ApplicationStateModel);
		}
		
		override public function shutdown():void {}
	}
}