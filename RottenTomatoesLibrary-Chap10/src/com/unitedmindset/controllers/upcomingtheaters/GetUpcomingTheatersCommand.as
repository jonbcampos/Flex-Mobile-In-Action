package com.unitedmindset.controllers.upcomingtheaters
{
	import com.unitedmindset.events.RequestDataEvent;
	import com.unitedmindset.services.IRotTomService;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetUpcomingTheatersCommand extends Command
	{
		public function GetUpcomingTheatersCommand()
		{
			super();
		}
		
		[Inject]
		public var event:RequestDataEvent;
		
		[Inject]
		public var service:IRotTomService;
		
		override public function execute():void
		{
			service.getUpcomingMovies( event.numOfResults, event.page);
		}
	}
}