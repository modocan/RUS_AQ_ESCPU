package mediators
{
	import com.hexagonstar.util.debug.Debug;
	
	import org.robotlegs.mvcs.Mediator;
	
	import views.BtnFinView;
	import events.ConfiguradorEvent;
	
	public class BtnFinMediator extends Mediator {
		
		[Inject]
		public var vista:BtnFinView;
		
		public function BtnFinMediator() {
			super();
		}
		
		override public function onRegister():void
		{
            eventMap.mapListener(vista, ConfiguradorEvent.GUARDAR_AVATAR, guardar);
			eventMap.mapListener(eventDispatcher, ConfiguradorEvent.PINTAR_MENUS, mostrarBtnFin);
			eventMap.mapListener(eventDispatcher, ConfiguradorEvent.VOLVER, volver);
		}

        private function guardar(e:ConfiguradorEvent):void
        {
            eventDispatcher.dispatchEvent(new ConfiguradorEvent(ConfiguradorEvent.GUARDAR_AVATAR));
        }
		
		private function mostrarBtnFin(e:ConfiguradorEvent):void{
			vista.entrar();
		}
		
		private function volver(e:ConfiguradorEvent):void{
			vista.borrar();
		}
		
		
	}
}