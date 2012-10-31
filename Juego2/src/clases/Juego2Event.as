/**
 * Created with IntelliJ IDEA.
 * User: rubenmorato
 * Date: 20/09/12
 * Time: 18:31
 * To change this template use File | Settings | File Templates.
 */
package clases {

    import flash.events.Event;

    public class Juego2Event extends Event{

        public static const JUEGO_CREADO:String = 'JUEGO_CREADO';
        public static const PUNTO:String = 'PUNTO';
        public static const QUITAR_PUNTO:String = 'QUITAR_PUNTO';

        public function Juego2Event(tipo:String) {
            super(tipo);
        }
    }
}
