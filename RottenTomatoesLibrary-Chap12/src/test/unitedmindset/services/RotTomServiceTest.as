package test.unitedmindset.services
{
	import com.rottentomatoes.events.RottenTomatoesFaultEvent;
	import com.rottentomatoes.events.RottenTomatoesResultEvent;
	import com.unitedmindset.events.ServiceResponseEvent;
	import com.unitedmindset.services.RotTomService;
	
	import flash.events.EventDispatcher;
	
	import flashx.textLayout.debug.assert;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.async.Async;
	
	public class RotTomServiceTest
	{		
		private var _service:RotTomService;
		private var _serviceDispatcher:EventDispatcher;
		
		[Before]
		public function setUp():void
		{
			_serviceDispatcher = new EventDispatcher();
			_service = new RotTomService();
			_service.eventDispatcher = _serviceDispatcher;
		}
		
		[After]
		public function tearDown():void
		{
			_service.eventDispatcher = null;
			_serviceDispatcher = null;
			_service = null;
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		//-----------------------------
		// box office
		//-----------------------------
		[Test(async)]
		public function testGetBoxOfficeMoviesRequest1():void
		{
			_serviceDispatcher.addEventListener(ServiceResponseEvent.BOX_OFFICE_RESULT, Async.asyncHandler(this, _onGetBoxOffice_resultHandler, 2000, {"expectedResult":1}, _onGetBoxOffice_timeoutHandler), false, 0, true);
			_service.getBoxOfficeMovies(1, 1);
		}
		
		[Test(async)]
		public function testGetBoxOfficeMoviesRequest0():void
		{
			_serviceDispatcher.addEventListener(ServiceResponseEvent.BOX_OFFICE_RESULT, Async.asyncHandler(this, _onGetBoxOffice_resultHandler, 2000, {"expectedResult":1}, _onGetBoxOffice_timeoutHandler), false, 0, true);
			_service.getBoxOfficeMovies(0, 1);
		}
		
		[Test(async)]
		public function testGetBoxOfficeMoviesRequestNeg1():void
		{
			_serviceDispatcher.addEventListener(ServiceResponseEvent.BOX_OFFICE_RESULT, Async.asyncHandler(this, _onGetBoxOffice_resultHandler, 2000, {"expectedResult":1}, _onGetBoxOffice_timeoutHandler), false, 0, true);
			_service.getBoxOfficeMovies(-1, 1);
		}
		
		[Test(async)]
		public function testGetBoxOfficeMoviesRequest10():void
		{
			_serviceDispatcher.addEventListener(ServiceResponseEvent.BOX_OFFICE_RESULT, Async.asyncHandler(this, _onGetBoxOffice_resultHandler, 2000, {"expectedResult":10}, _onGetBoxOffice_timeoutHandler), false, 0, true);
			_service.getBoxOfficeMovies(10, 1);
		}
		
		private function _onGetBoxOffice_resultHandler(event:ServiceResponseEvent, object:Object):void
		{
			Assert.assertTrue( event.payload is RottenTomatoesResultEvent );
			Assert.assertTrue( (event.payload as RottenTomatoesResultEvent).result is Array );
			Assert.assertTrue( ((event.payload as RottenTomatoesResultEvent).result as Array).length <= object.expectedResult );
		}
		
		private function _onGetBoxOffice_timeoutHandler(object:Object):void
		{
			Assert.fail("Pending Box Office Service Never Occurred");
		}
		
		//-----------------------------
		// current release dvd
		//-----------------------------
		[Test]
		public function testGetCurrentReleaseDvd():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testGetInTheaterMovies():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testGetMoviesByTerm():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testGetNewReleaseDvd():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testGetOpeningMovies():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testGetReviewsById():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testGetTopRentals():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testGetUpcomingDvd():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testGetUpcomingMovies():void
		{
			Assert.fail("Test method Not yet implemented");
		}
	}
}