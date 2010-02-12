package uk.co.ziazoo.snappyviewer.business
{
	import com.adobe.cairngorm.business.ServiceLocator;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import uk.co.ziazoo.snappyviewer.vo.ImageVO;
	
	public class SnappyDelegate
	{
		private var responder : IResponder;
		private var service : HTTPService;
		
		public function SnappyDelegate ( responder : IResponder )
		{
			this.service = ServiceLocator.getInstance().getHTTPService("imageData" );
			this.responder = responder;		
		}
		
		public function getData () : void
		{
			var call : AsyncToken = service.send();
			var r : Responder = new Responder ( onGetDataResult , responder.fault );
			call.addResponder( r );
		}
		
		private var _sort : Sort;
		
		public function getOrderedDate ( sort : Sort ) : void
		{
			_sort = sort;
			var call : AsyncToken = service.send();
			var r : Responder = new Responder ( onGetOrderedDate , responder.fault );
			call.addResponder( r );
		}
		
		private function onGetOrderedDate (data:Object) : void
		{
			var xml : XML = ResultEvent( data ).result as XML;
			
			var list : ArrayCollection = getArrayCollectionFromXML( xml );
			
			list.sort = _sort;
			list.refresh();
			
			responder.result( list );
		}
		
		private function onGetDataResult (data:Object) : void
		{
			var xml : XML = ResultEvent( data ).result as XML;
			responder.result( getArrayCollectionFromXML( xml ) );			
		}
	
		private function getArrayCollectionFromXML ( xml : XML ) : ArrayCollection
		{
			var list : ArrayCollection = new ArrayCollection();
			
			// loop through xml and create GridItems for the SnappyModelLocator
			for each ( var img : XML in xml.img )
			{
				// construct the date parts
				var year : String = img.@date.substr( 6 , 4 ) 
				var month : String = String ( Number ( img.@date.substr( 3 , 2 ) ) - 1 );
				var date : String =  img.@date.substr( 0 , 2 )
				
				// create an imageVO from the XML to pass to the GridItem
				var imgVO : ImageVO = new ImageVO( img , new Date ( year , month , date ) );
				
				// create the GridItem and add it to the collection
				//var gridItem : Item = new Item( imgVO );				
				
				list.addItem( imgVO );	
			}
			return list;
		}
	}
	
}