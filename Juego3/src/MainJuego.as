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
import com.greensock.easing.Expo;

import events.JuegoEvent;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.utils.Timer;

public class MainJuego extends MovieClip {

    public var ropa:Array = new Array();

    private var _this:MainJuego;
    private var olla:MovieClip;
    private var listaRecetas:Array;
    private var maximoRecetas:uint = 10;
    private var maximoIngs:uint = 5;
    private var contadorRecetas:uint = 0;
    private var fondoBlanco:Sprite;
    private var crono:Crono;
    private var receta:Receta;
    private var barraPuntos:BarraPuntos;
    private var home:HomeCocina;
    private var personaje:Muneco_mc;
    private var releCrono:Boolean = false;
    private var miTiempo:Timer;
    private var tiempo_crono:Number = 120;
    private var tiempoFondo:uint = 5000;
    private var anchoReceta:Number = 0.4;
    private var altoReceta:Number = 0.4;

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


        personaje = new Muneco_mc();
        var perX:Number = MovieClip(_this.getChildByName('mesa')).x + 13;
        var perY:Number = MovieClip(_this.getChildByName('mesa')).y - ((personaje.height/2) - 30);
        personaje.config('1', perX, perY);
        personaje.vestirTodosLosMunecos(_this.ropa, ['personaje_mc']);
        //personaje.vestirMuneco(_this.ropa[5], 'personaje_mc');
        personaje.scaleX = personaje.scaleY = 0.8;
        personaje.buttonMode = false;
        addChildAt(personaje, _this.getChildIndex(_this.getChildByName('mesa'))-1);
        //addChild(personaje);


        crono = new Crono();
        crono.x = crono.y = 15;
        crono.addEventListener(CronoEvents.TIEMPO_COMPLETO, finCrono);
        addChild(crono);

        barraPuntos = new BarraPuntos();
        barraPuntos.x = _this.width - (barraPuntos.width + 70);
        barraPuntos.y = 15;
        addChild(barraPuntos);

