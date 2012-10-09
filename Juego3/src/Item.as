/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 06/10/12
 * Time: 15:51
 * To change this template use File | Settings | File Templates.
 */
package {
import com.demonsters.debugger.MonsterDebugger;
import com.greensock.TweenMax;
import com.greensock.easing.Bounce;
import com.greensock.easing.Expo;
import com.greensock.easing.Quad;

import flash.display.DisplayObject;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;



public class Item extends MovieClip
{

    private var _this:Item;
    private var _posX:Number = 0;
    private var _posY:Number = 0;
    private var _indice:uint = 0;
    private var _olla:MovieClip;
    private var _oculto:Boolean = false;

    public function Item()
    {
        super();
        _this = this;

        _this.buttonMode = true;
        _this.addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event):void
    {
        _this.removeEventListener(Event.ADDED_TO_STAGE, init);

        _posX = _this.x;
        _posY = _this.y;
        _this.addEventListener(MouseEvent.MOUSE_DOWN, press);
    }

    private function press(e:MouseEvent):void
    {
        _this.removeEventListener(MouseEvent.MOUSE_DOWN, press);
        _this.dispatchEvent(new Juego3Event(Juego3Event.ITEM_PULSADO));
        _this.stage.addEventListener(MouseEvent.MOUSE_UP, soltar);
        _this.startDrag(true);
        TweenMax.to(_this,  0.3, {scaleX: 1.25, scaleY: 1.25, ease: Bounce.easeOut});
    }

    private function soltar(e:MouseEvent):void
    {

        if(_this.hitTestObject(_olla.getChildByName('humo')))
        {
            MonsterDebugger.trace(this, '[TOCO OLLA]');
            _this.dispatchEvent(new Juego3Event(Juego3Event.ITEM_HIT_OLLA));
        }
        else
        {
            reset();
        }

    }



    public function reset(estado:String = 'ko'):void
    {
        if(estado == 'ok')
        {
            _this.visible = false;
        }

        _this.stage.removeEventListener(MouseEvent.MOUSE_UP, soltar);
        _this.stopDrag();

        _this.addEventListener(MouseEvent.MOUSE_DOWN, press);
        _this.alpha = 0.4;
        TweenMax.to(_this, 0.4, {x: posX, y: posY, scaleX: 1, scaleY: 1, alpha: 1, ease: Expo.easeInOut, onComplete: function(){
            _this.dispatchEvent(new Juego3Event(Juego3Event.ITEM_RESET));
            if(!_this.oculto)
            {
                _this.visible = true;
            }
        }});
    }




    // SETTER's & GETTER's


    public function get posX():Number {
        return _posX;
    }

    public function set posX(value:Number):void {
        _posX = value;
    }

    public function get posY():Number {
        return _posY;
    }

    public function set posY(value:Number):void {
        _posY = value;
    }

    public function get indice():uint {
        return _indice;
    }

    public function set indice(value:uint):void {
        _indice = value;
    }

    public function get olla():MovieClip {
        return _olla;
    }

    public function set olla(value:MovieClip):void {
        _olla = value;
    }

    public function get oculto():Boolean {
        return _oculto;
    }

    public function set oculto(value:Boolean):void {
        _oculto = value;
    }
}
}
