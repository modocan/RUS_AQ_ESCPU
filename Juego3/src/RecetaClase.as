/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 07/10/12
 * Time: 17:05
 * To change this template use File | Settings | File Templates.
 */
package {
import com.greensock.TweenMax;

import flash.display.MovieClip;
import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

public class RecetaClase extends MovieClip {

    private var _this:RecetaClase;

    public function RecetaClase()
    {
        super();
        _this = this;
    }


    public function pintaReceta():void
    {
        // TODO hacer animación de cambio de textos

        for each(var obj:TextField in _this)
        {
            obj.visible = false;
            obj.text = '';
            TweenMax.to(obj,  0.05, {tint: null});
            obj.visible = true;
        }

        TextField(_this.getChildByName('titulo')).text = RecetaModel.getInstance()._nombre as String;

        TextField(_this.getChildByName('in1')).autoSize = TextFieldAutoSize.LEFT;
        TextField(_this.getChildByName('in1')).text = RecetaModel.getInstance()._ingrediente_1.texto as String;

        TextField(_this.getChildByName('in2')).autoSize = TextFieldAutoSize.LEFT;
        TextField(_this.getChildByName('in2')).text = RecetaModel.getInstance()._ingrediente_2.texto as String;

        TextField(_this.getChildByName('in3')).autoSize = TextFieldAutoSize.LEFT;
        TextField(_this.getChildByName('in3')).text = RecetaModel.getInstance()._ingrediente_3.texto as String;

        TextField(_this.getChildByName('in4')).autoSize = TextFieldAutoSize.LEFT;
        TextField(_this.getChildByName('in4')).text = RecetaModel.getInstance()._ingrediente_4.texto as String;

        TextField(_this.getChildByName('in5')).autoSize = TextFieldAutoSize.LEFT;
        TextField(_this.getChildByName('in5')).text = RecetaModel.getInstance()._ingrediente_5.texto as String;

    }


    public function tachaIngrediente(ing:String):void
    {
        for each(var obj:TextField in _this)
        {
            if(obj.name != 'titulo' && obj.text == ing)
            {
                //TweenMax.to(obj,  0.2, {tint: 0xFF0000});
                var tachon:Tachon = new Tachon();
                tachon.x = obj.x;
                tachon.y = obj.y - 2;
                tachon.alpha = 0;
                tachon.width = obj.width;
                tachon.addEventListener(Event.ADDED_TO_STAGE, initTachon);
                _this.addChild(tachon);
                return;
            }
        }
    }

    private function initTachon(e:Event):void
    {
        e.currentTarget.removeEventListener(Event.ADDED_TO_STAGE, initTachon);

        TweenMax.to(e.currentTarget, 0.3, {alpha: 1});
    }

}
}
