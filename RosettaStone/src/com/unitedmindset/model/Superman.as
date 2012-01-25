package com.unitedmindset.model
{
	import com.unitedmindset.interfaces.ISuperInterface;
	
	public class Superman implements ISuperInterface
	{
		public function Superman()
		{
		}
		
		public function get name():String { return "Superman"; }
		
		public function fly(height:int):Boolean
		{
			return true;
		}
		
		public function run(speed:int):Boolean
		{
			return true;
		}
		
		public function lift(weight:int):Boolean
		{
			return true;
		}
		
		public function saveCatFromTree():Boolean
		{
			return true;
		}
		
		public function playWithGadgets():Boolean
		{
			return false;
		}
	}
}