/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 25/09/12
 * Time: 12:25
 * To change this template use File | Settings | File Templates.
 */
package events {
import flash.events.Event;

public class JuegoEvent extends Event {

    public static const JUEGO_CARGADO:String = 'JuegoEvent.JUEGO_CARGADO';

    public function JuegoEvent(tipo:String)
    {
        super(tipo);
    }
}
}
