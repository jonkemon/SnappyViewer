package uk.co.ziazoo.snappyviewer.view.imageViewer
{
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	import uk.co.ziazoo.snappyviewer.data.IItem;
	import uk.co.ziazoo.snappyviewer.events.ItemEvent;
	import uk.co.ziazoo.snappyviewer.vo.ImageVO;

	public class Item extends Sprite implements IItem
	{
		private var _imageVO : ImageVO;
		private var _loader : Loader;
		private var _preloader : Shape;
		
		public function Item( imageVO : ImageVO )
		{
			super();
			_imageVO = imageVO;
			createDisplay();
			addListeners();
			useHandCursor = true;
			buttonMode = true;
		}
		
		private function createDisplay () : void
		{
			_preloader = new Shape();
			addChild( _preloader );
			 
			drawBackground();
			
			  _loader = new Loader();
            configureListeners( _loader.contentLoaderInfo );
            
            var request : URLRequest = new URLRequest( "assets/images/" + _imageVO.url );
            _loader.load( request );

            addChild( _loader );
		}
		
		private function drawBackground () : void
		{
			graphics.lineStyle( 1 , 0x999999 );
			graphics.beginFill( 0xFFFFFF , 1 );
			graphics.drawRect( 0 , 0, 160 , 120 );
			graphics.endFill();
		}

        private function configureListeners( dispatcher : IEventDispatcher ) : void 
        {
            dispatcher.addEventListener(Event.COMPLETE, completeHandler);
            dispatcher.addEventListener(Event.INIT, initHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
        }
        
        private function addListeners (): void
        {
        	addEventListener( MouseEvent.CLICK , onMouseClick ); 
        }
        
        private function onMouseClick ( event : MouseEvent ) : void
        {
        	dispatchEvent( new ItemEvent ( ItemEvent.SELECT , this , true ) );
        }
        
        private function completeHandler(event:Event):void 
        {
        }

        private function initHandler(event:Event):void 
        {
        	_loader.width = 160;
        	_loader.height = 120;        	
        }

        private function ioErrorHandler(event:IOErrorEvent):void 
        {
        }

        private function progressHandler(event:ProgressEvent):void 
        {
        	var w : Number = ( event.bytesLoaded / event.bytesTotal ) * 160;
       	
        	_preloader.graphics.clear();
        	_preloader.graphics.lineStyle( 0 , 0x999999 );
			_preloader.graphics.beginFill( 0x999999 , 1 );
			_preloader.graphics.drawRect( 0 , 0, w , 5 );
			_preloader.graphics.endFill();
        }
		
		public function get imageVO () : ImageVO
		{
			return _imageVO;
		}
		
		override public function toString():String
		{
			return _imageVO.url + " , " + _imageVO.date;
		}
	}
}