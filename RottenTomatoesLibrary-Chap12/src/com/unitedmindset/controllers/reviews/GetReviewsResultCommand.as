package com.unitedmindset.controllers.reviews
{
	import com.rottentomatoes.events.RottenTomatoesFaultEvent;
	import com.rottentomatoes.events.RottenTomatoesResultEvent;
	import com.unitedmindset.events.ServiceResponseEvent;
	import com.unitedmindset.models.SelectedMovieModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetReviewsResultCommand extends Command
	{
		public function GetReviewsResultCommand()
		{
			super();
		}
		
		[Inject]
		public var event:ServiceResponseEvent;
		
		[Inject]
		public var model:SelectedMovieModel;
		
		override public function execute():void
		{
			if(event.payload is RottenTomatoesResultEvent)
			{
				var e:RottenTomatoesResultEvent = event.payload as RottenTomatoesResultEvent;
				model.setList( e.result as Array, e.total )
			} else if(event.payload is RottenTomatoesFaultEvent){
				var f:RottenTomatoesFaultEvent = event.payload as RottenTomatoesFaultEvent;
				model.getFailed(f.fault);
			}
		}
	}
}