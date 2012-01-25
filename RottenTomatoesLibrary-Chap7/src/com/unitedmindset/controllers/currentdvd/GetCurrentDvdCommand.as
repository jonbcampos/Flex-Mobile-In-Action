package com.unitedmindset.controllers.currentdvd
{
	import com.unitedmindset.events.RequestDataEvent;
	import com.unitedmindset.services.IRotTomService;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetCurrentDvdCommand extends Command
	{
		public function GetCurrentDvdCommand()
		{
			super();
		}
		
		[Inject]
		public var event:RequestDataEvent;
		
		[Inject]
		public var service:IRotTomService;
		
		override public function execute():void
		{
			service.getCurrentReleaseDvd( event.numOfResults, event.page);
		}
	}
}