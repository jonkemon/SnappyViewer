package uk.co.ziazoo.snappyviewer.view.imageViewer
{
	import caurina.transitions.Tweener;
	
	import mx.collections.ArrayCollection;
	
	import uk.co.ziazoo.snappyviewer.data.IItem;
	import uk.co.ziazoo.snappyviewer.view.IItemDisplayer;

	public class SlideItemDisplayer implements IItemDisplayer
	{
		private var _selectedIndex : Number;
		private var _items : ArrayCollection;
		
		private var _itemWidth : Number = 800;
		private var _itemHeight : Number = 600;
		private var _scaledWidth : Number;
		private var _scaledHeight : Number;
		
		public function SlideItemDisplayer( )
		{
			super();
		}

		public function display(items:ArrayCollection , unscaledWidth:Number, unscaledHeight:Number , selectedItem : IItem ):void
		{
			_items = items;
			var index : int = _items.getItemIndex( selectedItem ) 
			_selectedIndex = index == -1 ? 0 : index;
			
			_scaledWidth = 0.5 * unscaledWidth;
			_scaledHeight = ( _scaledWidth / _itemWidth ) * _itemHeight;
			
			for ( var i : int = 0 ; i < items.length ; i++ )
			{
				var item : Item = items.getItemAt( i ) as Item;
				placeItem( item , i );
				sizeItem ( item );			
			}
		}
		
		private function placeItem ( item : Item , index : int ) : void
		{	
			var width : Number = _scaledWidth + ( 0.05 * _scaledWidth );
			var deltaIndex : Number = index - _selectedIndex
			
			var xPos : Number = deltaIndex * width + ( 0.50 * _scaledWidth );
			var yPos : Number = 0;
			
			Tweener.addTween( item , { x : xPos , y: yPos , alpha : 1 , time : 1 } );
		}
		
		private function sizeItem ( item : Item ) : void
		{
			Tweener.addTween( item , { height : _scaledHeight , width: _scaledWidth , alpha : 1 , time : 1 } );
		}
	}
}