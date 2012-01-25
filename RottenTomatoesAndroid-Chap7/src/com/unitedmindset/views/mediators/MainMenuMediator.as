package com.unitedmindset.views.mediators
{
	import com.unitedmindset.models.ApplicationStateModel;
	import com.unitedmindset.utils.ViewNameUtil;
	import com.unitedmindset.views.MainMenuView;
	
	import mx.collections.ArrayList;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.components.List;
	import spark.events.IndexChangeEvent;
	
	public class MainMenuMediator extends Mediator
	{
		//---------------------------------------------------------------------
		//
		//  Contructor
		//
		//---------------------------------------------------------------------
		public function MainMenuMediator()
		{
			super();
		}
		
		//---------------------------------------------------------------------
		//
		//  Injections
		//
		//---------------------------------------------------------------------
		[Inject]
		public var view:MainMenuView;
		
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
			//
			//  system add listeners
			//
			
			//
			//  set view
			//
			var dp:ArrayList = new ArrayList();
			dp.addItem( {"label":ViewNameUtil.SEARCH_VIEW} );
			dp.addItem( {"label":ViewNameUtil.BOX_OFFICE_VIEW} );
			dp.addItem( {"label":ViewNameUtil.CURRENT_DVD_VIEW} );
			dp.addItem( {"label":ViewNameUtil.IN_THEATERS_VIEW} );
			dp.addItem( {"label":ViewNameUtil.NEW_DVD_VIEW} );
			dp.addItem( {"label":ViewNameUtil.OPENING_NOW_VIEW} );
			dp.addItem( {"label":ViewNameUtil.TOP_RENTALS_VIEW} );
			dp.addItem( {"label":ViewNameUtil.UPCOMING_DVD_VIEW} );
			dp.addItem( {"label":ViewNameUtil.UPCOMING_THEATERS_VIEW} );
			view.list.dataProvider = dp;
		}
		
		override public function onRemove():void
		{
			//
			//  view remove listeners
			//
			view.list.removeEventListener(IndexChangeEvent.CHANGE, _onList_ChangeHandler);
			//
			//  system remove listeners
			//
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
		private function _onList_ChangeHandler(event:IndexChangeEvent):void
		{
			stateModel.moveToView( (event.target as List).selectedItem.label as String );
		}
	}
}