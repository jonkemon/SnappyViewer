package uk.co.ziazoo.snappyviewer.events
{
	import flash.events.Event;
	
	import uk.co.ziazoo.snappyviewer.view.imageViewer.Item;

	public class ItemEvent extends Event
	{
		public static const SELECT : String = "onSelectGridItem";
		private var _gridItem : Item;
		
		public function ItemEvent(type:String, gridItem : Item , bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_gridItem = gridItem;
		}
		
		public function get item () : Item
		{
			return _gridItem;
		}
		
		override public function clone () : Event
		{
			return new ItemEvent( type , _gridItem , bubbles , cancelable );
		}
		
		override public function toString () : String 
		{
			return formatToString( "ItemEvent", "type", "gridItem" , "bubbles", "cancelable", "eventPhase" ); 
		}
	}
}