/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 20/09/12
 * Time: 18:31
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.events.Event;

public class Juego1Event extends Event{

    public static const JUEGO_CREADO:String = 'Juego1Event.JUEGO_CREADO';

    public function Juego1Event(tipo:String) {
        super(tipo);
    }
}
}