        fondoBlanco = new Sprite();
        fondoBlanco.graphics.beginFill(0xFFFFFF, 0.7);
        fondoBlanco.graphics.drawRect(0, 0, _this.width, _this.height);
        fondoBlanco.graphics.endFill();
        fondoBlanco.alpha = 0;
        fondoBlanco.addEventListener(Event.ADDED_TO_STAGE, initBlanco);
        addChild(fondoBlanco);
    }

    private function finCrono(e:CronoEvents):void
    {
        crono.removeEventListener(CronoEvents.TIEMPO_COMPLETO, finCrono);
        crono.pararCrono();

        var evento:JuegoEvent = new JuegoEvent(JuegoEvent.JUEGO_ACABADO);
        evento.datos = damePuntuacion();
        _this.dispatchEvent(evento);

        MonsterDebugger.trace(this, 'finJuego');
    }

    function initReceta(e:Event):void
    {
        receta.removeEventListener(Event.ADDED_TO_STAGE, initReceta);
        RecetaClase(receta).pintaReceta();

        miTiempo = new Timer(tiempoFondo, 1);
        miTiempo.addEventListener(TimerEvent.TIMER_COMPLETE, tiempoCompleto);
        miTiempo.start();
    }

    function initBlanco(e:Event):void
    {
        fondoBlanco.removeEventListener(Event.ADDED_TO_STAGE, initBlanco);

        TweenMax.to(fondoBlanco, 0.3, {alpha: 1, onComplete: function(){

            home = new HomeCocina();
            home.x = (_this.width/2);
            home.y = (_this.height/2);
            home.scaleX = home.scaleY = home.alpha = 0;
            home.comenzar.buttonMode = true;
            home.comenzar.addEventListener(MouseEvent.CLICK, clicComenzar);
            home.addEventListener(Event.ADDED_TO_STAGE, initHome);
            addChild(home);

        }});

    }

    function initBlancoJuego(e:Event):void
    {
        fondoBlanco.removeEventListener(Event.ADDED_TO_STAGE, initBlancoJuego);

        TweenMax.to(fondoBlanco, 0.3, {alpha: 1, onComplete: function(){

            receta = new Receta();
            receta.x = (_this.width/2) - (receta.width/2);
            receta.y = (_this.height/2) - (receta.height/2);
            receta.addEventListener(Event.ADDED_TO_STAGE, initReceta);
            addChild(receta);

        }});

    }

    private function clicComenzar(e:MouseEvent):void
    {
        home.comenzar.removeEventListener(MouseEvent.CLICK, clicComenzar);

        TweenMax.to(home, 0.4, {alpha: 0, scaleX: 0, scaleY: 0, ease: Expo.easeIn, onComplete: function(){

            _this.removeChild(home);

            receta = new Receta();
            receta.x = (_this.width/2) - (receta.width/2);
            receta.y = (_this.height/2) - (receta.height/2);
            receta.addEventListener(Event.ADDED_TO_STAGE, initReceta);
            addChild(receta);

        }});
    }

    private function initHome(e:Event):void
    {
        home.removeEventListener(Event.ADDED_TO_STAGE, initHome);

        TweenMax.to(home, 0.3, {alpha: 1, scaleX: 1, scaleY: 1, ease: Expo.easeOut});
    }

    private function tiempoCompleto(e:TimerEvent):void
    {
        miTiempo.removeEventListener(TimerEvent.TIMER_COMPLETE, tiempoCompleto);
        miTiempo.stop();

        TweenMax.to(fondoBlanco, 0.3, {alpha: 0, onComplete: function(){

            _this.removeChild(fondoBlanco);

            var _anchoFinal:Number = receta.width * anchoReceta;
            var _altoFinal:Number = receta.height * altoReceta;

            TweenMax.to(receta, 0.8, {x: _this.width - (_anchoFinal + 95) , y: _this.height - (_altoFinal + 35) , width: _anchoFinal, height: _altoFinal, onComplete: function(){

                if(!releCrono)
                {
                    crono.iniciarCrono(tiempo_crono);
                    releCrono = true;
                }
                else
                {
                    crono.iniciarCrono(crono.dimeResto());
                    MonsterDebugger.trace(this, crono.dimeResto());
                }


            }});

        }});
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
                contadorRecetas ++;
                barraPuntos.punto(2);
                crono.pararCrono();

                if(contadorRecetas < maximoRecetas )
                {
                    TweenMax.to(receta,  0.6, {alpha: 0, scaleX: 0, scaleY: 0, onComplete: function(){

                        _this.removeChild(receta);

                        MonsterDebugger.trace(this, '[CAMBIO DE RECETA]');
                        RecetaModel.getInstance().setReceta(listaRecetas[contadorRecetas]);

                        fondoBlanco = new Sprite();
                        fondoBlanco.graphics.beginFill(0xFFFFFF, 0.7);
                        fondoBlanco.graphics.drawRect(0, 0, _this.width, _this.height);
                        fondoBlanco.graphics.endFill();
                        fondoBlanco.alpha = 0;
                        fondoBlanco.addEventListener(Event.ADDED_TO_STAGE, initBlancoJuego);
                        addChild(fondoBlanco);

                        restItems();

                    }});
                }
                else
                {
                    var evento:JuegoEvent = new JuegoEvent(JuegoEvent.JUEGO_ACABADO);
                    evento.datos = damePuntuacion();
                    _this.dispatchEvent(evento);
                }

            }

        }
        else
        {
            Item(e.currentTarget).reset();
        }

    }


    private function damePuntuacion():String
    {
        var resp:String;

        switch (contadorRecetas)
        {
            case 0:
                    resp = 'muy_deficiente';
                break;

            case 1:
                resp = 'muy_deficiente';
                break;

            case 2:
                resp = 'insuficiente';
                break;

            case 3:
                resp = 'insuficiente';
                break;

            case 4:
                resp = 'suficiente';
                break;

            case 5:
                resp = 'suficiente';
                break;

            case 6:
                resp = 'bien';
                break;

            case 7:
                resp = 'bien';
                break;

            case 8:
                resp = 'notable';
                break;

            case 9:
                resp = 'notable';
                break;

            case 10:
                resp = 'sobresaliente';
                break;
        }

        return resp;
    }


    private function echaItemOlla(_item:DisplayObject):void
    {
        var fondo_olla:MovieClip = MovieClip(_this.getChildByName('fondo_olla'));
        _item.scaleX = _item.scaleY = 0.9;
        //addChildAt(_item,  _this.getChildIndex(olla) - 1);
        addChildAt(_item,  _this.getChildIndex(fondo_olla) + 1);
        TweenMax.to(_item,  0.4, {alpha: 0, y: _item.y + ((olla.height/2) - (_item.height/2)), x: olla.x, onComplete: function(){

            Item(_item).reset('ok');
            MovieClip(_this.getChildByName('mano')).play();

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
