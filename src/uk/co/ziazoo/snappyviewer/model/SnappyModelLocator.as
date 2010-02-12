package uk.co.ziazoo.snappyviewer.model
{
	import com.adobe.cairngorm.CairngormError;
	import com.adobe.cairngorm.CairngormMessageCodes;
	import com.adobe.cairngorm.model.IModelLocator;
	
	import mx.collections.ArrayCollection;
	
	import uk.co.ziazoo.snappyviewer.control.SnappyController;
	import uk.co.ziazoo.snappyviewer.data.IItem;
	
	
	public class SnappyModelLocator implements IModelLocator
	{
		private static var _instance : SnappyModelLocator;
		
		public function SnappyModelLocator() 
		{   
			if ( _instance != null )
				throw new CairngormError( CairngormMessageCodes.SINGLETON_EXCEPTION, "SnappyModelLocator" );
			
			_instance = this;
		}
		
		public static function getInstance() : SnappyModelLocator
		{
			if ( ! _instance ) _instance = new SnappyModelLocator();
			return _instance;
		}
		
		[Bindable]
		public var iItemCollection : ArrayCollection = new ArrayCollection();
		
		[Bindable]
		public var sortTypes : Array = 
					[	{ data : "" , label : "[Sort By]" } ,
						{ data : SnappyController.SORT_IITEM_COLLECTION_BY_DATE , label : "by date" } ,
						{ data : SnappyController.SORT_IITEM_COLLECTION_BY_URL , label : "by url" }	]
					
		public var selectedItem : IItem;
	}
}