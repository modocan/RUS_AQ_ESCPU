﻿package  {import com.demonsters.debugger.MonsterDebugger;import events.JuegoEvent;import flash.display.MovieClip;	import CronoEvents;	import Juego1Event;	import BarraEvents;	import flash.events.MouseEvent;	import flash.events.Event;		import gs.TweenMax;	import com.greensock.easing.Quad;    [SWF(frameRate="24", height="810", width="610")]	public class Juego1 extends MovieClip{        private var _this:Juego1;		private var juego:Juego1View;		private var crono:Crono;		private var barra:BarraPuntos;		private var puntosTotales:uint=0;        private var profesor:Profe_mc;		private var puntuacionFinal:String;        public var ropa:Array = new Array();				private const TIEMPO_JUEGO:uint=30;								public function Juego1() { // constructor code            _this = this;            _this.addEventListener(Event.ADDED_TO_STAGE, init);            ropa = [                {                    mc: 'boca_mc', name: 'Boca_24'                },                {                     tipoPartes: 'camisa',                     mc: 'top_mc',                     name: 'Camisa_11',                     parte2: 'Top_3'                },                {                    mc: 'pelo_mc', name: 'Pelo_50'                },                {                    mc: 'gafas_mc', name: 'nada'                },                {                    tipoPartes: 'pantalon',                    mc: 'pantalon_mc',                    name: 'Pantalon_29',                    parte1: 'PiernaIzq_29',                    parte2: 'Paquete_29',                    parte3: 'PiernaDer_29'                },                {                    name: 'nada'                },                /*{                 tipoPartes: 'zapatos',                 parte1: 'ZapatoIzq_2',                 parte2: 'ZapatoDer_2'                 }*/                {                    name: 'nada'                }            ];		}        private function init(e:Event):void        {            _this.removeEventListener(Event.ADDED_TO_STAGE, init);            agregarJuego();            pintarCronoYbarra();            pintarProfe();        }        public function setRopa(_listado:Array):void        {            _this.ropa = _listado;            MonsterDebugger.trace(this, 'FUNCTION ROPA');            MonsterDebugger.trace(this, _this.ropa);            agregarJuego();            pintarCronoYbarra();            pintarProfe();        }				private function agregarJuego():void{            MonsterDebugger.trace(this, '[AGREGO JUEGO]');            MonsterDebugger.trace(this, ropa);			juego=new Juego1View();            Juego1View(juego).ropa = ropa;            MonsterDebugger.trace(this, '[JUEGO1]');            MonsterDebugger.trace(this, ropa);			addChild(juego);			juego.addEventListener(Juego1Event.PUNTO, nuevoPunto);					}				private function pintarProfe():void{			profesor=new Profe_mc();			profesor.alpha=0;						//profesor.btnComenzarJuego.addEventListener(MouseEvent.CLICK,iniciarJuego);			profesor.addEventListener(Event.ADDED_TO_STAGE, apareceProfe);			addChild(profesor);					}				private function apareceProfe(e:Event):void{			profesor.removeEventListener(Event.ADDED_TO_STAGE, apareceProfe);			TweenMax.to(profesor, 0.7, {alpha:1,ease:Quad.easeIn});			profesor.btnComenzarJuego.addEventListener(MouseEvent.CLICK,iniciarJuego);		}				private function iniciarJuego(e:MouseEvent):void{			removeChild(profesor);            this.focusRect = false;			stage.focus=juego;			juego.iniciarJuego();			crono.iniciarCrono(30); //Luego va a iniciar cuando se cierre al profe!!!!		}				private function pintarCronoYbarra():void{			crono= new Crono();			crono.x=50;			crono.y=5;			addChild(crono);			crono.addEventListener(CronoEvents.TIEMPO_COMPLETO, terminarJuego);						barra= new BarraPuntos();			barra.x=530;			barra.y=7;			barra.addEventListener(BarraEvents.PUNTOS_COMPLETOS, puntosCompletos);						addChild(barra);			//crono.iniciarCrono(TIEMPO_JUEGO); //Luego va a iniciar cuando se cierre al profe!!!!			//juego.iniciarJuego();//Luego va a iniciar cuando se cierre al profe!!!!		}				private function puntosCompletos(e:BarraEvents):void{			// Acá que va??? Cartel, diploma o algo???			//crono.pararCrono();			terminarJuego();		}				private function terminarJuego(e:CronoEvents=null):void{			juego.finJuego();            crono.removeEventListener(CronoEvents.TIEMPO_COMPLETO, terminarJuego);            crono.pararCrono();			puntuacionFinal=barra.puntosFinales();            var evento:JuegoEvent = new JuegoEvent(JuegoEvent.JUEGO_ACABADO);            evento.datos = puntuacionFinal;            _this.dispatchEvent(evento);		}				private function nuevoPunto(e:Juego1Event):void{			barra.punto(1);			puntosTotales+=2;		}	}	}