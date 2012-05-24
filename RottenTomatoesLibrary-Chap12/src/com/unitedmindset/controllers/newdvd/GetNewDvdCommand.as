package com.unitedmindset.controllers.newdvd
{
	import com.unitedmindset.events.RequestDataEvent;
	import com.unitedmindset.services.IRotTomService;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetNewDvdCommand extends Command
	{
		public function GetNewDvdCommand()
		{
			super();
		}
		
		[Inject]
		public var event:RequestDataEvent;
		
		[Inject]
		public var service:IRotTomService;
		
		override public function execute():void
		{
			service.getNewReleaseDvd( event.numOfResults, event.page );
		}
	}
}