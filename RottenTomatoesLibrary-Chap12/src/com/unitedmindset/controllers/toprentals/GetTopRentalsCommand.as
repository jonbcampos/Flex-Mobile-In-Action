package com.unitedmindset.controllers.toprentals
{
	import com.unitedmindset.events.RequestDataEvent;
	import com.unitedmindset.services.IRotTomService;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetTopRentalsCommand extends Command
	{
		public function GetTopRentalsCommand()
		{
			super();
		}
		
		[Inject]
		public var event:RequestDataEvent;
		
		[Inject]
		public var service:IRotTomService;
		
		override public function execute():void
		{
			service.getTopRentals( event.numOfResults );
		}
	}
}