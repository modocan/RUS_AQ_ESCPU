/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 07/10/12
 * Time: 12:31
 * To change this template use File | Settings | File Templates.
 */
package {
import com.greensock.TweenMax;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Rectangle;

public class OllaClase extends MovieClip{

    private var _this:OllaClase;
    private var _receta:Object = new Object();
    private var contadorIngredientes:uint = 0;

    public function OllaClase()
    {
        super();
        _this = this;
    }



    private function initElemen(e:Event):void
    {
        e.currentTarget.removeEventListener(Event.ADDED_TO_STAGE, initElemen);

        //TweenMax.to(Bitmap(e.currentTarget), 0.4, {y: _this.height});
    }

    public function get receta():Object {
        return _receta;
    }

    public function set receta(value:Object):void {
        _receta = value;
        contadorIngredientes = 0;
    }
}
}
