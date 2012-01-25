package com.unitedmindset.views.mediators
{
	import com.rottentomatoes.vos.MovieVO;
	import com.rottentomatoes.vos.ServiceFault;
	import com.unitedmindset.events.ModelUpdateEvent;
	import com.unitedmindset.models.ApplicationStateModel;
	import com.unitedmindset.models.SelectedMovieModel;
	import com.unitedmindset.utils.ViewNameUtil;
	import com.unitedmindset.views.DetailsView;
	
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class DetailsMediator extends Mediator
	{
		//---------------------------------------------------------------------
		//
		//  Contructor
		//
		//---------------------------------------------------------------------
		public function DetailsMediator()
		{
			super();
		}
		
		//---------------------------------------------------------------------
		//
		//  Injections
		//
		//---------------------------------------------------------------------
		[Inject]
		public var view:DetailsView;
		
		[Inject]
		public var stateModel:ApplicationStateModel;
		
		[Inject]
		public var model:SelectedMovieModel;
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
			view.homeButton.addEventListener(MouseEvent.CLICK, _onHomeButton_ClickHandler);
			//
			//  system add listeners
			//
			eventDispatcher.addEventListener(ModelUpdateEvent.REVIEWS_FAULT, _onSystem_FaultHandler);
			eventDispatcher.addEventListener(ModelUpdateEvent.REVIEWS_LIST_CHANGED, _onSystem_ListChangedHandler);
			eventDispatcher.addEventListener(ModelUpdateEvent.REVIEWS_LOADING_CHANGED, _onSystem_LoadingChangedHandler);
			//
			//  set view
			//
			model.setSelectedMovie( view.data as MovieVO );
			model.getList();
			_setView();
		}
		
		override public function onRemove():void
		{
			//
			//  view remove listeners
			//
			view.homeButton.removeEventListener(MouseEvent.CLICK, _onHomeButton_ClickHandler);
			//
			//  system remove listeners
			//
			eventDispatcher.removeEventListener(ModelUpdateEvent.REVIEWS_FAULT, _onSystem_FaultHandler);
			eventDispatcher.removeEventListener(ModelUpdateEvent.REVIEWS_LIST_CHANGED, _onSystem_ListChangedHandler);
			eventDispatcher.removeEventListener(ModelUpdateEvent.REVIEWS_LOADING_CHANGED, _onSystem_LoadingChangedHandler);
		}
		
		//---------------------------------------------------------------------
		//
		//  Private Methods
		//
		//---------------------------------------------------------------------
		private function _setView():void
		{
			//set view
			view.title = model.movie.title;
			view.image.source = model.movie.detailedPoster;
			view.details.text = model.movie.synopsis;
			view.criticConsensus.text = model.movie.criticsConsensus;
			//mid
			view.audienceScoreImage.source = model.movie.audienceIcon;
			view.audienceScoreDetails.text = model.movie.audienceScore+"%";
			//bottom
			view.criticsScoreImage.source = model.movie.criticsIcon;
			view.criticsScoreDetails.text = model.movie.criticsScore+"%";
			
			view.reviewsList.dataProvider = model.list;
		}
		//---------------------------------------------------------------------
		//
		//  Handler Methods
		//
		//---------------------------------------------------------------------
		
		//-----------------------------
		//  view handlers
		//-----------------------------
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