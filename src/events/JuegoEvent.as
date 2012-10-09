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

    public static const SELECCION_JUEGO:String = 'JuegoEvent.SELECCION_JUEGO';
    public static const JUEGO_CARGADO:String = 'JuegoEvent.JUEGO_CARGADO';
    public static const JUEGO_ACABADO:String = 'JuegoEvent.JUEGO_ACABADO';

    private var _datos:Object = new Object();

    public function JuegoEvent(tipo:String)
    {
        super(tipo);
    }

    public function get datos():Object {
        return _datos;
    }

    public function set datos(value:Object):void {
        _datos = value;
    }
}
}
