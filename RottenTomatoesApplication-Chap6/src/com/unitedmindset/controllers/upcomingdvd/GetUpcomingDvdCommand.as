package com.unitedmindset.controllers.upcomingdvd
{
	import com.unitedmindset.events.RequestDataEvent;
	import com.unitedmindset.services.IRotTomService;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetUpcomingDvdCommand extends Command
	{
		public function GetUpcomingDvdCommand()
		{
			super();
		}
		
		[Inject]
		public var event:RequestDataEvent;
		
		[Inject]
		public var service:IRotTomService;
		
		override public function execute():void
		{
			service.getUpcomingDvd( event.numOfResults, event.page);
		}
	}
}