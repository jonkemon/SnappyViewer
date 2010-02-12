package uk.co.ziazoo.snappyviewer.view.imageViewer
{
	import caurina.transitions.Tweener;
	
	import mx.collections.ArrayCollection;
	
	import uk.co.ziazoo.snappyviewer.data.IItem;
	import uk.co.ziazoo.snappyviewer.view.IItemDisplayer;

	public class GridItemDisplayer implements IItemDisplayer
	{	
		private var _colNum : Number;
		private var _rowNum : Number;
		private var _padding : Number;
		private var _itemWidth : Number;
		private var _itemHeight : Number;
		
		public function GridItemDisplayer( rowNum : Number , colNum : Number , padding : Number = 0 )
		{
			super();
			_rowNum = rowNum;
			_colNum = colNum;
			_padding = padding;
		}
		
		public function display( items : ArrayCollection , unscaledWidth:Number, unscaledHeight:Number , selectedItem : IItem ) : void 
		{				
			var spaceWidth : Number = 0.6 * ( unscaledWidth );
			
			_itemWidth = spaceWidth / _colNum; 
			_itemWidth -= (_colNum - 1 ) * _padding;
			_itemHeight = ( _itemWidth / 800 ) * 600;
			
			for ( var i : int = 0 ; i < items.length ; i++ )
			{
				var item : Item = items.getItemAt( i ) as Item;
				placeItem( item , i , unscaledWidth );
				sizeItem( item );		
			}
		}
		
		private function placeItem ( item : Item , index : int , unscaledWidth : Number ) : void
		{			
			// i and j are the grid components of the item
			var i : int = index % _rowNum;
			var j : int = index / _rowNum;
			
			// determine the positions of the grid items
			var xPos : Number = i * _itemWidth + ( _padding * i ) + ( 0.1 * unscaledWidth );
			var yPos : Number = j * _itemHeight + ( _padding * j );
			
			// animate the items into position
			Tweener.addTween( item , { x : xPos , y: yPos , alpha : 1 , time : ( index / 10 ) + 0.5 } );
			
		}
		
		private function sizeItem ( item : Item ) : void
		{
			Tweener.addTween( item , { height : _itemHeight , width: _itemWidth , alpha : 1 , time : 1 } );
		}
		
	}
}