package mediators
{
	import com.hexagonstar.util.debug.Debug;
	
	import org.robotlegs.mvcs.Mediator;
	
	import views.BtnVolverView;
	import events.ConfiguradorEvent;
	
	public class BtnVolverMediator extends Mediator {
		
		[Inject]
		public var vista:BtnVolverView;
		
		public function BtnVolverMediator() {
			super();
		}
		
		override public function onRegister():void
		{
			eventMap.mapListener(eventDispatcher, ConfiguradorEvent.PINTAR_MENUS, mostrarBtnVolver);
			eventMap.mapListener(vista, ConfiguradorEvent.VOLVER, volver);
		}
		
		private function mostrarBtnVolver(e:ConfiguradorEvent):void{
			vista.entrar();
		}
		
		private function volver(e:ConfiguradorEvent):void{
			eventDispatcher.dispatchEvent(new ConfiguradorEvent(ConfiguradorEvent.VOLVER));
			vista.borrar();
		}
		
		
	}
}