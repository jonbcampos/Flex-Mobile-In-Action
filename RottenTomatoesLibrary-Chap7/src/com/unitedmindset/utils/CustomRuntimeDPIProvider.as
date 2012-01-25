package com.unitedmindset.utils
{
	import flash.system.Capabilities;
	
	import mx.core.DPIClassification;
	import mx.core.RuntimeDPIProvider;
	
	public class CustomRuntimeDPIProvider extends RuntimeDPIProvider
	{
		public function CustomRuntimeDPIProvider()
		{
			super();
		}
		
		override public function get runtimeDPI():Number
		{
			var screenResolutionX:Number = Capabilities.screenResolutionX;
			var screenResolutionY:Number = Capabilities.screenResolutionY;
			var manufacturer:String = Capabilities.manufacturer;
			var screenDPI:Number = Capabilities.screenDPI;
			
			//droid pro portrait
			if(screenResolutionX == 480 &&
				screenResolutionY == 854 && 
				manufacturer == "Android Linux" &&
				screenDPI == 144)
				return DPIClassification.DPI_240;
			//droid pro landscape
			else if(screenResolutionX == 854 &&
				screenResolutionY == 480 && 
				manufacturer == "Android Linux" &&
				screenDPI == 144)
				return DPIClassification.DPI_240;
			//finally
			return super.runtimeDPI;
		}
	}
}