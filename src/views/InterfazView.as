package views
{
	import com.hexagonstar.util.debug.Debug;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class InterfazView extends MovieClip
	{
		private var _this:InterfazView;
		private var _interfaz:Interfaz_mc;
		
		public function InterfazView()
		{
			_this = this;
			_this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			Debug.trace('init InterfazView');
			_this.removeEventListener(Event.ADDED_TO_STAGE, init);
			config();
		}
		
		private function config():void{
			_interfaz = new Interfaz_mc();
			this.addChild(_interfaz);
			
			this.addChild(new AmigosListView());
		}
		
	}
}