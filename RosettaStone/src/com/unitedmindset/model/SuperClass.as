package com.unitedmindset.model
{
	public class SuperClass extends Object
	{
		public function SuperClass()
		{
			_validateData();
		}
		
		
		private function _validateData():void
		{
			/*
			for(var i:int=0; i<5; i++)
			{
				trace(i);
			}
			
			//output:
			//0
			//1
			//2
			//3
			//4
			
			var obj:Object = {firstName:"Clark", lastNmae:"Kent", hero:"Superman"};
			for (var i:String in obj)
			{
				trace(i + ": "+obj[i]);
			}
			//output:
			//firstName: Clark
			//lastName: Kent
			//hero: Superman
			
			var a:Array = [1,2,3];
			for (var i:String in a)
			{
				trace(a[i]);
			}
			//output:
			//1
			//2
			//3
			
			var xml:XML = <powers>
							<power>flight</power>
							<power>strength</power>
							<power>speed</power>
						</powers>;
			for each(var item in xml.power)
			{
				trace(item);
			}
			//output
			//flight
			//strength
			//speed
			
			var i:int = -1;
			while(++i<5)
			{
				trace(i);
			}
			//0
			//1
			//2
			//3
			//4
			*/
			var i:int = 0;
			do
			{
				trace(i);
			} while(++i<5);
			//output
			//0
			//1
			//2
			//3
			//4
			
			if(i<5)
			{
				//then execute this code
			} else if(i>5)
			{
				//then execute this code
			} else {
				//finally execute this code
			}
			
			switch(name)
			{
				case "Clark":
					//if name is 'Clark' execute this statement
					break;
				case "Hal":
					//if name is 'Hal' execute this statement
					break;
				case "Wally":
				case "Barry":
					//if name is 'Wally' or 'Barry' execute this statement
					break;
				default:
					//if name is anything else execute this statement
					break;
			}
		}
		
	}
}
