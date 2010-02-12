package uk.co.ziazoo.snappyviewer.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.rpc.IResponder;
	
	import uk.co.ziazoo.snappyviewer.business.SnappyDelegate;
	import uk.co.ziazoo.snappyviewer.model.SnappyModelLocator;

	public class SortIItemCollectionByDateCommand implements ICommand , IResponder
	{
		public function execute( event : CairngormEvent ):void
		{			
			var delegate : SnappyDelegate = new SnappyDelegate( this );
			
			var field : SortField = new SortField( "date" , false , true , true );
			
			var sort : Sort = new Sort();
			sort.fields = [ field ];
			
			delegate.getOrderedDate( sort );
		}		
			
		public function result(data:Object) : void
		{
			SnappyModelLocator.getInstance().iItemCollection = data as ArrayCollection;
		}
	
		public function fault(info:Object) : void 
		{
			
		}
	}
}