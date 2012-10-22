/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 25/09/12
 * Time: 12:24
 * To change this template use File | Settings | File Templates.
 */
package views {
import com.demonsters.debugger.MonsterDebugger;
import com.greensock.TweenMax;

import events.ConfiguradorEvent;

import events.Juego1Event;

import events.JuegoEvent;

import flash.display.DisplayObject;

import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Sprite;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.net.URLRequest;

import views.MunecoView;

public class JuegoView extends Sprite {

    private var _this:JuegoView;
    private var ruta:String;
    private var ropa:Object = new Object();

    public function JuegoView(_ruta:String, _ropa:Array) {
        super();
        _this = this;
        ruta = _ruta;
        ropa = _ropa;

        MonsterDebugger.trace(this, 'JUEGOVIEW');
        MonsterDebugger.trace(this, ropa);

        _this.addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event):void
    {
        _this.removeEventListener(Event.ADDED_TO_STAGE, init);

        // TODO crear precarga

        var cargador:Loader = new Loader();
        cargador.contentLoaderInfo.addEventListener(Event.COMPLETE, cargaOK);
        cargador.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progresoCarga);
        cargador.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, cargaKO);
        cargador.load(new URLRequest(_this.ruta));
        _this.addChild(cargador);
    }

    private function progresoCarga(e:ProgressEvent):void
    {
        var evento:ConfiguradorEvent = new ConfiguradorEvent(ConfiguradorEvent.PROGRESO_CARGA);
        evento.datos = Math.ceil((Number(e.currentTarget.bytesLoaded) * 100)/Number(e.currentTarget.bytesTotal));
        _this.dispatchEvent(evento);
    }

    private function cargaKO(e:IOErrorEvent):void
    {

        MonsterDebugger.trace(this, 'ERROR CARGA');
        MonsterDebugger.trace(this, e);

    }

    private function cargaOK(e:Event):void {
        MonsterDebugger.trace(this, '[CARGADO]');
        _this.dispatchEvent(new ConfiguradorEvent(ConfiguradorEvent.ELIMINA_PRECARGA));
        //MovieClip(e.currentTarget.content).ropa = ropa;
        MovieClip(e.currentTarget.content).setRopa(ropa);
        MovieClip(e.currentTarget.content).addEventListener(JuegoEvent.JUEGO_ACABADO, juegoAcabado);
        // TODO quitar precarga



    }

    private function juegoAcabado(e:JuegoEvent):void
    {
        MovieClip(e.currentTarget).removeEventListener(JuegoEvent.JUEGO_ACABADO, juegoAcabado);



        var _punt:String = e.datos as String;

        var fondoBlanco:Sprite = new Sprite();
        fondoBlanco.graphics.beginFill(0xFFFFFF, 0.7);
        fondoBlanco.graphics.drawRect(0, 0, _this.width, _this.height);
        fondoBlanco.graphics.endFill();
        fondoBlanco.alpha = 0;
        fondoBlanco.addEventListener(Event.ADDED_TO_STAGE, initFondo);
        addChild(fondoBlanco);

        function initFondo(e:Event):void
        {
            fondoBlanco.removeEventListener(Event.ADDED_TO_STAGE, initFondo);

            TweenMax.to(fondoBlanco, 0.5, {alpha: 1, onComplete: function(){

                var fin:FinJuegoView = new FinJuegoView(_punt);
                fin.x = _this.width/2;
                fin.y = _this.height/2;
                fin.scaleX = fin.scaleY = fin.alpha = 0;
                fin.addEventListener(Event.ADDED_TO_STAGE, initFin);
                addChild(fin);

            }});


        }

        var evento:JuegoEvent = new JuegoEvent(JuegoEvent.SET_PUNTUACION);
        evento.datos = _punt;
        _this.dispatchEvent(evento);

    }

    private function initFin(e:Event):void
    {
        Sprite(e.currentTarget).removeEventListener(Event.ADDED_TO_STAGE, initFin);

        TweenMax.to(Sprite(e.currentTarget), 0.5, {alpha: 1, scaleX: 1, scaleY: 1});
    }
}
}
