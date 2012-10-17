/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 15/10/12
 * Time: 13:15
 * To change this template use File | Settings | File Templates.
 */
package views {
import com.greensock.TweenMax;

import events.ConfiguradorEvent;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class HomeView extends Sprite{

    private var _this:HomeView;
    private var _clip:HomeApp;

    public function HomeView()
    {
        super();
        _this = this;
        _this.addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event):void
    {
        _this.removeEventListener(Event.ADDED_TO_STAGE, init);

        _clip = new HomeApp();
        _clip.entrar.buttonMode = true;
        _clip.x = (_this.stage.stageWidth/2) + 80;
        _clip.y = (_this.stage.stageHeight/2) - 90;
        _clip.entrar.addEventListener(MouseEvent.CLICK, clicEntrar);
        _clip.alpha = _clip.scaleX = _clip.scaleY = 0;
        _clip.addEventListener(Event.ADDED_TO_STAGE, initClip);
        addChild(_clip);
    }

    private function initClip(e:Event):void
    {
        e.currentTarget.removeEventListener(Event.ADDED_TO_STAGE, initClip);

        TweenMax.to(Sprite(e.currentTarget), 0.4, {alpha: 1, scaleX: 1, scaleY:1});
    }

    private function clicEntrar(e:MouseEvent):void
    {
        e.currentTarget.removeEventListener(MouseEvent.CLICK, clicEntrar);

        TweenMax.to(_clip, 0.4, {alpha: 0, scaleX: 0, scaleY: 0, onComplete: function(){

            _this.dispatchEvent(new ConfiguradorEvent(ConfiguradorEvent.INICIO_HOME));

        }});


    }
}
}
