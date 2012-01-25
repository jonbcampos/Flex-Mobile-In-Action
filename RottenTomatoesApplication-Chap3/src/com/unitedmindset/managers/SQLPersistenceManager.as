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
		}
		
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
				} catch (error:SQLError)
				{
					//error
				}
			}
		}
		
		private var _createTableStatement:SQLStatement;
		
		private function _checkTable():void
		{
			if(!_createTableStatement)
			{
				_createTableStatement = new SQLStatement();
				var sql:String = "CREaTE TABLE IF NOT EXISTS storage (" +
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
			} catch (error:SQLError)
			{
				
			}
		}
		
		private var _readStatement:SQLStatement;
		
		private function _readFromTable(key:String):Object
		{
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
			_readStatement.parameters[":key"] = key;
			try
			{
				_readStatement.execute();
				var result:SQLResult = _readStatement.getResult();
				if(!result.data || result.data.length==0)
					return null;
				return result.data[0]["value"];
			}  catch (error:SQLError)
			{
			}
			return null;
		}
		
		private var _writeStatement:SQLStatement;
		
		private function _writeToTable(key:String, value:Object):void
		{
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
			_writeStatement.parameters[":key"] = key;
			_writeStatement.parameters[":value"] = value;
			try
			{
				_writeStatement.execute();
			} catch (error:SQLError)
			{
				
			}
		}
		
		private var _deleteStatement:SQLStatement;
		
		private function _deleteFromTable(key:String):void
		{
			if(!_deleteStatement)
			{
				_deleteStatement = new SQLStatement();
				_deleteStatement.sqlConnection = _connection;
				var sql:String = "DELETE FROM storage " +
					"WHERE key = :key";
				_deleteStatement.text = sql;
			}
			_deleteStatement.parameters[":key"] = key;
			try
			{
				_deleteStatement.execute();
			} catch (error:SQLError)
			{
				
			}
		}
		
		private var _deleteAllStatement:SQLStatement;
		
		private function _deleteAllFromTable():void
		{
			if(!_deleteAllStatement)
			{
				_deleteAllStatement = new SQLStatement();
				_deleteAllStatement.sqlConnection = _connection;
				var sql:String = "DELETE FROM storage";
				_deleteAllStatement.text = sql;
			}
			try
			{
				_deleteAllStatement.execute();
			} catch (error:SQLError)
			{
				
			}
		}
		
		private var _updateStatement:SQLStatement;
		
		private function _updateInTable(key:String, value:Object):void
		{
			if(!_updateStatement)
			{
				_updateStatement = new SQLStatement();
				_updateStatement.sqlConnection = _connection;
				var sql:String = "UPDATE storage " +
					"SET value = :value " +
					"WHERE key = :key";
				_updateStatement.text = sql;
			}
			_updateStatement.parameters[":key"] = key;
			_updateStatement.parameters[":value"] = value;
			try
			{
				_updateStatement.execute();
			} catch (error:SQLError)
			{
				
			}
		}
		
		public function initialize():void
		{
			_checkConnection();
			_checkTable();
		}
		
		public function read(key:String):Object
		{
			return _readFromTable(key);
		}
		
		public function write(key:String, value:Object):void
		{
			_writeToTable(key, value);
		}
		
		public function update(key:String, value:Object):void
		{
			_updateInTable(key, value);
		}
		
		public function deleteFromTable(key:String):void
		{
			_deleteFromTable(key);
		}
		
		public function deleteAll():void
		{
			_deleteAllFromTable();
		}
		
		private var _loaded:Boolean;
		public function load():Boolean
		{
			_checkConnection();
			_checkTable();
			_loaded = true;
			return _loaded;
		}
		
		public function clear():void
		{
			if(!_loaded)
				load();
			_deleteAllFromTable();
		}
		
		public function save():Boolean
		{
			return true;
		}
		
		public function getProperty(key:String):Object
		{
			if(!_loaded)
				load();
			return _readFromTable(key);
		}
		
		public function setProperty(key:String, value:Object):void
		{
			if(!_loaded)
				load();
			_writeToTable(key, value);
		}
	}
}