package views
{
	import com.hexagonstar.util.debug.Debug;
	
	import flash.events.Event;
	import flash.display.MovieClip;
	
	public class CategoriaView extends MovieClip
	{
		private var _this:CategoriaView;
		
		public function CategoriaView()
		{
			_this = this;
			_this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			Debug.trace('init CategoriaView');
			_this.removeEventListener(Event.ADDED_TO_STAGE, init);
		}
	}
}