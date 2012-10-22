/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 09/10/12
 * Time: 00:44
 * To change this template use File | Settings | File Templates.
 */
package views {
import assets.BtnGenerico;

import com.greensock.TweenMax;

import events.JuegoEvent;

import flash.display.Bitmap;

import flash.display.DisplayObject;
import flash.display.MovieClip;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import org.robotlegs.base.MediatorMap;

public class SelectorView extends Sprite
{
    private var _this:SelectorView;
    private var candado:Candado;
    private var candado_puesto:Boolean = false;

    public var indice:uint = 0;

    public function SelectorView()
    {
        super();
        _this = this;
        _this.mouseChildren = false;
        _this.addEventListener(Event.ADDED_TO_STAGE, init);
        _this.addEventListener(MouseEvent.MOUSE_OVER, over);
        _this.addEventListener(MouseEvent.MOUSE_OUT, out);
    }

    private function init(e:Event):void
    {
        _this.removeEventListener(Event.ADDED_TO_STAGE, init);

        trace('instancio this');
    }


    public function activado():void
    {

    }

    private function out(e:MouseEvent):void
    {
        TweenMax.to(MovieClip(_this.getChildByName('reflejo')), 0.3, {alpha: 1});
    }

    private function over(e:MouseEvent):void
    {
        TweenMax.to(MovieClip(_this.getChildByName('reflejo')), 0.3, {alpha: 0.4});
    }


    public function capa():void
    {
        _this.removeEventListener(MouseEvent.MOUSE_OVER, over);
        _this.removeEventListener(MouseEvent.MOUSE_OUT, out);
        candado_puesto = true;
        candado= new Candado();
        addChild(candado);
    }


    public function setPuntuacion(_data:String):void
    {
        if(_data != '0')
        {
            trace('No es 0');
            if(!_this.hasEventListener(MouseEvent.CLICK))
            {
                _this.addEventListener(MouseEvent.CLICK, clic);
            }

            var diploma:Sprite = new Sprite();
            diploma = dameDiploma(_data) as Sprite;
            diploma.x = (diploma.width/2) - 45;
            diploma.y = (diploma.height/2) - 20;
            diploma.scaleX = diploma.scaleY = 0.65;
            //diploma.alpha = 0;
            //diploma.scaleX = diploma.scaleY = 1.2;
            //diploma.addEventListener(Event.ADDED_TO_STAGE, initDiploma);
            addChild(diploma);
        }

        function initDiploma(e:Event):void
        {
            diploma.removeEventListener(Event.ADDED_TO_STAGE, initDiploma);

            TweenMax.to(diploma, 0.5, {alpha: 1, scaleX: 1, scaleY: 1});
        }
    }


    public function activa():void
    {
        if(!_this.hasEventListener(MouseEvent.CLICK))
        {
            _this.addEventListener(MouseEvent.CLICK, clic);
        }

    }


    public function libera():void
    {
        TweenMax.to(candado.candado, 0.1, {scaleX: 1.2, scaleY: 1.2, onComplete: function(){

            TweenMax.to(candado.candado, 0.3, {scaleX: 0, scaleY: 0, alpha: 0, onComplete: function(){

                _this.removeChild(candado);

            }});

        }});
    }


    public function premia(_diploma:DisplayObject):void
    {
        _diploma.alpha = _diploma.scaleX = _diploma.scaleY = 0;
        _diploma.addEventListener(Event.ADDED_TO_STAGE, initDiploma);
        _this.addChild(_diploma);

        function initDiploma(e:Event):void
        {
            _diploma.removeEventListener(Event.ADDED_TO_STAGE, initDiploma);

            TweenMax.to(_diploma, 0.6, {alpha: 1, scaleX: 1, scaleY: 1});
        }

    }



    private function clic(e:MouseEvent):void
    {
        trace('[CLIC]');
        trace(indice);
        _this.removeEventListener(MouseEvent.CLICK, clic);

        var evento:JuegoEvent = new JuegoEvent(JuegoEvent.SELECCION_JUEGO);
        //evento.datos = indice;
        _this.dispatchEvent(evento);
    }



    private function dameDiploma(_punt:String):Sprite
    {

        var _clip:Sprite;

        switch (_punt)
        {
            case 'muy_deficiente':
                    _clip = new DiplomaDeficiente();
                break;

            case 'insuficiente':
                _clip = new DiplomaInsuficiente();
                break;

            case 'suficiente':
                _clip = new DiplomaSuficiente();
                break;

            case 'bien':
                _clip = new DiplomaBien();
                break;

            case 'notable':
                _clip = new DiplomaNotable();
                break;

            case 'sobresaliente':
                _clip = new DiplomaSobresaliente();
                break;


        }

        return _clip as Sprite;
    }



}
}
