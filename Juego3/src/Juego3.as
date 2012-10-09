package {

import com.demonsters.debugger.MonsterDebugger;
import com.demonsters.debugger.MonsterDebugger;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.text.TextField;

[SWF(frameRate="24", height="800", width="600")]
public class Juego3 extends Sprite {

    private var _this:Juego3;
    private var main:MainJuego3;

    public function Juego3()
    {
        super();
        _this =  this;

        MonsterDebugger.initialize(this);

        /*_this.stage.scaleMode = StageScaleMode.NO_SCALE;
        _this.stage.align = StageAlign.TOP_LEFT;*/

        _this.addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event):void
    {
        _this.removeEventListener(Event.ADDED_TO_STAGE, init);

        var cargador:URLLoader = new URLLoader();
        cargador.addEventListener(Event.COMPLETE, cargadorComplete);
        cargador.addEventListener(IOErrorEvent.IO_ERROR, errorCarga);
        cargador.load(new URLRequest('juegos/xml/recetas.xml'));
    }

    private function errorCarga(e:IOErrorEvent):void
    {
        MonsterDebugger.trace(this, '[ERROR]');
        MonsterDebugger.trace(this, e.text);
    }

    private function cargadorComplete(e:Event):void
    {
        e.currentTarget.removeEventListener(Event.COMPLETE, cargadorComplete);

        var listado:Array = new Array();
        var datos:XMLList = XMLList(XML(e.target.data)[0]);

        for each(var nodo:XML in datos.receta)
        {
            listado.push({
                receta: String(nodo.@nombre),
                ingredientes: {

                    ing1: String(nodo.ingrediente[0]),
                    ing1_clip: String(nodo.ingrediente[0].@item),
                    ing2: String(nodo.ingrediente[1]),
                    ing2_clip: String(nodo.ingrediente[1].@item),
                    ing3: String(nodo.ingrediente[2]),
                    ing3_clip: String(nodo.ingrediente[2].@item),
                    ing4: String(nodo.ingrediente[3]),
                    ing4_clip: String(nodo.ingrediente[3].@item),
                    ing5: String(nodo.ingrediente[4]),
                    ing5_clip: String(nodo.ingrediente[4].@item)

                }
            });
        }

        main = new MainJuego3();
        MainJuego(main).prepararRecetas(listado);
        addChild(main);

    }

}
}
