package com.unitedmindset.models
{
	import com.unitedmindset.events.MoveToViewEvent;
	
	import org.robotlegs.mvcs.Actor;
	
	import spark.managers.IPersistenceManager;
	import spark.managers.PersistenceManager;
	
	public class ApplicationStateModel extends Actor
	{
		//---------------------------------------------------------------------
		//
		//  Constructor
		//
		//---------------------------------------------------------------------
		public function ApplicationStateModel()
		{
			super();
			_getPersistedData();
		}
		
		//---------------------------------------------------------------------
		//
		//  Injections
		//
		//---------------------------------------------------------------------
		
		//---------------------------------------------------------------------
		//
		//  Constants
		//
		//---------------------------------------------------------------------
		
		//---------------------------------------------------------------------
		//
		//  Private Properties
		//
		//---------------------------------------------------------------------
		private var _persistenceManager:IPersistenceManager;
		//---------------------------------------------------------------------
		//
		//  Public Properties
		//
		//---------------------------------------------------------------------
		private var _currentView:String;
		public function currentView():String { return _currentView; };
		//---------------------------------------------------------------------
		//
		//  Public Methods
		//
		//---------------------------------------------------------------------
		public function moveToView(view:String, data:Object=null, relatedObject:Object=null):void
		{
			dispatch(new MoveToViewEvent(MoveToViewEvent.PUSH_VIEW, view, data, relatedObject));
			_currentView = view;
		}
		
		public function moveBackView():void
		{
			dispatch(new MoveToViewEvent(MoveToViewEvent.POP_VIEW, null));
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
		}
		
		private function _persistData():void
		{
			_persistenceManager.save();
		}
	}
}