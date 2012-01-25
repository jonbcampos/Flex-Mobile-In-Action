package com.unitedmindset.model
{
	/**
	 * Our Singleton Class. 
	 */	
	public class UserModel
	{
		//The protected instance of the UserModel
		private static var _instance:UserModel;
		
		public function UserModel(enforcer:SingletonEnforcer)
		{
			//constructor logic
		}
		
		public static function getInstance():UserModel
		{
			//first check if it exists. If not, make one
			if(!UserModel._instance)
				UserModel._instance = new UserModel(new SingletonEnforcer());
			//return our instance
			return UserModel._instance;
		}
		
		//
		//  Properties
		//
		//  Methods
		//
		//  ...
		//
	}
}
/**
 * Our Enforcer, only available to this Package. 
 */
class SingletonEnforcer{}