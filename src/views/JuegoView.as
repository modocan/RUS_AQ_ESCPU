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

    public function JuegoView() {
        super();
        _this = this;
        _this.addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event):void
    {
        _this.removeEventListener(Event.ADDED_TO_STAGE, init);

        var cargador:Loader = new Loader();
        cargador.contentLoaderInfo.addEventListener(Event.COMPLETE, cargaOK);
        cargador.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, cargaKO);
        cargador.load(new URLRequest('juegos/juego3.swf'));
    }

    private function cargaKO(e:IOErrorEvent):void {


        MonsterDebugger.trace(this, 'ERROR CARGA');
        MonsterDebugger.trace(this, e);

    }

    private function cargaOK(e:Event):void {

        var _clip:MovieClip = MovieClip(e.currentTarget.content);
        e.currentTarget.content.addEventListener(JuegoEvent.JUEGO_CARGADO, comu);
        _this.addChild(e.currentTarget.content);

        function comu(e:JuegoEvent):void
        {
            var keko:MunecoView = new MunecoView();
            keko.addEventListener(Event.ADDED_TO_STAGE, initKeko);
            _clip.addChild(keko);

        }


        function initKeko(e:Event):void
        {
            e.currentTarget.removeEventListener(Event.ADDED_TO_STAGE, initKeko);
            MunecoView(e.currentTarget).config('1');
        }

    }
}
}
