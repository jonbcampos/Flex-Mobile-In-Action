package com.unitedmindset.utils
{
	import com.rottentomatoes.vos.MovieVO;
	import com.rottentomatoes.vos.ReviewVO;

	public class RendererUtil
	{
		public static function reviewLabelFunction(item:Object):String
		{
			if(item is ReviewVO)
			{
				var review:ReviewVO = item as ReviewVO;
				
				var label:String = "";
				if(review.critic)
					label += review.critic
				if(review.critic && review.originalScore)
					label += " - ";
				if(review.originalScore)
					label += review.originalScore;
				
				return label;
			}
			return null;
		}
		
	}
}