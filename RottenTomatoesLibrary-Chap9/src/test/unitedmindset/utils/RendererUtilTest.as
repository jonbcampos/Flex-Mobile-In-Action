package test.unitedmindset.utils
{
	import com.rottentomatoes.vos.MovieVO;
	import com.unitedmindset.utils.RendererUtil;
	
	import flexunit.framework.Assert;
	
	public class RendererUtilTest
	{		
		[Before]
		public function setUp():void { }
		
		[After]
		public function tearDown():void { }
		
		[BeforeClass]
		public static function setUpBeforeClass():void { }
		
		[AfterClass]
		public static function tearDownAfterClass():void { }
		
		[Test]
		public function testMovieMessageFunctionNull():void
		{
			Assert.assertNull( RendererUtil.movieMessageFunction(null) );
		}
		
		[Test]
		public function testMovieMessageFunctionMovieWithNoMpaa():void
		{
			var movie:MovieVO = new MovieVO();
			movie.mpaaRating = null;
			movie.runtime = 100;
			Assert.assertEquals( "Runtime: 100min", RendererUtil.movieMessageFunction(movie) );
		}
		
		[Test]
		public function testMovieMessageFunctionMovieWithNoRuntime():void
		{
			var movie:MovieVO = new MovieVO();
			movie.mpaaRating = "PG";
			movie.runtime = 0;
			Assert.assertEquals( "Rated: PG", RendererUtil.movieMessageFunction(movie) );
		}
		
		[Test]
		public function testMovieMessageFunctionCompleteMovie():void
		{
			var movie:MovieVO = new MovieVO();
			movie.mpaaRating = "PG";
			movie.runtime = 100;
			Assert.assertEquals( "Rated: PG Runtime: 100min", RendererUtil.movieMessageFunction(movie) );
		}
		
		[Test]
		public function testMovieMessageFunctionFailTest():void
		{
			var movie:MovieVO = new MovieVO();
			movie.mpaaRating = "R";
			movie.runtime = 100;
			Assert.assertEquals( "Rated: PG Runtime: 100min", RendererUtil.movieMessageFunction(movie) );
		}
		
		[Test]
		public function testMovieMessageFunctionString():void
		{
			Assert.assertNull( RendererUtil.movieMessageFunction("") );
		}
	}
}