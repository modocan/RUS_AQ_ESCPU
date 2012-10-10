/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 10/10/12
 * Time: 01:36
 * To change this template use File | Settings | File Templates.
 */
package views {
import com.greensock.TweenMax;

import events.JuegoEvent;

import flash.display.MovieClip;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.external.ExternalInterface;

public class FinJuegoView extends Sprite {

    private var _this:FinJuegoView;

    private var puntuacion:String;
    private var finJuego:FinJuego;

    public function FinJuegoView(_puntuacion:String)
    {
        super();
        _this = this;
        puntuacion = _puntuacion;

        _this.addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event):void
    {
        _this.removeEventListener(Event.ADDED_TO_STAGE, init);

        finJuego = new FinJuego();

        for(var i:uint = 0; i < finJuego.numChildren; i++)
        {
            if(finJuego.getChildAt(i) is MovieClip && finJuego.getChildAt(i).name != 'compartir' && finJuego.getChildAt(i).name != 'continuar' && finJuego.getChildAt(i).name != 'madera')
            {
                MovieClip(finJuego.getChildAt(i)).visible = false;
            }

        }

        MovieClip(finJuego.getChildByName('compartir')).buttonMode = true;
        MovieClip(finJuego.getChildByName('compartir')).addEventListener(MouseEvent.CLICK, compartiJuego);

        MovieClip(finJuego.getChildByName('continuar')).buttonMode = true;
        MovieClip(finJuego.getChildByName('continuar')).addEventListener(MouseEvent.CLICK, clicVolver);

        finJuego.addEventListener(Event.ADDED_TO_STAGE, initClip);
        addChild(finJuego);
    }

    private function compartiJuego(e:MouseEvent):void
    {
        ExternalInterface.call('compartirJuego');
    }

    private function clicVolver(e:MouseEvent):void
    {
        MovieClip(e.currentTarget).removeEventListener(MouseEvent.CLICK, clicVolver);

        _this.dispatchEvent(new JuegoEvent(JuegoEvent.VOLVER));
    }

    private function initClip(e:Event):void
    {
        finJuego.removeEventListener(Event.ADDED_TO_STAGE, initClip);

        MovieClip(finJuego.getChildByName(puntuacion)).alpha = 0;
        MovieClip(finJuego.getChildByName(puntuacion)).scaleX = 0;
        MovieClip(finJuego.getChildByName(puntuacion)).scaleY = 0;
        MovieClip(finJuego.getChildByName(puntuacion)).visible = true;

        TweenMax.to(MovieClip(finJuego.getChildByName(puntuacion)), 0.5, {alpha: 1, scaleX: 1, scaleY: 1});
    }



}
}
