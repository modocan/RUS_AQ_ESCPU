package mediators
{
	import com.hexagonstar.util.debug.Debug;
	
	import org.robotlegs.mvcs.Mediator;
	
	import views.InterfazView;
	import events.ConfiguradorEvent;
	
	public class InterfazMediator extends Mediator {
		
		[Inject]
		public var vista:InterfazView;
		
		public function InterfazMediator() {
			super();
		}
		
		override public function onRegister():void
		{
			
		}
		
		
	}
}