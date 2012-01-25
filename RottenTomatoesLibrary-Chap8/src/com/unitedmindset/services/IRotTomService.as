package com.unitedmindset.services
{
	public interface IRotTomService
	{
		function getMoviesByTerm(term:String, limit:int, page:int):void;
		function getBoxOfficeMovies(limit:int, page:int):void;
		function getCurrentReleaseDvd(limit:int, page:int):void;
		function getInTheaterMovies(limit:int, page:int):void;
		function getNewReleaseDvd(limit:int, page:int):void;
		function getOpeningMovies(limit:int):void;
		function getTopRentals(limit:int):void;
		function getUpcomingDvd(limit:int, page:int):void;
		function getUpcomingMovies(limit:int, page:int):void;
		function getReviewsById(id:String, limit:int, page:int):void;
	}
}