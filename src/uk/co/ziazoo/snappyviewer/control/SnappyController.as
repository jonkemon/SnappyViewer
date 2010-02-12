package uk.co.ziazoo.snappyviewer.control
{
	import com.adobe.cairngorm.control.FrontController;
	
	import uk.co.ziazoo.snappyviewer.commands.GetImageDataCommand;
	import uk.co.ziazoo.snappyviewer.commands.SortIItemCollectionByDateCommand;
	import uk.co.ziazoo.snappyviewer.commands.SortIItemCollectionByUrlCommand;

	public class SnappyController extends FrontController
	{		
		public static const SORT_IITEM_COLLECTION_BY_URL : String = "sortIItemCollectionByUrl";
		public static const SORT_IITEM_COLLECTION_BY_DATE : String = "sortIItemCollectionByDate";
		public static const APPLICATON_LOADED : String = "appLoaded";
		
		public function SnappyController ()
		{
			super();
			addCommand( SORT_IITEM_COLLECTION_BY_URL , SortIItemCollectionByUrlCommand );
			addCommand( SORT_IITEM_COLLECTION_BY_DATE , SortIItemCollectionByDateCommand );
			addCommand( APPLICATON_LOADED , GetImageDataCommand );
		}
	}
}