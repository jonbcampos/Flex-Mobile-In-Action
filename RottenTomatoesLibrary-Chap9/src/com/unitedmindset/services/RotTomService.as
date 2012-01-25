package com.unitedmindset.services
{	
	import com.rottentomatoes.RottenTomatoesService;
	import com.rottentomatoes.events.RottenTomatoesFaultEvent;
	import com.rottentomatoes.events.RottenTomatoesResultEvent;
	import com.unitedmindset.events.ServiceResponseEvent;
	
	import org.robotlegs.mvcs.Actor;
	
	public class RotTomService extends Actor implements IRotTomService
	{
		public function RotTomService()
		{
			super();
			_createService();
		}
		
		//---------------------------------------------------------------------
		//
		//  Private Properties
		//
		//---------------------------------------------------------------------
		private var _service:RottenTomatoesService;
		//---------------------------------------------------------------------
		//
		//  Public Methods
		//
		//---------------------------------------------------------------------
		public function getMoviesByTerm(term:String, limit:int, page:int):void
		{
			_service.getMoviesByTerm(term, limit, page);
		}
		
		public function getBoxOfficeMovies(limit:int, page:int):void
		{
			_service.getBoxOfficeMovies(limit, page);
		}
		
		public function getCurrentReleaseDvd(limit:int, page:int):void
		{
			_service.getCurrentReleaseDvd(limit, page);
		}
		
		public function getInTheaterMovies(limit:int, page:int):void
		{
			_service.getInTheaterMovies(limit, page);
		}
		
		public function getNewReleaseDvd(limit:int, page:int):void
		{
			_service.getNewReleaseDvd(limit, page);
		}
		
		public function getOpeningMovies(limit:int):void
		{
			_service.getOpeningMovies(limit);
		}
		
		public function getTopRentals(limit:int):void
		{
			_service.getTopRentals(limit);
		}
		
		public function getUpcomingDvd(limit:int, page:int):void
		{
			_service.getUpcomingDvd(limit, page);
		}
		
		public function getUpcomingMovies(limit:int, page:int):void
		{
			_service.getUpcomingMovies(limit, page);
		}
		
		public function getReviewsById(id:String, limit:int, page:int):void
		{
			_service.getMovieReviewById(id, "all", limit, page);
		}
		//---------------------------------------------------------------------
		//
		//  Private Methods
		//
		//---------------------------------------------------------------------
		private function _createService():void
		{
			_service = new RottenTomatoesService();
			_service.apikey = "z2eq9xmy8zpdezazprruedz2";
			_service.addEventListener(RottenTomatoesResultEvent.RESULT, _onService_ResultHandler);
			_service.addEventListener(RottenTomatoesFaultEvent.FAULT, _onService_FaultHandler);
		}
		
		//---------------------------------------------------------------------
		//
		//  Handler Methods
		//
		//---------------------------------------------------------------------
		private function _onService_ResultHandler(event:RottenTomatoesResultEvent):void
		{
			switch(event.serviceType)
			{
				case RottenTomatoesService.MOVIE_SEARCH_TEMPLATE:
					dispatch(new ServiceResponseEvent(ServiceResponseEvent.SEARCH_RESULT, event));
					break;
				case RottenTomatoesService.BOX_OFFICE_TEMPLATE:
					dispatch(new ServiceResponseEvent(ServiceResponseEvent.BOX_OFFICE_RESULT, event));
					break;
				case RottenTomatoesService.CURRENT_RELEASE_DVDS_TEMPLATE:
					dispatch(new ServiceResponseEvent(ServiceResponseEvent.CURRENT_DVD_RESULT, event));
					break;
				case RottenTomatoesService.IN_THEATERS_TEMPLATE:
					dispatch(new ServiceResponseEvent(ServiceResponseEvent.IN_THEATERS_RESULT, event));
					break;
				case RottenTomatoesService.NEW_RELEASE_DVDS_TEMPLATE:
					dispatch(new ServiceResponseEvent(ServiceResponseEvent.NEW_DVD_RESULT, event));
					break;
				case RottenTomatoesService.OPENING_MOVIES_TEMPLATE:
					dispatch(new ServiceResponseEvent(ServiceResponseEvent.OPENING_NOW_RESULT, event));
					break;
				case RottenTomatoesService.TOP_RENTALS_TEMPLATE:
					dispatch(new ServiceResponseEvent(ServiceResponseEvent.TOP_RENTALS_RESULT, event));
					break;
				case RottenTomatoesService.UPCOMING_DVDS_TEMPLATE:
					dispatch(new ServiceResponseEvent(ServiceResponseEvent.UPCOMING_DVD_RESULT, event));
					break;
				case RottenTomatoesService.UPCOMING_MOVIES_TEMPLATE:
					dispatch(new ServiceResponseEvent(ServiceResponseEvent.UPCOMING_THEATER_RESULT, event));
					break;
				case RottenTomatoesService.MOVIE_REVIEWS_TEMPLATE:
					dispatch(new ServiceResponseEvent(ServiceResponseEvent.REVIEWS_RESULT, event));
					break;
			}
		}
		
		private function _onService_FaultHandler(event:RottenTomatoesFaultEvent):void
		{
			switch(event.serviceType)
			{
				case RottenTomatoesService.MOVIE_SEARCH_TEMPLATE:
					dispatch(new ServiceResponseEvent(ServiceResponseEvent.SEARCH_RESULT, event));
					break;
				case RottenTomatoesService.BOX_OFFICE_TEMPLATE:
					dispatch(new ServiceResponseEvent(ServiceResponseEvent.BOX_OFFICE_RESULT, event));
					break;
				case RottenTomatoesService.CURRENT_RELEASE_DVDS_TEMPLATE:
					dispatch(new ServiceResponseEvent(ServiceResponseEvent.CURRENT_DVD_RESULT, event));
					break;
				case RottenTomatoesService.IN_THEATERS_TEMPLATE:
					dispatch(new ServiceResponseEvent(ServiceResponseEvent.IN_THEATERS_RESULT, event));
					break;
				case RottenTomatoesService.NEW_RELEASE_DVDS_TEMPLATE:
					dispatch(new ServiceResponseEvent(ServiceResponseEvent.NEW_DVD_RESULT, event));
					break;
				case RottenTomatoesService.OPENING_MOVIES_TEMPLATE:
					dispatch(new ServiceResponseEvent(ServiceResponseEvent.OPENING_NOW_RESULT, event));
					break;
				case RottenTomatoesService.TOP_RENTALS_TEMPLATE:
					dispatch(new ServiceResponseEvent(ServiceResponseEvent.TOP_RENTALS_RESULT, event));
					break;
				case RottenTomatoesService.UPCOMING_DVDS_TEMPLATE:
					dispatch(new ServiceResponseEvent(ServiceResponseEvent.UPCOMING_DVD_RESULT, event));
					break;
				case RottenTomatoesService.UPCOMING_MOVIES_TEMPLATE:
					dispatch(new ServiceResponseEvent(ServiceResponseEvent.UPCOMING_THEATER_RESULT, event));
					break;
				case RottenTomatoesService.MOVIE_REVIEWS_TEMPLATE:
					dispatch(new ServiceResponseEvent(ServiceResponseEvent.REVIEWS_RESULT, event));
					break;
			}
		}
		
	}
}