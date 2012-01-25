package com.unitedmindset.controllers.openingnow
{
	import com.unitedmindset.events.RequestDataEvent;
	import com.unitedmindset.models.OpeningNowModel;
	import com.unitedmindset.services.IRotTomService;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetOpeningNowCommand extends Command
	{
		public function GetOpeningNowCommand()
		{
			super();
		}
		
		[Inject]
		public var event:RequestDataEvent;
		
		[Inject]
		public var model:OpeningNowModel;
		
		[Inject]
		public var service:IRotTomService;
		
		override public function execute():void
		{
			service.getOpeningMovies( model.numOfResults );
		}
	}
}