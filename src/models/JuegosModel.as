/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 08/10/12
 * Time: 16:54
 * To change this template use File | Settings | File Templates.
 */
package models {
import org.robotlegs.mvcs.Actor;

public class JuegosModel extends Actor implements IJuegosModel{



    private var juegos:Array;
    private var juegoActual:Object = new Object();



    public function JuegosModel()
    {
        super();
        this.juegos = new Array();
        this.juegos = [

            {
                ruta: 'juegos/juego1.swf',
                puntos: 'suficiente'
            },

            {
                ruta: 'juegos/juego2.swf',
                puntos: 'insuficiente'
            },

            {
                ruta: 'juegos/juego3.swf',
                puntos: 'notable'
            }

        ];
    }


    public function setJuegoActual(_data:uint):void
    {
        juegoActual = juegos[_data];
    }


    public function getJuegoActual():Object
    {
        return juegoActual;
    }


    // GETTER's

    public function getJuegos():Array {
        return juegos;
    }

    public function setJuegos(_data:Array):void {
        juegos = _data;
    }

}
}
