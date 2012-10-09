/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 25/09/12
 * Time: 12:24
 * To change this template use File | Settings | File Templates.
 */
package views {
import com.demonsters.debugger.MonsterDebugger;

import events.JuegoEvent;

import flash.display.DisplayObject;

import flash.display.Loader;
import flash.display.MovieClip;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLRequest;

import views.MunecoView;

public class JuegoView extends Sprite {

    private var _this:JuegoView;
    private var ruta:String;

    public function JuegoView(_ruta:String) {
        super();
        _this = this;
        ruta = _ruta;
        _this.addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event):void
    {
        _this.removeEventListener(Event.ADDED_TO_STAGE, init);

        // TODO crear precarga

        var cargador:Loader = new Loader();
        cargador.contentLoaderInfo.addEventListener(Event.COMPLETE, cargaOK);
        cargador.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, cargaKO);
        cargador.load(new URLRequest(_this.ruta));
        _this.addChild(cargador);
    }

    private function cargaKO(e:IOErrorEvent):void
    {

        MonsterDebugger.trace(this, 'ERROR CARGA');
        MonsterDebugger.trace(this, e);

    }

    private function cargaOK(e:Event):void {
        MonsterDebugger.trace(this, '[CARGADO]');

        MovieClip(e.currentTarget.content).addEventListener(JuegoEvent.JUEGO_ACABADO, juegoAcabado);
        // TODO quitar precarga



    }

    private function juegoAcabado(e:JuegoEvent):void
    {
        MovieClip(e.currentTarget).removeEventListener(JuegoEvent.JUEGO_ACABADO, juegoAcabado);

        MonsterDebugger.trace(this, '[JUEGO ACABADO]');
    }
}
}
