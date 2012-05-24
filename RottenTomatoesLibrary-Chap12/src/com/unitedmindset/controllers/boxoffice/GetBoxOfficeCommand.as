package com.unitedmindset.controllers.boxoffice
{
	import com.unitedmindset.events.RequestDataEvent;
	import com.unitedmindset.events.TrackingEvent;
	import com.unitedmindset.services.IRotTomService;
	import com.unitedmindset.utils.ViewNameUtil;
	
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
			dispatch( new TrackingEvent(TrackingEvent.EVENT, "Request Data", ViewNameUtil.BOX_OFFICE_VIEW, "Page "+event.page) );
			
			service.getBoxOfficeMovies(event.numOfResults, event.page);
		}
	}
}