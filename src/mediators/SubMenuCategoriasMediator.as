package mediators
{
import com.demonsters.debugger.MonsterDebugger;
import com.hexagonstar.util.debug.Debug;
	
	import org.robotlegs.mvcs.Mediator;
	
	import views.SubMenuCategoriasView;
	import events.ConfiguradorEvent;
	
	public class SubMenuCategoriasMediator extends Mediator {
		
		[Inject]
		public var vista:SubMenuCategoriasView;
		
		public function SubMenuCategoriasMediator() {
			super();
		}
		
		override public function onRegister():void
		{
			eventMap.mapListener(eventDispatcher, ConfiguradorEvent.PINTAR_MENUS, mostrarSubMenuCategorias);
			eventMap.mapListener(eventDispatcher, ConfiguradorEvent.ELEMENTOS_CARGADOS, pasarElementos);
			eventMap.mapListener(vista, ConfiguradorEvent.CLICK_EN_ELEMENTO, clickEnElemento);
			eventMap.mapListener(eventDispatcher, ConfiguradorEvent.CLICK_EN_CATEGORIA, clickEnCategoria);
			eventMap.mapListener(eventDispatcher, ConfiguradorEvent.VOLVER, volver);
		}
		
		private function mostrarSubMenuCategorias(e:ConfiguradorEvent):void{
			Debug.trace('detectoEvento submenu');
			vista.entrar();
		}
		
		private function pasarElementos(e:ConfiguradorEvent):void{
			Debug.trace('llamo a vista.cargarSubmenu');
			vista.cargarSubmenu(e.datos);
		}
		
		private function clickEnElemento(e:ConfiguradorEvent):void{
			var evento:ConfiguradorEvent = new ConfiguradorEvent(ConfiguradorEvent.CLICK_EN_ELEMENTO);
			evento.datos = e.datos;

            MonsterDebugger.trace(this, '[ELEMENTO ELEGIDO]');
            MonsterDebugger.trace(this, evento.datos);

			eventDispatcher.dispatchEvent(evento);
		}
		
		private function clickEnCategoria(e:ConfiguradorEvent):void{
			vista.pintarElementos(e.datos);
		}
		
		private function volver(e:ConfiguradorEvent):void{
			vista.borrar();
		}
		
		
	}
}