/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 14/09/12
 * Time: 14:10
 * To change this template use File | Settings | File Templates.
 */
package views {
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.utils.getDefinitionByName;

public class PruebaView extends Sprite{

    private var _Muneco:Class;

    public function PruebaView() {

        this.addEventListener(Event.ADDED_TO_STAGE, init);

    }

    private function init(e:Event):void {

        this.removeEventListener(Event.ADDED_TO_STAGE, init);

        _Muneco = getDefinitionByName('ZapatoDer_1') as Class;
        var queco:MovieClip = new _Muneco() as MovieClip;
        queco.x = queco.y = 100;
        addChild(queco);


    }
}
}
