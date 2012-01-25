package com.unitedmindset.views.mediators
{
	import com.rottentomatoes.vos.ServiceFault;
	import com.unitedmindset.events.ModelUpdateEvent;
	import com.unitedmindset.models.ApplicationStateModel;
	import com.unitedmindset.models.UpcomingTheatersModel;
	import com.unitedmindset.utils.ViewNameUtil;
	import com.unitedmindset.views.UpcomingTheatersView;
	
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.utils.getDefinitionByName;
	
	import mx.events.EffectEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import qnx.events.QNXApplicationEvent;
	import qnx.system.QNXApplication;
	
	import spark.components.List;
	import spark.events.IndexChangeEvent;
	
	public class UpcomingTheatersMediator extends Mediator
	{
		//---------------------------------------------------------------------
		//
		//  Constructor
		//
		//---------------------------------------------------------------------
		public function UpcomingTheatersMediator()
		{
			super();
		}
		
		//---------------------------------------------------------------------
		//
		//  Injections
		//
		//---------------------------------------------------------------------
		[Inject]
		public var view:UpcomingTheatersView;
		
		[Inject]
		public var model:UpcomingTheatersModel;
		
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
			
			view.addEventListener(KeyboardEvent.KEY_DOWN, _onKeyDown);
			view.slideOut.addEventListener(EffectEvent.EFFECT_END, _onSlideOut_CompleteHandler);
			_addQnxHandlers();
			//
			//  system add listeners
			//
			eventDispatcher.addEventListener(ModelUpdateEvent.UPCOMING_THEATER_LIST_CHANGED, _onSystem_ListChangedHandler);
			eventDispatcher.addEventListener(ModelUpdateEvent.UPCOMING_THEATER_LOADING_CHANGED, _onSystem_LoadingChangedHandler);
			
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
			
			view.removeEventListener(KeyboardEvent.KEY_DOWN, _onKeyDown);
			view.slideOut.removeEventListener(EffectEvent.EFFECT_END, _onSlideOut_CompleteHandler);
			_removeQnxHandlers();
			//
			//  system remove listeners
			//
			eventDispatcher.removeEventListener(ModelUpdateEvent.UPCOMING_THEATER_LIST_CHANGED, _onSystem_ListChangedHandler);
			eventDispatcher.removeEventListener(ModelUpdateEvent.UPCOMING_THEATER_LOADING_CHANGED, _onSystem_LoadingChangedHandler);
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
		private function _onKeyDown(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.MENU:
					_toggleMenu();
					break;
			}
		}
		
		private function _addQnxHandlers():void
		{
			try
			{
				var c:Class = getDefinitionByName("qnx.system.QNXApplication") as Class;
				var q:QNXApplication;
				c.qnxApplication.addEventListener(QNXApplicationEvent.SWIPE_DOWN, _onView_SwipeDownHandler);
			}
			catch(error:Error)
			{
				//do nothing
			}
		}
		
		private function _removeQnxHandlers():void
		{
			try
			{
				var c:Class = getDefinitionByName("qnx.system.QNXApplication") as Class;
				var q:QNXApplication;
				c.qnxApplication.removeEventListener(QNXApplicationEvent.SWIPE_DOWN, _onView_SwipeDownHandler);
			}
			catch(error:Error)
			{
				//do nothing
			}
		}
		
		private function _toggleMenu():void
		{
			if(view.menuPopup.displayPopUp)
				_hideMenu();
			else
				_showMenu();
		}
		
		private function _hideMenu():void
		{
			if(view.menuPopup.displayPopUp)
			{
				//remove handlers
				view.nextPage.removeEventListener(MouseEvent.CLICK, _onNextPage);
				view.previousPage.removeEventListener(MouseEvent.CLICK, _onPreviousPage);
				
				view.slideOut.yFrom = 0;
				view.slideOut.yTo = -view.menuGroup.height;
				view.slideOut.play([view.menuGroup]);
			}
		}
		
		private function _showMenu():void
		{
			view.menuPopup.displayPopUp = true;
			
			view.slideIn.yFrom = -view.menuGroup.height;
			view.slideIn.yTo = 0;
			view.slideIn.play([view.menuGroup]);
			
			if(view.menuPopup.displayPopUp)
			{
				//add listners
				view.nextPage.addEventListener(MouseEvent.CLICK, _onNextPage);
				view.previousPage.addEventListener(MouseEvent.CLICK, _onPreviousPage);
				view.nextPage.enabled = model.isNextPage();
				view.previousPage.enabled = model.isPrevPage();
			}
		}
		//---------------------------------------------------------------------
		//
		//  Handler Methods
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		//  view handlers
		//-----------------------------
		private function _onView_SwipeDownHandler(event:QNXApplicationEvent):void
		{
			_toggleMenu();
		}
		
		private function _onSlideOut_CompleteHandler(event:EffectEvent):void
		{
			view.menuPopup.displayPopUp = false;
		}
		
		private function _onNextPage(event:MouseEvent):void
		{
			model.getNextPage();
		}
		
		private function _onPreviousPage(event:MouseEvent):void
		{
			model.getPrevPage();
		}
		
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