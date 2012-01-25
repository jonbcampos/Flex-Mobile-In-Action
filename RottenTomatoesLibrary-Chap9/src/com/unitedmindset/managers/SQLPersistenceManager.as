package com.unitedmindset.managers
{
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.errors.SQLError;
	import flash.filesystem.File;
	
	import spark.managers.IPersistenceManager;

	public class SQLPersistenceManager implements IPersistenceManager
	{
		public function SQLPersistenceManager()
		{
			super();
		}
		
		//check connection
		
		private var _connection:SQLConnection;
		
		private function _checkConnection():void
		{
			if(!_connection)
				_connection = new SQLConnection();
			if(!_connection.connected)
			{
				var dbFile:File = File.applicationStorageDirectory.resolvePath("rottentomatoes.db");
				try
				{
					_connection.open(dbFile);
				} 
				catch(error:SQLError) 
				{
					//Houston, we have a problem
				}
			}
		}
		
		//check table
		
		private var _createTableStatement:SQLStatement;
		
		private function _checkTable():void
		{
			if(!_createTableStatement)
			{
				_createTableStatement = new SQLStatement();
				var sql:String = "CREATE TABLE IF NOT EXISTS storage (" +
					"id INTEGER PRIMARY KEY AUTOINCREMENT, " +
					"key TEXT UNIQUE, " +
					"value BLOB" +
					")";
				_createTableStatement.sqlConnection = _connection;
				_createTableStatement.text = sql;
			}
			try
			{
				_createTableStatement.execute();
			} 
			catch(error:SQLError) 
			{
				//Dang
			}
		}
		
		//read from table
		
		private var _readStatement:SQLStatement;
		
		private function _readFromTable(key:String):Object
		{
			//create statement
			if(!_readStatement)
			{
				_readStatement = new SQLStatement();
				_readStatement.sqlConnection = _connection;
				var sql:String = "SELECT value " +
					"FROM storage " +
					"WHERE key = :key " +
					"LIMIT 1";
				_readStatement.text = sql;
			}
			//set parameters
			_readStatement.parameters[":key"] = key;
			//execute statement
			try
			{
				_readStatement.execute();
				var result:SQLResult = _readStatement.getResult();
				if(!result.data || result.data.length==0)
					return null;
				return result.data[0]["value"];
			} 
			catch(error:SQLError) 
			{
				//Danger Will Robinson, Danger
			}
			return null;
		}
		
		//write to table
		
		private var _writeStatement:SQLStatement;
		
		private function _writeToTable(key:String, value:Object):void
		{
			//create statement
			if(!_writeStatement)
			{
				_writeStatement = new SQLStatement();
				_writeStatement.sqlConnection = _connection;
				var sql:String = "INSERT OR REPLACE INTO storage " +
					"(key, value) " +
					"VALUES " +
					"(:key, :value)";
				_writeStatement.text = sql;
			}
			//set parameters
			_writeStatement.parameters[":key"] = key;
			_writeStatement.parameters[":value"] = value;
			//execute statement
			try
			{
				_writeStatement.execute();
			} 
			catch(error:SQLError) 
			{
				//I have a bad feeling about this...
			}
		}
		
		//delete from table
		
		private var _deleteStatement:SQLStatement;
		
		private function _deleteFromTable(key:String):void
		{
			//create statement
			if(!_deleteStatement)
			{
				_deleteStatement = new SQLStatement();
				_deleteStatement.sqlConnection = _connection;
				var sql:String = "DELETE FROM storage " +
					"WHERE key = :key";
				_deleteStatement.text = sql;
			}
			//set parameters
			_deleteStatement.parameters[":key"] = key;
			//execute statement
			try
			{
				_deleteStatement.execute();
			} 
			catch(error:SQLError) 
			{
				//You're messing up my chi man
			}
		}
		
		//update in table
		
		private var _updateStatement:SQLStatement;
		
		private function _updateInTable(key:String, value:Object):void
		{
			//create statement
			if(!_updateStatement)
			{
				_updateStatement = new SQLStatement();
				_updateStatement.sqlConnection = _connection;
				var sql:String = "UPDATE storage " +
					"SET value = :value " +
					"WHERE key = :key";
				_updateStatement.text = sql;
			}
			//set parameters
			_updateStatement.parameters[":key"] = key;
			_updateStatement.parameters[":value"] = value;
			//execute statement
			try
			{
				_updateStatement.execute();
			} 
			catch(error:SQLError) 
			{
				//Red Alert
			}
		}
		
		//drop table
		
		private var _deleteAllStatement:SQLStatement;
		
		private function _deleteAllFromTable():void
		{
			//create statement
			if(!_deleteAllStatement)
			{
				_deleteAllStatement = new SQLStatement();
				_deleteAllStatement.sqlConnection = _connection;
				var sql:String = "DELETE FROM storage";
				_deleteAllStatement.text = sql;
			}
			//execute statement
			try
			{
				_deleteAllStatement.execute();
			} 
			catch(error:SQLError) 
			{
				//I'll be back
			}
		}
		
		//interface methods
		public function clear():void
		{
			//load if needed
			if(!_loaded)
				load();
			//delete all
			_deleteAllFromTable();
		}
		
		public function save():Boolean
		{
			return true;
		}
		
		private var _loaded:Boolean;
		public function load():Boolean
		{
			_checkConnection();
			_checkTable();
			_loaded = true;
			return _loaded;
		}
		
		public function setProperty(key:String, value:Object):void
		{
			//load if needed
			if(!_loaded)
				load();
			//write
			_writeToTable(key, value);
		}
		
		public function getProperty(key:String):Object
		{
			//load if needed
			if(!_loaded)
				load();
			//read
			return _readFromTable(key);
		}
	}
}