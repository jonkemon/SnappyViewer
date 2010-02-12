package uk.co.ziazoo.snappyviewer.view
{
	import mx.collections.ArrayCollection;
	
	import uk.co.ziazoo.snappyviewer.data.IItem;
	
	public interface IItemDisplayer
	{
		function display( items : ArrayCollection , unscaledWidth:Number, unscaledHeight:Number , selectedItem : IItem ) : void;
	}
}