package uk.co.ziazoo.snappyviewer.view
{
	import mx.collections.ArrayCollection;
	
	public interface IItemView
	{
		function set itemDisplayer ( itemDisplayer : IItemDisplayer ) : void;
				
		function set dataProvider ( value : ArrayCollection ) : void;
		
		function get dataProvider () : ArrayCollection;

	}
}