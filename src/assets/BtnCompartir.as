/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 20/10/12
 * Time: 16:10
 * To change this template use File | Settings | File Templates.
 */
package assets {
import com.greensock.TweenMax;

import flash.display.MovieClip;
import flash.display.MovieClip;
import flash.events.MouseEvent;

public class BtnCompartir extends BtnGenerico{

    private var _this:BtnCompartir;

    public function BtnCompartir()
    {
        super();
        _this = this;
        MovieClip(_this.getChildByName('texto_txt')).visible = false;
        MovieClip(_this.getChildByName('texto_txt')).alpha = 0;
        _this.addEventListener(MouseEvent.CLICK, clic);
    }

    private function clic(e:MouseEvent):void
    {
        _this.removeEventListener(MouseEvent.CLICK, clic);

        TweenMax.to(MovieClip(_this.getChildByName('btn')), 0.3, {alpha: 0, scaleX: 0, scaleY: 0, onComplete:function(){

            MovieClip(_this.getChildByName('btn')).visible = false;
            MovieClip(_this.getChildByName('texto_txt')).visible = true;
            MovieClip(_this.getChildByName('texto_txt')).scaleX = MovieClip(_this.getChildByName('btn')).scaleY = 0;

            TweenMax.to(MovieClip(_this.getChildByName('texto_txt')), 0.3, {alpha: 1, scaleX: 1, scaleY: 1});

        }});
    }
}
}
