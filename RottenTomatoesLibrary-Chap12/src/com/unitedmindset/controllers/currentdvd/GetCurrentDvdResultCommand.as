package com.unitedmindset.controllers.currentdvd
{
	import com.rottentomatoes.events.RottenTomatoesFaultEvent;
	import com.rottentomatoes.events.RottenTomatoesResultEvent;
	import com.unitedmindset.events.ServiceResponseEvent;
	import com.unitedmindset.models.CurrentDvdModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetCurrentDvdResultCommand extends Command
	{
		public function GetCurrentDvdResultCommand()
		{
			super();
		}
		
		[Inject]
		public var event:ServiceResponseEvent;
		
		[Inject]
		public var model:CurrentDvdModel;
		
		override public function execute():void
		{
			if(event.payload is RottenTomatoesResultEvent)
			{
				var e:RottenTomatoesResultEvent = event.payload as RottenTomatoesResultEvent;
				model.setList( e.result as Array, e.total )
			} else if(event.payload is RottenTomatoesFaultEvent){
				var f:RottenTomatoesFaultEvent = event.payload as RottenTomatoesFaultEvent;
				model.getFailed(f.fault);
			}
		}
	}
}