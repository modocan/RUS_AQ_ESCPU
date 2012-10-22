/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 20/10/12
 * Time: 16:13
 * To change this template use File | Settings | File Templates.
 */
package assets {
import com.greensock.TweenMax;
import com.greensock.easing.Expo;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class BtnGenerico extends MovieClip{

    private var _this:BtnGenerico;

    public function BtnGenerico()
    {
        super();
        _this = this;
        _this.mouseChildren = false;
        _this.addEventListener(MouseEvent.MOUSE_OVER, over);
        _this.addEventListener(MouseEvent.MOUSE_OUT, out);
        //_this.addEventListener(MouseEvent.CLICK, clic);
    }

    private function clic(e:MouseEvent):void
    {
        TweenMax.to(_this, 0.05, {scaleX: 1, scaleY: 1, alpha: 0.8, ease:Expo.easeOut, onComplete: function(){

            TweenMax.to(_this, 0.05, {scaleX: 1, scaleY: 1, alpha: 1, ease:Expo.easeOut});

        }});
    }

    private function out(e:MouseEvent):void
    {
        TweenMax.to(_this, 0.15, {scaleX: 1, scaleY: 1, ease:Expo.easeOut});
    }

    private function over(e:MouseEvent):void
    {
        TweenMax.to(_this, 0.15, {scaleX: 0.97, scaleY: 0.97, ease:Expo.easeOut});
    }
}
}
