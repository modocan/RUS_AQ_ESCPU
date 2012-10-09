/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 06/10/12
 * Time: 17:24
 * To change this template use File | Settings | File Templates.
 */
package {
import flash.events.Event;

public class Juego3Event extends Event{

    public static const ITEM_RESET:String = 'Juego3Event.ITEM_RESET';
    public static const ITEM_PULSADO:String = 'Juego3Event.ITEM_PULSADO';
    public static const ITEM_HIT_OLLA:String = 'Juego3Event.ITEM_HIT_OLLA';

    public function Juego3Event(tipo:String)
    {
        super(tipo);
    }
}
}
