package com.unitedmindset.views.mediators
{
	import com.adobe.nativeExtensions.Vibration;
	import com.rottentomatoes.vos.ServiceFault;
	import com.unitedmindset.events.ModelUpdateEvent;
	import com.unitedmindset.models.ApplicationStateModel;
	import com.unitedmindset.models.NewDvdModel;
	import com.unitedmindset.utils.ViewNameUtil;
	import com.unitedmindset.views.NewDvdView;
	
	import flash.events.LocationChangeEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import mx.events.ResizeEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.components.List;
	import spark.events.IndexChangeEvent;
	
	public class NewDvdMediator extends Mediator
	{
		//---------------------------------------------------------------------
		//
		//  Constructor
		//
		//---------------------------------------------------------------------
		public function NewDvdMediator()
		{
			super();
		}
		
		//---------------------------------------------------------------------
		//
		//  Injections
		//
		//---------------------------------------------------------------------
		[Inject]
		public var view:NewDvdView;
		
		[Inject]
		public var model:NewDvdModel;
		
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
			
			view.menuButton.addEventListener(MouseEvent.CLICK, _onMenuButton);
			view.prevPageButton.addEventListener(MouseEvent.CLICK, _onPrevButton);
			view.nextPageButton.addEventListener(MouseEvent.CLICK, _onNextButton);
			//
			//  system add listeners
			//
			eventDispatcher.addEventListener(ModelUpdateEvent.NEW_DVD_LIST_CHANGED, _onSystem_ListChangedHandler);
			eventDispatcher.addEventListener(ModelUpdateEvent.NEW_DVD_LOADING_CHANGED, _onSystem_LoadingChangedHandler);
			
			//
			//  set view
			//
			if(model.listNeedsRefresh())
				model.getList();
			else
				_setView();
			_createAd();
		}
		
		override public function onRemove():void
		{
			_destroyAd();
			//
			//  view remove listeners
			//
			view.list.removeEventListener(IndexChangeEvent.CHANGE, _onList_ChangeHandler);
			view.homeButton.removeEventListener(MouseEvent.CLICK, _onHomeButton_ClickHandler);
			
			view.menuButton.removeEventListener(MouseEvent.CLICK, _onMenuButton);
			view.prevPageButton.removeEventListener(MouseEvent.CLICK, _onPrevButton);
			view.nextPageButton.removeEventListener(MouseEvent.CLICK, _onNextButton);
			//
			//  system remove listeners
			//
			eventDispatcher.removeEventListener(ModelUpdateEvent.NEW_DVD_LIST_CHANGED, _onSystem_ListChangedHandler);
			eventDispatcher.removeEventListener(ModelUpdateEvent.NEW_DVD_LOADING_CHANGED, _onSystem_LoadingChangedHandler);
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
			view.nextPageButton.enabled = model.isNextPage();
			view.prevPageButton.enabled = model.isPrevPage();
		}
		
		private var _adWebView:StageWebView;
		private var _adLocation:String = "http://unitedmindset.com/fmia/ad.html";
		private function _createAd():void
		{
			view.addEventListener(ResizeEvent.RESIZE, _onResizeHandler);
			if(!_adWebView)
			{
				_adWebView = new StageWebView();
				_adWebView.loadURL( _adLocation );
				_adWebView.addEventListener(LocationChangeEvent.LOCATION_CHANGE, _onAdClick);
			}
			_positionAd();
			_adWebView.stage = view.stage;
		}
		
		private function _positionAd():void
		{
			if(_adWebView)
			{
				var p:Point = view.localToGlobal(new Point(view.adHolder.x, view.adHolder.y));
				_adWebView.viewPort = new Rectangle(p.x, p.y, view.adHolder.width, view.adHolder.height);
			}
		}
		
		private function _destroyAd():void
		{
			view.removeEventListener(ResizeEvent.RESIZE, _onResizeHandler);
			if(_adWebView)
			{
				_adWebView.stage = null;
				_adWebView.removeEventListener(LocationChangeEvent.LOCATION_CHANGE, _onAdClick);
				_adWebView = null;
			}
		}
		
		private function _onAdClick(event:LocationChangeEvent):void
		{
			if(event.location != _adLocation)
			{
				event.preventDefault();
				navigateToURL( new URLRequest( event.location ) );
				_adWebView.loadURL( _adLocation );
			}
		}
		
		private function _onResizeHandler(event:ResizeEvent):void
		{
			view.callLater(_positionAd);
		}
		//---------------------------------------------------------------------
		//
		//  Handler Methods
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		//  view handlers
		//-----------------------------
		private function _onMenuButton(event:MouseEvent):void
		{
			view.menuGroup.visible = (view.menuGroup.visible)?false:true;
		}
		
		private function _onPrevButton(event:MouseEvent):void
		{
			model.getPrevPage();
		}
		
		private function _onNextButton(event:MouseEvent):void
		{
			model.getNextPage();
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
		
		private var _vibrate:Vibration;
		private function _onSystem_ListChangedHandler(event:ModelUpdateEvent):void
		{
			_setView();
			
			if(Vibration.isSupported)
			{
				if(!_vibrate)
					_vibrate = new Vibration();
				_vibrate.vibrate( 500 );
			}
		}
		
		private function _onSystem_FaultHandler(event:ModelUpdateEvent):void
		{
			var fault:ServiceFault = event.value as ServiceFault;
			view.errorLabel.visible = view.errorLabel.includeInLayout = true;
			view.errorLabel.text = fault.faultDetail;
		}
	}
}