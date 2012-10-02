package views
{
	import com.hexagonstar.util.debug.Debug;
	
	import flash.events.Event;
	import flash.display.MovieClip;
	
	public class FooterView extends MovieClip
	{
		private var _this:FooterView;
		
		public function FooterView()
		{
			_this = this;
			_this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			Debug.trace('init FooterView');
			_this.removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		
	}
}