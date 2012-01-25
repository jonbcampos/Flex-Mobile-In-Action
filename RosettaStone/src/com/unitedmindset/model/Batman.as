package com.unitedmindset.model
{
	import com.unitedmindset.interfaces.ISuperInterface;
	
	public class Batman implements ISuperInterface
	{
		public function Batman()
		{
		}
		
		public function get name():String { return "I am Batman"; }
		
		public function fly(height:int):Boolean
		{
			return (height > 10 /*ft*/)?false:true;
		}
		
		public function run(speed:int):Boolean
		{
			return (speed > 15 /*mph*/)?false:true;
		}
		
		public function lift(weight:int):Boolean
		{
			return (weight>500/*lbs*/)?false:true;
		}
		
		public function saveCatFromTree():Boolean
		{
			return false;
		}
		
		public function playWithGadgets():Boolean
		{
			return true;
		}
	}
}