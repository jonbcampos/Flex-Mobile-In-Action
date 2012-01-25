package com.unitedmindset.controllers.reviews
{
	import com.unitedmindset.events.RequestDataEvent;
	import com.unitedmindset.services.IRotTomService;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetReviewsCommand extends Command
	{
		public function GetReviewsCommand()
		{
			super();
		}
		
		[Inject]
		public var event:RequestDataEvent;
		
		[Inject]
		public var service:IRotTomService;
		
		override public function execute():void
		{
			service.getReviewsById( event.term, event.numOfResults, event.page);
		}
	}
}