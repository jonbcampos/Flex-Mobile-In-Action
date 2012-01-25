package com.unitedmindset.controllers
{
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Command;
	
	public class StartupCompleteCommand extends Command
	{
		public function StartupCompleteCommand()
		{
			super();
		}
		
		[Inject]
		public var event:ContextEvent;
		
		override public function execute():void
		{
			
		}
	}
}