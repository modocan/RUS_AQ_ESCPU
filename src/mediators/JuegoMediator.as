/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 25/09/12
 * Time: 12:28
 * To change this template use File | Settings | File Templates.
 */
package mediators {
import events.ConfiguradorEvent;
import events.JuegoEvent;

import org.robotlegs.mvcs.Mediator;

import views.JuegoView;

public class JuegoMediator extends Mediator{

    [Inject]
    public var vista:JuegoView;

    public function JuegoMediator() {
        super();
    }


    override public function onRegister():void
    {
        eventMap.mapListener(vista,  JuegoEvent.SET_PUNTUACION, setPuntuacion);
        eventMap.mapListener(vista,  ConfiguradorEvent.ELIMINA_PRECARGA, eliminaPrecarga);
        eventMap.mapListener(vista,  ConfiguradorEvent.PROGRESO_CARGA, progresoCarga);
    }

    private function progresoCarga(e:ConfiguradorEvent):void
    {
        var evento:ConfiguradorEvent = new ConfiguradorEvent(ConfiguradorEvent.PROGRESO_CARGA);
        evento.datos = e.datos;
        eventDispatcher.dispatchEvent(evento);
    }

    private function eliminaPrecarga(e:ConfiguradorEvent):void
    {
        eventDispatcher.dispatchEvent(new ConfiguradorEvent(ConfiguradorEvent.ELIMINA_PRECARGA));
    }

    private function setPuntuacion(e:JuegoEvent):void
    {
        var evento:JuegoEvent = new JuegoEvent(JuegoEvent.SET_PUNTUACION);
        evento.datos = e.datos;
        eventDispatcher.dispatchEvent(evento);
    }

}
}
