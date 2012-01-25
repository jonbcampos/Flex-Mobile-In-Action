package com.unitedmindset.views.mediators
{
	import com.google.analytics.GATracker;
	import com.unitedmindset.events.MoveToViewEvent;
	import com.unitedmindset.events.TrackingEvent;
	import com.unitedmindset.models.ApplicationStateModel;
	import com.unitedmindset.utils.ViewNameUtil;
	import com.unitedmindset.views.BoxOfficeView;
	import com.unitedmindset.views.CurrentDvdView;
	import com.unitedmindset.views.DetailsView;
	import com.unitedmindset.views.InTheatersView;
	import com.unitedmindset.views.NewDvdView;
	import com.unitedmindset.views.OpeningNowView;
	import com.unitedmindset.views.SearchView;
	import com.unitedmindset.views.TopRentalsView;
	import com.unitedmindset.views.UpcomingDvdView;
	import com.unitedmindset.views.UpcomingTheatersView;
	
	import flash.desktop.NativeApplication;
	import flash.display.DisplayObjectContainer;
	import flash.events.InvokeEvent;
	
	import mx.events.FlexEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ApplicationMediator extends Mediator
	{
		//---------------------------------------------------------------------
		//
		//  Contructor
		//
		//---------------------------------------------------------------------
		public function ApplicationMediator()
		{
			super();
		}
		
		//---------------------------------------------------------------------
		//
		//  Injections
		//
		//---------------------------------------------------------------------
		[Inject]
		public var view:RottenTomatoesAndroid;
		
		[Inject]
		public var stateModel:ApplicationStateModel;
		//---------------------------------------------------------------------
		//
		//  Private Properties
		//
		//---------------------------------------------------------------------
		private var _tracker:GATracker;
		//---------------------------------------------------------------------
		//
		//  Overridden Methods
		//
		//---------------------------------------------------------------------
		override public function onRegister():void
		{
			//add tracker
			//_tracker = new GATracker(view, "yourUA-ID", "AS3", true);
			
			//
			//  view add listeners
			//
			view.addEventListener(FlexEvent.PREINITIALIZE, _onView_preinitializeHandler);
			//
			//  system add listeners
			//
			eventDispatcher.addEventListener(MoveToViewEvent.PUSH_VIEW, _onSystem_PushViewHandler);
			eventDispatcher.addEventListener(MoveToViewEvent.POP_VIEW, _onSystem_PopViewHandler);
			
			eventDispatcher.addEventListener(TrackingEvent.PAGE, _onSystem_TrackingPageHandler);
			eventDispatcher.addEventListener(TrackingEvent.EVENT, _onSystem_TrackingEventHandler);
			//
			//  set view
			//
		}
		
		override public function onRemove():void
		{
			//
			//  view remove listeners
			//
			view.removeEventListener(FlexEvent.PREINITIALIZE, _onView_preinitializeHandler);
			
			//
			//  system remove listeners
			//
			eventDispatcher.removeEventListener(MoveToViewEvent.PUSH_VIEW, _onSystem_PushViewHandler);
			eventDispatcher.removeEventListener(MoveToViewEvent.POP_VIEW, _onSystem_PopViewHandler);
			
			eventDispatcher.removeEventListener(TrackingEvent.PAGE, _onSystem_TrackingPageHandler);
			eventDispatcher.removeEventListener(TrackingEvent.EVENT, _onSystem_TrackingEventHandler);
		}
		
		//---------------------------------------------------------------------
		//
		//  Private Methods
		//
		//---------------------------------------------------------------------
		
		//---------------------------------------------------------------------
		//
		//  Handler Methods
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		//  view handlers
		//-----------------------------
		private function _onView_preinitializeHandler(event:FlexEvent):void
		{
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, _onApp_invokeHandler);
		}
		
		private function _onApp_invokeHandler(event:InvokeEvent):void
		{
			NativeApplication.nativeApplication.removeEventListener(InvokeEvent.INVOKE, _onApp_invokeHandler);
			var arguements:Array = event.arguments;
			//do something
		}
		//-----------------------------
		//  system handlers
		//-----------------------------
		private function _onSystem_PushViewHandler(event:MoveToViewEvent):void
		{
			dispatch( new TrackingEvent(TrackingEvent.PAGE, event.view) );
			
			switch(event.view)
			{
				case ViewNameUtil.BOX_OFFICE_VIEW:
					view.navigator.pushView(BoxOfficeView, event.data);
					break;
				case ViewNameUtil.CURRENT_DVD_VIEW:
					view.navigator.pushView(CurrentDvdView, event.data);
					break;
				case ViewNameUtil.DETAILS_VIEW:
					view.navigator.pushView(DetailsView, event.data);
					break;
				case ViewNameUtil.IN_THEATERS_VIEW:
					view.navigator.pushView(InTheatersView, event.data);
					break;
				case ViewNameUtil.MAIN_MENU_VIEW:
					//if in landscape, do nothing
					//in portrait, show call out
					if(view.aspectRatio == "portrait")
					{
						view.splitViewNavigator.showFirstViewNavigatorInPopUp( event.relatedObject as DisplayObjectContainer );
					}
					break;
				case ViewNameUtil.NEW_DVD_VIEW:
					view.navigator.pushView(NewDvdView, event.data);
					break;
				case ViewNameUtil.OPENING_NOW_VIEW:
					view.navigator.pushView(OpeningNowView, event.data);
					break;
				case ViewNameUtil.SEARCH_VIEW:
					view.navigator.pushView(SearchView, event.data);
					break;
				case ViewNameUtil.TOP_RENTALS_VIEW:
					view.navigator.pushView(TopRentalsView, event.data);
					break;
				case ViewNameUtil.UPCOMING_DVD_VIEW:
					view.navigator.pushView(UpcomingDvdView, event.data);
					break;
				case ViewNameUtil.UPCOMING_THEATERS_VIEW:
					view.navigator.pushView(UpcomingTheatersView, event.data);
					break;
			}
		}
		
		private function _onSystem_PopViewHandler(event:MoveToViewEvent):void
		{
			view.navigator.popView();
		}
		
		private function _onSystem_TrackingPageHandler(event:TrackingEvent):void
		{
			//_tracker.trackPageview("/"+event.category);
		}
		
		private function _onSystem_TrackingEventHandler(event:TrackingEvent):void
		{
			//_tracker.trackEvent(event.category, event.action, event.label, event.value);
		}
	}
}