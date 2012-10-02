package mediators
{
	import com.hexagonstar.util.debug.Debug;

import models.IAvatarModel;

import org.robotlegs.mvcs.Mediator;
		
	import events.ConfiguradorEvent;
	import views.MunecoView;
	
	public class MunecoMediator extends Mediator {
		
		[Inject]
		public var vista:MunecoView;

        [Inject]
        public var avatar:IAvatarModel;
		
		public function MunecoMediator() {
			super();
		}
		
		override public function onRegister():void
		{
			eventMap.mapListener(eventDispatcher, ConfiguradorEvent.SEXO, sexoSeleccionado);
			eventMap.mapListener(eventDispatcher, ConfiguradorEvent.VOLVER, volver);
			eventMap.mapListener(eventDispatcher, ConfiguradorEvent.CLICK_EN_ELEMENTO, colocarElemento);
		}
		private function sexoSeleccionado(e:ConfiguradorEvent):void{
            vista.sexoActual = avatar.getSexo();
			vista.config(e.datos.sexo);

		}
		
		private function volver(e:ConfiguradorEvent):void{
			vista.volver();
		}
		
		private function colocarElemento(e:ConfiguradorEvent):void{
			
			if(vista.visible == true){
				Debug.trace('llego al mediator de muñeco: '+e.datos.name);
				vista.vestirMuneco(e.datos);
			}
				
		}
		
	}
}