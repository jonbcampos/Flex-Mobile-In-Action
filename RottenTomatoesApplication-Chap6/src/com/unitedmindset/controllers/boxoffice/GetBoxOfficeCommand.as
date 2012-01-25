package com.unitedmindset.controllers.boxoffice
{
	import com.unitedmindset.events.RequestDataEvent;
	import com.unitedmindset.services.IRotTomService;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetBoxOfficeCommand extends Command
	{
		public function GetBoxOfficeCommand()
		{
			super();
		}
		
		[Inject]
		public var event:RequestDataEvent;
		
		[Inject]
		public var service:IRotTomService;
		
		override public function execute():void
		{
			service.getBoxOfficeMovies(event.numOfResults, event.page);
		}
	}
}