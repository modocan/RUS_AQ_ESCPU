package mediators
{
import com.demonsters.debugger.MonsterDebugger;
import com.hexagonstar.util.debug.Debug;
	
	import org.robotlegs.mvcs.Mediator;
		
	import events.ConfiguradorEvent;
	import views.PersonajesView;
	
	public class PersonajesMediator extends Mediator {
		
		[Inject]
		public var vista:PersonajesView;
		
		public function PersonajesMediator() {
			super();
		}
		
		override public function onRegister():void
		{
			eventMap.mapListener(vista, ConfiguradorEvent.SEXO, sexoSeleccionado);
			eventMap.mapListener(eventDispatcher, ConfiguradorEvent.VOLVER, volver);
		}
		
		private function sexoSeleccionado(e:ConfiguradorEvent):void{

			var evento:ConfiguradorEvent = new ConfiguradorEvent(ConfiguradorEvent.SEXO);
			evento.datos.sexo = e.datos.sexo;
			eventDispatcher.dispatchEvent(evento);
			eventDispatcher.dispatchEvent(new ConfiguradorEvent(ConfiguradorEvent.PINTAR_MENUS));

		}
		
		private function volver(e:ConfiguradorEvent):void{
			vista.entrar();
		}
		
	}
}