package mediators
{
	
	import events.ConfiguradorEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import views.MainView;
	
	public class MainMediator extends Mediator {
		
		[Inject]
		public var vista:MainView;
		
		public function MainMediator() {
			super();
		}
		
		override public function onRegister():void
		{
			/*
			eventMap.mapListener(eventDispatcher, MenuEvent.PINTA_MENU, pintaMenu);
			eventMap.mapListener(eventDispatcher, ControlEvent.LOADER_LOGIN, pintaLoaderLogin);
			eventMap.mapListener(eventDispatcher, ControlEvent.FIN_LOADER_LOGIN, borraLoaderLogin);
			eventMap.mapListener(eventDispatcher, SpotEvent.ESTADO_PLAY, oculta);
			eventMap.mapListener(eventDispatcher, SpotEvent.ESTADO_STOP, muestrate);
			*/
			
			//eventDispatcher.dispatchEvent(new ConfiguradorEvent(ConfiguradorEvent.CARGAR_AMIGOS));
            eventMap.mapListener(eventDispatcher, ConfiguradorEvent.ACTIVA_FINALIZAR, activaFinalizar);
            eventMap.mapListener(vista, ConfiguradorEvent.GUARDAR_AVATAR, guardar);
            eventMap.mapListener(vista, ConfiguradorEvent.COMPARTIR_AVATAR, compartirAvatar);
		}

        private function compartirAvatar(e:ConfiguradorEvent):void
        {
            var evento:ConfiguradorEvent = new ConfiguradorEvent(ConfiguradorEvent.COMPARTIR_AVATAR);
            evento.datos = e.datos;
            eventDispatcher.dispatchEvent(evento);
        }


        private function activaFinalizar(e:ConfiguradorEvent):void
        {
            vista.activaFinalizar();
        }

        private function guardar(e:ConfiguradorEvent):void
        {
            eventDispatcher.dispatchEvent(new ConfiguradorEvent(ConfiguradorEvent.GUARDAR_AVATAR));
        }
		
		
	}
}