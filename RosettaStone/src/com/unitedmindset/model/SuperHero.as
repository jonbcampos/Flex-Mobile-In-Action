package com.unitedmindset.model
{
	public class SuperHero extends Hero
	{
		public function SuperHero()
		{
			super();
		}
		
		public var powers:Array;
		
		public function usePower(power:String):void
		{
			//execute power
			var user:UserModel = UserModel.getInstance();
		}
		
		public function savePlanet():Boolean
		{
			return true;
		}
	}
}