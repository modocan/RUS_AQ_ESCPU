/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 08/10/12
 * Time: 16:51
 * To change this template use File | Settings | File Templates.
 */
package mediators {
import events.JuegoEvent;

import org.robotlegs.mvcs.Mediator;

import views.SeleccionJuegosView;

public class SeleccionJuegosMediator extends Mediator{

    [Inject]
    public var vista:SeleccionJuegosView;

    public function SeleccionJuegosMediator()
    {
        super();
    }


    override public function onRegister():void
    {
        eventMap.mapListener(vista, JuegoEvent.SELECCION_JUEGO, seleccionJuego);
    }


    private function seleccionJuego(e:JuegoEvent):void
    {
        trace('recibo evento');
        var evento:JuegoEvent = new JuegoEvent(JuegoEvent.SELECCION_JUEGO);
         evento.datos = e.datos;
         eventDispatcher.dispatchEvent(evento);
    }

}
}
