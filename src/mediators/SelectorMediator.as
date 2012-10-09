/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 09/10/12
 * Time: 00:57
 * To change this template use File | Settings | File Templates.
 */
package mediators {
import events.JuegoEvent;

import org.robotlegs.mvcs.Mediator;

import views.SelectorView;

public class SelectorMediator extends Mediator{

    [Inject]
    public var vista:SelectorView;

    public function SelectorMediator()
    {
        super();
        trace('super');
    }


    override public function onRegister():void
    {
        trace('registro');
        eventMap.mapListener(vista, JuegoEvent.SELECCION_JUEGO, seleccionJuego);
    }

    private function seleccionJuego(e:JuegoEvent):void
    {
        trace('recibo evento');
        /*var evento:JuegoEvent = new JuegoEvent(JuegoEvent.SELECCION_JUEGO);
        evento.datos = e.datos;
        eventDispatcher.dispatchEvent(evento);*/
    }


}
}
