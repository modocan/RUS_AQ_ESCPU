/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 08/10/12
 * Time: 16:50
 * To change this template use File | Settings | File Templates.
 */
package views {
import com.demonsters.debugger.MonsterDebugger;

import events.JuegoEvent;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import views.SelectorView;

import views.SelectorView;

import views.SelectorView;

import views.SelectorView;

import views.SelectorView;

public class SeleccionJuegosView extends Sprite{

    private var _this:SeleccionJuegosView;
    private var _clip:SeleccionPantalla;
    private var puntuaciones:Array;

    public function SeleccionJuegosView(_puntuaciones:Array)
    {
        super();
        _this = this;

        puntuaciones = new Array();
        puntuaciones = _puntuaciones;

        MonsterDebugger.trace(this, '[PUNTUACIONES]');
        MonsterDebugger.trace(this, puntuaciones);

        _this.addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event):void
    {
        _this.removeEventListener(Event.ADDED_TO_STAGE, init);

        _clip = new SeleccionPantalla();
        _clip.x = _this.stage.stageWidth/2;
        _clip.y = (_clip.height/2) - 60;
        _clip.addEventListener(Event.ADDED_TO_STAGE, initClip);
        addChild(_clip);
    }

    private function initClip(e:Event):void
    {
        _clip.removeEventListener(Event.ADDED_TO_STAGE, initClip);

        MonsterDebugger.trace(this, SelectorView(_clip.getChildByName('juego1')));

        trace('1');
        //_clip.addChild(new SelectorView());



        SelectorView(_clip.getChildByName('juego1')).buttonMode = true;
        trace('2');
        SelectorView(_clip.getChildByName('juego1')).activa();
        trace('3');
        SelectorView(_clip.getChildByName('juego1')).addEventListener(MouseEvent.CLICK, clicSelector);
        SelectorView(_clip.getChildByName('juego1')).indice = 2;
        trace('4');
        SelectorView(_clip.getChildByName('juego1')).setPuntuacion(puntuaciones[0] as String);
        trace('5');



        if(String(puntuaciones[0]) != '0')
        {
            SelectorView(_clip.getChildByName('juego2')).buttonMode = true;
            SelectorView(_clip.getChildByName('juego2')).addEventListener(MouseEvent.CLICK, clicSelector);
            SelectorView(_clip.getChildByName('juego2')).indice = 0;
            SelectorView(_clip.getChildByName('juego2')).setPuntuacion(puntuaciones[1] as String);

            if(String(puntuaciones[1]) != '0')
            {
                SelectorView(_clip.getChildByName('juego3')).buttonMode = true;
                SelectorView(_clip.getChildByName('juego3')).addEventListener(MouseEvent.CLICK, clicSelector);
                SelectorView(_clip.getChildByName('juego3')).indice = 1;
                SelectorView(_clip.getChildByName('juego3')).setPuntuacion(puntuaciones[2] as String);
            }
            else
            {
                SelectorView(_clip.getChildByName('juego3')).buttonMode = false;
                SelectorView(_clip.getChildByName('juego3')).capa();
            }

        }
        else
        {
            SelectorView(_clip.getChildByName('juego2')).buttonMode = false;
            SelectorView(_clip.getChildByName('juego2')).capa();

            SelectorView(_clip.getChildByName('juego3')).buttonMode = false;
            SelectorView(_clip.getChildByName('juego3')).capa();
        }
    }


    private function clicSelector(e:MouseEvent):void
    {
        SelectorView(e.currentTarget).addEventListener(MouseEvent.CLICK, clicSelector);
        var evento:JuegoEvent = new JuegoEvent(JuegoEvent.SELECCION_JUEGO);
        evento.datos = SelectorView(e.currentTarget).indice;
        _this.dispatchEvent(evento);
    }






}
}
