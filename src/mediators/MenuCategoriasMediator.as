package mediators
{
	import com.hexagonstar.util.debug.Debug;
	
	import events.ConfiguradorEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import views.MenuCategoriasView;
	
	public class MenuCategoriasMediator extends Mediator {
		
		[Inject]
		public var vista:MenuCategoriasView;
		
		public function MenuCategoriasMediator() {
			super();
		}
		
		override public function onRegister():void
		{
			eventMap.mapListener(eventDispatcher, ConfiguradorEvent.PINTAR_MENUS, mostrarMenuCategorias);
			eventMap.mapListener(eventDispatcher, ConfiguradorEvent.VOLVER, volver);
			eventMap.mapListener(vista, ConfiguradorEvent.CLICK_EN_CATEGORIA, clickEnCategoria);
		}
		
		private function mostrarMenuCategorias(e:ConfiguradorEvent):void{
			Debug.trace('detectoEvento');
			vista.entrar();
		}
		
		private function volver(e:ConfiguradorEvent):void{
			vista.borrar();
		}
		
		private function clickEnCategoria(e:ConfiguradorEvent):void{
			var evento:ConfiguradorEvent = new ConfiguradorEvent(ConfiguradorEvent.CLICK_EN_CATEGORIA);
			evento.datos = e.datos;
			eventDispatcher.dispatchEvent(evento);
		}
		
	}
}