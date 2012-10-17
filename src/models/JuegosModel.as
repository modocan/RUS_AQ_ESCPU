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
    private var posJuegoActual:uint = 0;



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



    public function parseaNota(_nota:String):Number
    {
        var resp:Number = 0;

        switch (_nota)
        {
            case 'muy_deficiente':
                    resp = 0;
                break;

            case '0':
                resp = 0;
                break;

            case 'insuficiente':
                resp = 1;
                break;

            case 'suficiente':
                resp = 2;
                break;

            case 'bien':
                resp = 3;
                break;

            case 'notable':
                resp = 4;
                break;

            case 'sobresaliente':
                resp = 5;
                break;
        }

        return resp;
    }


    public function getPosJuegoActual():uint
    {
        return posJuegoActual;
    }



    public function setJuegoActual(_data:uint):void
    {
        juegoActual = juegos[_data];
        posJuegoActual = _data;
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
