package uk.co.ziazoo.snappyviewer.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	
	import uk.co.ziazoo.snappyviewer.business.SnappyDelegate;
	import uk.co.ziazoo.snappyviewer.model.SnappyModelLocator;

	public class GetImageDataCommand implements ICommand , IResponder
	{
		
		public function execute( event : CairngormEvent ) : void
		{
			var delegate : SnappyDelegate = new SnappyDelegate( this );
			delegate.getData();
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