/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 02/10/12
 * Time: 12:40
 * To change this template use File | Settings | File Templates.
 */
package assets.juego1 {
import flash.display.MovieClip;

public class HuevoClase extends MovieClip{

    public var _visible=true;

    public function HuevoClase() {
    }

    public function chocarYromper(){
        gotoAndStop('roto');
    }
    public function desaparecioHuevo(){
        Debug.trace('-----------------  Desaparecio huevo! ---------------');
        _visible=false;
    }
}
}
