/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 06/10/12
 * Time: 17:45
 * To change this template use File | Settings | File Templates.
 */
package {

import com.demonsters.debugger.MonsterDebugger;
import com.greensock.TweenMax;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.Event;

public class MainJuego extends MovieClip {

    private var _this:MainJuego;
    private var olla:MovieClip;
    private var listaRecetas:Array;
    private var maximoRecetas:uint = 5;
    private var maximoIngs:uint = 5;
    private var contadorRecetas:uint = 0;
    private var receta:Receta;

    public function MainJuego()
    {
        super();

        MonsterDebugger.initialize(this);

        _this = this;
        _this.addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(e:Event):void
    {
        _this.removeEventListener(Event.ADDED_TO_STAGE, init);

        for(var j:uint = 0; j < _this.numChildren; j++)
        {
            if(_this.getChildAt(j) is Olla)
            {
                olla = Olla(_this.getChildAt(j));
                break;
            }
        }

        for(var i:uint = 0; i < _this.numChildren; i++)
        {
            if(_this.getChildAt(i) is Item)
            {
                _this.getChildAt(i).addEventListener(Event.ADDED_TO_STAGE, initItem);
                _this.getChildAt(i).addEventListener(Juego3Event.ITEM_PULSADO, itemPulsado);
                _this.getChildAt(i).addEventListener(Juego3Event.ITEM_HIT_OLLA, itemHitOlla);
                _this.getChildAt(i).addEventListener(Juego3Event.ITEM_RESET, itemReset);
            }

        }


        receta = new Receta();
        receta.addEventListener(Event.ADDED_TO_STAGE, initReceta);
        addChild(receta);

        function initReceta(e:Event):void
        {
            receta.removeEventListener(Event.ADDED_TO_STAGE, initReceta);
            RecetaClase(receta).pintaReceta();
        }

    }

    private function itemHitOlla(e:Juego3Event):void
    {
        var textoIngrediente:String = RecetaModel.getInstance().comparaIngrediente(parseaClase(String(e.currentTarget.valueOf())));
        MonsterDebugger.trace(this, textoIngrediente);
        if(textoIngrediente != '')
        {
            echaItemOlla(e.currentTarget as DisplayObject);
            Item(e.currentTarget).oculto = true;
            RecetaModel.getInstance().tachados ++;
            receta.tachaIngrediente(textoIngrediente);

            if(RecetaModel.getInstance().tachados >= maximoIngs)
            {
                if(contadorRecetas < maximoRecetas )
                {
                    contadorRecetas ++;

                    MonsterDebugger.trace(this, '[CAMBIO DE RECETA]');
                    RecetaModel.getInstance().setReceta(listaRecetas[contadorRecetas]);
                    RecetaClase(receta).pintaReceta();

                    restItems();

                }
                else
                {
                    // TODO hacer FIN JUEGO
                }

            }

        }
        else
        {
            Item(e.currentTarget).reset();
        }

    }

    private function echaItemOlla(_item:DisplayObject):void
    {
        _item.scaleX = _item.scaleY = 0.9;
        addChildAt(_item,  _this.getChildIndex(olla) - 1);
        TweenMax.to(_item,  0.4, {alpha: 0, y: _item.y + ((olla.height/2) - (_item.height/2)), x: olla.x, onComplete: function(){

            Item(_item).reset('ok');

        }});
    }

    private function restItems():void
    {
        for(var i:uint = 0; i < _this.numChildren; i++)
        {
            if(_this.getChildAt(i) is Item)
            {
                Item(_this.getChildAt(i)).oculto = false;
                _this.getChildAt(i).visible = true;
            }

        }
    }

    private function parseaClase(_data:String):String
    {
        var l:Array = new Array();
        l = _data.split(' ');

        trace(String(l[1]).substr(0, l[1].length - 1));

        return String(l[1]).substr(0, l[1].length - 1);
    }

    private function itemReset(e:Juego3Event):void
    {
        _this.addChildAt(Item(e.currentTarget), Item(e.currentTarget).indice);
    }

    private function initItem(e:Event):void
    {
        Item(e.currentTarget).olla = olla;
        Item(e.currentTarget).removeEventListener(Event.ADDED_TO_STAGE, initItem);
        Item(e.currentTarget).indice = _this.getChildIndex(Item(e.currentTarget));
    }

    private function itemPulsado(e:Juego3Event):void
    {
        _this.addChild(e.currentTarget as DisplayObject);
    }

    public function prepararRecetas(_lista:Array):void
    {
        listaRecetas = new Array();

        var aleatorio:uint = 0;
        for(var i:uint = 0; i < maximoRecetas; i++)
        {
            aleatorio = Math.round(Math.random() * (_lista.length - 1));
            listaRecetas.push(_lista[aleatorio]);
            _lista.splice(aleatorio, 1);
        }

        RecetaModel.getInstance().setReceta(listaRecetas[contadorRecetas]);
        MonsterDebugger.trace(this, '[CREO RECETA]');
        MonsterDebugger.trace(this, RecetaModel.getInstance());








    }
}
}
