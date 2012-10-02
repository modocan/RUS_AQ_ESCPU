package views
{
	import com.hexagonstar.util.debug.Debug;
	
	import flash.events.Event;
	import flash.display.MovieClip;
	
	public class ElementoView extends MovieClip
	{
		private var _this:ElementoView;
		
		public function ElementoView()
		{
			_this = this;
			_this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			Debug.trace('init ElementoView');
			_this.removeEventListener(Event.ADDED_TO_STAGE, init);
		}
	}
}