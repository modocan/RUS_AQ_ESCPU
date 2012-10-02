package views
{
	import com.hexagonstar.util.debug.Debug;
	
	import flash.events.Event;
	import flash.display.MovieClip;
	
	public class AmigoView extends MovieClip
	{
		private var _this:AmigoView;
		
		public function AmigoView()
		{
			_this = this;
			_this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			Debug.trace('init AmigoView');
			_this.removeEventListener(Event.ADDED_TO_STAGE, init);
		}
	}
}