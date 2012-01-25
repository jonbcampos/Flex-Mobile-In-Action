package com.unitedmindset.controllers.intheaters
{
	import com.unitedmindset.events.RequestDataEvent;
	import com.unitedmindset.services.IRotTomService;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetInTheatersCommand extends Command
	{
		public function GetInTheatersCommand()
		{
			super();
		}
		
		[Inject]
		public var event:RequestDataEvent;
		
		[Inject]
		public var service:IRotTomService;
		
		override public function execute():void
		{
			service.getInTheaterMovies( event.numOfResults, event.page);
		}
	}
}