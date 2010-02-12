package uk.co.ziazoo.snappyviewer.vo
{
	import com.adobe.cairngorm.vo.IValueObject;
	
	public interface ComparableVO extends IValueObject
	{
		function equals ( vo : ComparableVO ) : Boolean;
	}
}