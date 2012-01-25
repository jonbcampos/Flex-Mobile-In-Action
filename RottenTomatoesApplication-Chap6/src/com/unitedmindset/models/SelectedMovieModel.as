package com.unitedmindset.models
{
	import com.rottentomatoes.vos.MovieVO;
	import com.rottentomatoes.vos.ServiceFault;
	import com.unitedmindset.events.ModelUpdateEvent;
	import com.unitedmindset.events.RequestDataEvent;
	
	import mx.collections.ArrayList;
	
	import org.robotlegs.mvcs.Actor;
	
	import spark.managers.IPersistenceManager;
	import spark.managers.PersistenceManager;
	
	public class SelectedMovieModel extends Actor implements IListModel
	{
		//---------------------------------------------------------------------
		//
		//  Constructor
		//
		//---------------------------------------------------------------------
		public function SelectedMovieModel()
		{
			super();
			_getPersistedData();
		}
		
		//---------------------------------------------------------------------
		//
		//  Constants
		//
		//---------------------------------------------------------------------
		public static const SELECTED_MOVIE:String = "selectedMovie";
		public static const LAST_MOVIE_ID:String = "lastMovieId";
		
		private static const LIST:String = "reviewsList";
		private static const TIMESTAMP:String = "reviewsTimestamp";
		private static const CURRENT_PAGE:String = "reviewsCurrentPage";
		private static const TOTAL:String = "reviewsTotal";
		//---------------------------------------------------------------------
		//
		//  Private Properties
		//
		//---------------------------------------------------------------------
		private var _persistenceManager:IPersistenceManager;
		private var _timestamp:Date;
		private var _lastMovieId:String;
		//---------------------------------------------------------------------
		//
		//  Public Properties
		//
		//---------------------------------------------------------------------
		private var _movie:MovieVO;
		public function get movie():MovieVO { return _movie; }
		
		private var _loading:Boolean;
		public function get loading():Boolean { return _loading; }
		
		private var _list:ArrayList;
		public function get list():ArrayList { return _list; }
		
		private var _total:int;
		public function get total():int { return _total; }
		
		private var _numOfResults:int = 16;
		public function get numOfResults():int { return _numOfResults; }
		
		private var _currentPage:int;
		public function get currentPage():int { return _currentPage; }
		//---------------------------------------------------------------------
		//
		//  Public Methods
		//
		//---------------------------------------------------------------------
		public function setSelectedMovie(movie:MovieVO):void
		{
			_movie = movie;
			_persistData();
		}
		
		public function getList(page:int=1):void
		{
			_loading = true;
			dispatch(new ModelUpdateEvent(ModelUpdateEvent.REVIEWS_LOADING_CHANGED, _loading));
			
			_currentPage = page;
			dispatch(new RequestDataEvent(RequestDataEvent.REVIEWS_LIST, page, numOfResults, movie.id));
		}
		
		public function setList(value:Array, total:int):void
		{
			_loading = false;
			dispatch(new ModelUpdateEvent(ModelUpdateEvent.REVIEWS_LOADING_CHANGED, _loading));
			
			_total = total;
			_list = new ArrayList(value);
			_timestamp = new Date();
			_lastMovieId = movie.id;
			_persistData();
			
			dispatch(new ModelUpdateEvent(ModelUpdateEvent.REVIEWS_LIST_CHANGED, list));
		}
		
		public function getFailed(fault:ServiceFault):void
		{
			_loading = false;
			dispatch(new ModelUpdateEvent(ModelUpdateEvent.REVIEWS_LOADING_CHANGED, _loading));
			
			dispatch(new ModelUpdateEvent(ModelUpdateEvent.REVIEWS_FAULT, fault));
		}
		
		public function listNeedsRefresh():Boolean
		{
			return !list || !_lastMovieId || _lastMovieId != movie.id || !_timestamp || _timestamp.time < new Date().time - 3600000 /* one day */;
		}
		
		public function isNextPage():Boolean
		{
			return currentPage*numOfResults < total;
		}
		
		public function isPrevPage():Boolean
		{
			return currentPage>1;
		}
		
		public function getNextPage():void
		{
			if(!isNextPage())
				return;
			getList( currentPage+1 );
		}
		
		public function getPrevPage():void
		{
			if(!isPrevPage())
				return;
			getList( currentPage-1 );
		}
		//---------------------------------------------------------------------
		//
		//  Private Methods
		//
		//---------------------------------------------------------------------
		private function _getPersistedData():void
		{
			_persistenceManager = new PersistenceManager();
			_persistenceManager.load();
			
			_movie = _persistenceManager.getProperty(SELECTED_MOVIE) as MovieVO;
			_list = _persistenceManager.getProperty(LIST) as ArrayList;
			_timestamp = _persistenceManager.getProperty(TIMESTAMP) as Date;
			_currentPage = _persistenceManager.getProperty(CURRENT_PAGE) as int;
			_total = _persistenceManager.getProperty(TOTAL) as int;
			_lastMovieId = _persistenceManager.getProperty(LAST_MOVIE_ID) as String;
		}
		
		private function _persistData():void
		{
			_persistenceManager.setProperty(LIST, list);
			_persistenceManager.setProperty(TIMESTAMP, _timestamp);
			_persistenceManager.setProperty(CURRENT_PAGE, currentPage);
			_persistenceManager.setProperty(TOTAL, total);
			_persistenceManager.setProperty(SELECTED_MOVIE, movie);
			_persistenceManager.setProperty(LAST_MOVIE_ID, _lastMovieId);
			_persistenceManager.save();
		}
	}
}