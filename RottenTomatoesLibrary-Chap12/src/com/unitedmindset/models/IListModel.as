package com.unitedmindset.models
{
	import com.rottentomatoes.vos.ServiceFault;
	
	import mx.collections.ArrayList;

	public interface IListModel
	{
		function get loading():Boolean;
		function get list():ArrayList;
		function get total():int;
		function get numOfResults():int;
		function get currentPage():int;
		function listNeedsRefresh():Boolean;
		function getList(page:int=1):void;
		function setList(value:Array, total:int):void;
		function getFailed(fault:ServiceFault):void;
		function isNextPage():Boolean;
		function isPrevPage():Boolean;
		function getNextPage():void;
		function getPrevPage():void;
	}
}