package uk.co.ziazoo.snappyviewer.vo
{
	import com.adobe.cairngorm.vo.IValueObject;

	public class ImageVO implements ComparableVO
	{
		public var date : Date;
		public var url : String;
		
		public function ImageVO ( url : String = "" , date : Date = null )
		{
			this.url = url;
			this.date = date;
		}
		
		public function equals ( vo : ComparableVO ) : Boolean
		{
			var imgVO : ImageVO = ImageVO ( vo );
			return imgVO.url == this.url;
		}
	}
}