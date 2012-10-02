package mediators
{
	import com.hexagonstar.util.debug.Debug;
	
	import events.ConfiguradorEvent;
	
	import flash.events.EventDispatcher;
	
	import org.robotlegs.mvcs.Mediator;
	
	import views.AmigosListView;

	public class AmigosListMediator extends Mediator{
		
		[Inject]
		public var vista:AmigosListView;
		
		public function AmigosListMediator(){
			super();
			
		}
		
		override public function onRegister():void{
			eventMap.mapListener(eventDispatcher, ConfiguradorEvent.AMIGOS_QUE_JUGARON, pintarAmigos);
		}
		
		public function pintarAmigos(e:ConfiguradorEvent):void{
			Debug.trace('llego al puto mediator con: '+e.datos);
			vista.pintarAmigos(e.datos.amigosQueJugaron,e.datos.todosLosAmigos);
		}
		
		
		
	}
}