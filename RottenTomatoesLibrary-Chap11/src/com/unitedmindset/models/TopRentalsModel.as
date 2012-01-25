package com.unitedmindset.models
{
	import com.rottentomatoes.vos.ServiceFault;
	import com.unitedmindset.events.ModelUpdateEvent;
	import com.unitedmindset.events.RequestDataEvent;
	
	import mx.collections.ArrayList;
	
	import org.robotlegs.mvcs.Actor;
	
	import spark.managers.IPersistenceManager;
	import spark.managers.PersistenceManager;
	
	public class TopRentalsModel extends Actor implements IListModel
	{
		//---------------------------------------------------------------------
		//
		//  Constructor
		//
		//---------------------------------------------------------------------
		public function TopRentalsModel()
		{
			super();
			_getPersistedData();
		}
		
		//---------------------------------------------------------------------
		//
		//  Constants
		//
		//---------------------------------------------------------------------
		private static const LIST:String = "topRentalsList";
		private static const TIMESTAMP:String = "topRentalsTimestamp";
		private static const CURRENT_PAGE:String = "topRentalsCurrentPage";
		private static const TOTAL:String = "topRentalsTotal";
		//---------------------------------------------------------------------
		//
		//  Private Properties
		//
		//---------------------------------------------------------------------
		private var _persistenceManager:IPersistenceManager;
		private var _timestamp:Date;
		//---------------------------------------------------------------------
		//
		//  Public Properties
		//
		//---------------------------------------------------------------------
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
		public function listNeedsRefresh():Boolean
		{
			return !list || !_timestamp || _timestamp.time < new Date().time - 3600000 /* one day */;
		}
		
		public function getList(page:int=1):void
		{
			_loading = true;
			dispatch(new ModelUpdateEvent(ModelUpdateEvent.TOP_RENTALS_LOADING_CHANGED, _loading));
			
			_currentPage = page;
			dispatch(new RequestDataEvent(RequestDataEvent.TOP_RENTALS_LIST, currentPage, numOfResults));
		}
		
		public function setList(value:Array, total:int):void
		{
			_loading = false;
			dispatch(new ModelUpdateEvent(ModelUpdateEvent.TOP_RENTALS_LOADING_CHANGED, _loading));
			
			_total = total;
			_list = new ArrayList(value);
			_timestamp = new Date();
			_persistData();
			
			dispatch(new ModelUpdateEvent(ModelUpdateEvent.TOP_RENTALS_LIST_CHANGED, list));
		}
		
		public function getFailed(fault:ServiceFault):void
		{
			_loading = false;
			dispatch(new ModelUpdateEvent(ModelUpdateEvent.TOP_RENTALS_LOADING_CHANGED, _loading));
			
			dispatch(new ModelUpdateEvent(ModelUpdateEvent.TOP_RENTALS_FAULT, fault));
		}
		
		public function isNextPage():Boolean
		{
			return false;
		}
		
		public function isPrevPage():Boolean
		{
			return false;
		}
		
		public function getNextPage():void
		{
			return;
		}
		
		public function getPrevPage():void
		{
			return;
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
			
			_list = _persistenceManager.getProperty(LIST) as ArrayList;
			_timestamp = _persistenceManager.getProperty(TIMESTAMP) as Date;
			_currentPage = _persistenceManager.getProperty(CURRENT_PAGE) as int;
			_total = _persistenceManager.getProperty(TOTAL) as int;
		}
		
		private function _persistData():void
		{
			_persistenceManager.setProperty(LIST, list);
			_persistenceManager.setProperty(TIMESTAMP, _timestamp);
			_persistenceManager.setProperty(CURRENT_PAGE, currentPage);
			_persistenceManager.setProperty(TOTAL, total);
			_persistenceManager.save();
		}
	}
}