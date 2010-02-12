package uk.co.ziazoo.snappyviewer.view.imageViewer
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;
	
	import uk.co.ziazoo.snappyviewer.data.IItem;
	import uk.co.ziazoo.snappyviewer.events.ItemEvent;
	import uk.co.ziazoo.snappyviewer.view.IItemDisplayer;
	import uk.co.ziazoo.snappyviewer.view.IItemView;
	import uk.co.ziazoo.snappyviewer.vo.ComparableVO;
	import uk.co.ziazoo.snappyviewer.vo.ImageVO;

	[Event(name="onSelectedItemClick", type="flash.events.Event")]
	
	[Event(name="onItemClick", type="flash.events.Event")]
	
	public class ItemView extends UIComponent implements IItemView
	{
		protected var _items : ArrayCollection;
		protected var _data : ArrayCollection;
		protected var _itemDisplayer : IItemDisplayer;
		protected var _selectedItem : IItem;

		public function ItemView ()
		{
			_items = new ArrayCollection();
			_data = new ArrayCollection();
		}
		
		public function set itemDisplayer ( itemDisplayer : IItemDisplayer ) : void 
		{
			_itemDisplayer = itemDisplayer;
			display();
		}		
		
		public function set dataProvider ( data : ArrayCollection ) : void
		{
			updateItemsList( data );
			_data = data;
			display();
		}
			
		
		public function get dataProvider () : ArrayCollection 
		{
			return _data;
		}
		
		public function display () : void
		{
			if ( _itemDisplayer != null )
				_itemDisplayer.display( _items , unscaledWidth , unscaledHeight , _selectedItem );
		}
				
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			display();
		}
		
		protected function updateItemsList ( data : ArrayCollection ) : void
		{
			// loop through new data and add any items that are now needed
			for ( var i : int = 0 ; i < data.length ; i++ ) 
			{
				if ( ! listContains( _data , ComparableVO ( data[i] ) ) ) addItem ( ImageVO ( data [i] ) );
			}
			
			for ( var j : int = 0 ; j < data.length ; j++ ) 
			{
				var item : Item = getItemByVO( ImageVO ( data[j] ) );				
				_items.removeItemAt( _items.getItemIndex( item ) );				
				_items.addItemAt( item , j );
			}
		}
		
		protected function listContains ( list : ArrayCollection , vo : ComparableVO ) : Boolean
		{
			for ( var i : int = 0; i < list.length ; i++ )
			{
				if ( vo.equals( ComparableVO( list[i] ) ) ) return true;
			}
			return false;
		}
		
		protected function addItem ( vo : ImageVO ) : void
		{
			var item : Item = new Item( vo );
			// hide the item initally
			item.alpha = 0;
			// add necessary event listeners
			item.addEventListener( ItemEvent.SELECT , onItemSelected );
			// add to _items list
			_items.addItem( item );
			// add item to the DisplayList
			addChild( item );		
		}
		
		protected function getItemByVO ( vo : ImageVO ) : Item 
		{
			for ( var i : int = 0 ; i < _items.length ; i++ )
			{
				var item : Item = Item ( _items[i] );
				if ( item.imageVO.equals( vo ) ) return Item ( _items[i] );
			}
			return null;
		}
				
		protected function onItemSelected ( event : ItemEvent ) : void
		{
			if ( _selectedItem == null )
			{ 
				_selectedItem = event.item;
				dispatchEvent( new Event ( "onItemClick" ) );
				
			} else {
			
				if ( _selectedItem == event.item ) dispatchEvent( new Event ( "onSelectedItemClick" ) );
				else dispatchEvent( new Event ( "onItemClick" ) );
			
				_selectedItem = event.item
			}
			display();
		}
	}
}



