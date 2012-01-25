package com.unitedmindset.views.mediators
{
	import com.rottentomatoes.vos.ServiceFault;
	import com.unitedmindset.events.ModelUpdateEvent;
	import com.unitedmindset.models.ApplicationStateModel;
	import com.unitedmindset.models.InTheatersModel;
	import com.unitedmindset.utils.ViewNameUtil;
	import com.unitedmindset.views.InTheatersView;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.components.List;
	import spark.events.IndexChangeEvent;
	
	public class InTheatersMediator extends Mediator
	{
		//---------------------------------------------------------------------
		//
		//  Constructor
		//
		//---------------------------------------------------------------------
		public function InTheatersMediator()
		{
			super();
		}
		
		//---------------------------------------------------------------------
		//
		//  Injections
		//
		//---------------------------------------------------------------------
		[Inject]
		public var view:InTheatersView;
		
		[Inject]
		public var model:InTheatersModel;
		
		[Inject]
		public var stateModel:ApplicationStateModel;
		//---------------------------------------------------------------------
		//
		//  Private Properties
		//
		//---------------------------------------------------------------------
		
		//---------------------------------------------------------------------
		//
		//  Overridden Methods
		//
		//---------------------------------------------------------------------
		override public function onRegister():void
		{
			//
			//  view add listeners
			//
			view.list.addEventListener(IndexChangeEvent.CHANGE, _onList_ChangeHandler);
			view.homeButton.addEventListener(MouseEvent.CLICK, _onHomeButton_ClickHandler);
			//
			//  system add listeners
			//
			eventDispatcher.addEventListener(ModelUpdateEvent.IN_THEATER_LIST_CHANGED, _onSystem_ListChangedHandler);
			eventDispatcher.addEventListener(ModelUpdateEvent.IN_THEATER_LOADING_CHANGED, _onSystem_LoadingChangedHandler);
			
			//
			//  set view
			//
			if(model.listNeedsRefresh())
				model.getList();
			else
				_setView();
		}
		
		override public function onRemove():void
		{
			//
			//  view remove listeners
			//
			view.list.removeEventListener(IndexChangeEvent.CHANGE, _onList_ChangeHandler);
			view.homeButton.removeEventListener(MouseEvent.CLICK, _onHomeButton_ClickHandler);
			//
			//  system remove listeners
			//
			eventDispatcher.removeEventListener(ModelUpdateEvent.IN_THEATER_LIST_CHANGED, _onSystem_ListChangedHandler);
			eventDispatcher.removeEventListener(ModelUpdateEvent.IN_THEATER_LOADING_CHANGED, _onSystem_LoadingChangedHandler);
		}
		
		//---------------------------------------------------------------------
		//
		//  Private Methods
		//
		//---------------------------------------------------------------------
		private function _setView():void
		{
			view.list.dataProvider = model.list;
			view.bottomActionBar.title = "Page: "+model.currentPage+" out of "+Math.ceil(model.total/model.numOfResults)+" - Total Results: "+model.total;
		}
		//---------------------------------------------------------------------
		//
		//  Handler Methods
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		//  view handlers
		//-----------------------------
		private function _onList_ChangeHandler(event:IndexChangeEvent):void
		{
			stateModel.moveToView(ViewNameUtil.DETAILS_VIEW, (event.target as List).selectedItem);
		}
		
		private function _onHomeButton_ClickHandler(event:MouseEvent):void
		{
			stateModel.moveToView(ViewNameUtil.MAIN_MENU_VIEW, null, view.homeButton);
		}
		
		//-----------------------------
		//  system handlers
		//-----------------------------
		private function _onSystem_LoadingChangedHandler(event:ModelUpdateEvent):void
		{
			view.busyIndicator.visible = view.busyIndicator.includeInLayout = event.value as Boolean;
		}
		
		private function _onSystem_ListChangedHandler(event:ModelUpdateEvent):void
		{
			_setView();
		}
		
		private function _onSystem_FaultHandler(event:ModelUpdateEvent):void
		{
			var fault:ServiceFault = event.value as ServiceFault;
			view.errorLabel.visible = view.errorLabel.includeInLayout = true;
			view.errorLabel.text = fault.faultDetail;
		}
	}
}