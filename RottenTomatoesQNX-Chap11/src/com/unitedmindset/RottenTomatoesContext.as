package com.unitedmindset
{
	import com.unitedmindset.views.BoxOfficeView;
	import com.unitedmindset.views.CurrentDvdView;
	import com.unitedmindset.views.DetailsView;
	import com.unitedmindset.views.InTheatersView;
	import com.unitedmindset.views.MainMenuView;
	import com.unitedmindset.views.NewDvdView;
	import com.unitedmindset.views.OpeningNowView;
	import com.unitedmindset.views.SearchView;
	import com.unitedmindset.views.TopRentalsView;
	import com.unitedmindset.views.UpcomingDvdView;
	import com.unitedmindset.views.UpcomingTheatersView;
	import com.unitedmindset.views.mediators.ApplicationMediator;
	import com.unitedmindset.views.mediators.BoxOfficeMediator;
	import com.unitedmindset.views.mediators.CurrentDvdMediator;
	import com.unitedmindset.views.mediators.DetailsMediator;
	import com.unitedmindset.views.mediators.InTheatersMediator;
	import com.unitedmindset.views.mediators.MainMenuMediator;
	import com.unitedmindset.views.mediators.NewDvdMediator;
	import com.unitedmindset.views.mediators.OpeningNowMediator;
	import com.unitedmindset.views.mediators.SearchMediator;
	import com.unitedmindset.views.mediators.TopRentalsMediator;
	import com.unitedmindset.views.mediators.UpcomingDvdMediator;
	import com.unitedmindset.views.mediators.UpcomingTheatersMediator;
	
	import flash.display.DisplayObjectContainer;
	
	public class RottenTomatoesContext extends RottenTomatoesBaseContext
	{
		public function RottenTomatoesContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
		
		override public function startup():void
		{
			super.startup();
			
			mediatorMap.mapView(RottenTomatoesQNX, ApplicationMediator);
			mediatorMap.mapView(BoxOfficeView, BoxOfficeMediator);
			mediatorMap.mapView(CurrentDvdView, CurrentDvdMediator);
			mediatorMap.mapView(DetailsView, DetailsMediator);
			mediatorMap.mapView(InTheatersView, InTheatersMediator);
			mediatorMap.mapView(MainMenuView, MainMenuMediator);
			mediatorMap.mapView(NewDvdView, NewDvdMediator);
			mediatorMap.mapView(OpeningNowView, OpeningNowMediator);
			mediatorMap.mapView(SearchView, SearchMediator);
			mediatorMap.mapView(TopRentalsView, TopRentalsMediator);
			mediatorMap.mapView(UpcomingTheatersView, UpcomingTheatersMediator);
			mediatorMap.mapView(UpcomingDvdView, UpcomingDvdMediator);
		}
	}
}