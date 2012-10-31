﻿package  {    import events.JuegoEvent;    import flash.display.MovieClip;    import flash.display.Sprite;	import flash.events.Event;	import flash.events.MouseEvent;    import clases.Juego2View;    import clases.Juego2Event;    import CronoEvents;    import BarraEvents;		import com.greensock.TweenMax;	import com.greensock.easing.*;		import gs.TweenMax;    import gs.easing.Expo;    [SWF(frameRate="24", height="800", width="600")]    public class Juego2 extends MovieClip{				private var _this:Juego2;		private var _juego:Juego2View;        private var _crono:Crono;		private var profesor:Profe_mc;        private var _barra:BarraPuntos;        private var _puntosTotales:int = 0;        private var _tiempo_juego:int = 90;        public var ropa:Array = new Array();        private var _mascara:Sprite;        private var _ancho:int = 1620;        private var _alto:int = 1200;		public function Juego2() {			_this = this;             /*            ropa = [                {                    mc: 'ojos_mc', name: 'Ojos_2'                },                {                    mc: 'boca_mc', name: 'Boca_2'                },                {                    mc: 'pelo_mc', name: 'Pelo_2'                },                {                    mc: 'gafas_mc', name: 'Gafas_2'                },                {                    tipoPartes: 'pantalon',                    mc: 'pantalon_mc',                    name: 'Pantalon_2',                    parte1: 'PiernaIzq_2',                    parte2: 'Paquete_2',                    parte3: 'PiernaDer_2'                },                {                    tipoPartes: 'camisa',                    mc: 'camisa_mc',                    name: 'Camisa_2',                    parte1: 'BrazoIzq_2',                    parte2: 'Torso_2',                    parte3: 'BrazoDer_2'                },                {                    name: 'nada'                }            ];            */			_this.addEventListener(Event.ADDED_TO_STAGE, config);		}        public function setRopa(_data:Array):void        {            _this.ropa = _data;            agregarJuego();            pintarCronoYbarra();            pintarProfe();        }				private function config(e:Event){			_this.removeEventListener(Event.ADDED_TO_STAGE, config);            /*agregarJuego();            pintarCronoYbarra();            pintarProfe();*/		}        private function agregarJuego(){            _juego = new Juego2View();            _juego.x = 706;            _juego.y = 0;            _juego.ropa = _this.ropa;            _mascara = new Sprite();            _mascara.graphics.beginFill(0x000000)            _mascara.graphics.drawRect(0,0,810,600);            _this.addChild(_mascara);            _this.addChild(_juego);            _juego.mask = _mascara;            _juego.addEventListener(Juego2Event.PUNTO, nuevoPunto);            _juego.addEventListener(Juego2Event.QUITAR_PUNTO, nuevoPunto);        }        private function pintarProfe(){			profesor=new Profe_mc();			profesor.alpha=0;						//profesor.btnComenzarJuego.addEventListener(MouseEvent.CLICK,iniciarJuego);			profesor.addEventListener(Event.ADDED_TO_STAGE, apareceProfe);			addChild(profesor);        }				private function apareceProfe(e:Event):void{			profesor.removeEventListener(Event.ADDED_TO_STAGE, apareceProfe);			com.greensock.TweenMax.to(profesor, 0.7, {alpha:1,ease:Quad.easeIn});			profesor.btnComenzarJuego.addEventListener(MouseEvent.CLICK,inicio);		}        private function pintarCronoYbarra(){            _crono= new Crono();            _crono.x=30;            _crono.y=13;            addChild(_crono);            _crono.addEventListener(CronoEvents.TIEMPO_COMPLETO, terminarJuego);            _barra= new BarraPuntos();            _barra.x=530;            _barra.y=17;            addChild(_barra);        }        private function puntosCompletos(){            trace('PUNTOS COMPLETOSSSSSSSSSS!!!!!!!!!!!! -------------');            _crono.pararCrono();            terminarJuego();        }        private function terminarJuego(e:CronoEvents=null){            trace('TERMINAR JUEGO!!! '+_puntosTotales);            var nota:String;            switch(String(_puntosTotales)){                case '0':                    nota = 'muy_deficiente';                    break;                case '1':                    nota = 'muy_deficiente';                    break;                case '2':                    nota = 'muy_deficiente';                    break;                case '3':                    nota = 'insuficiente';                    break;                case '4':                    nota = 'insuficiente';                    break;                case '5':                    nota = 'suficiente';                    break;                case '6':                    nota = 'bien';                    break;                case '7':                    nota = 'bien';                    break;                case '8':                    nota = 'notable';                    break;                case '9':                    nota = 'notable';                    break;                case '10':                    nota = 'sobresaliente';                    break;            }            _juego.finJuego();            var evento:JuegoEvent = new JuegoEvent(JuegoEvent.JUEGO_ACABADO);            evento.datos = nota;            _this.dispatchEvent(evento);        }        private function nuevoPunto(e:Juego2Event){            if(e.type == 'PUNTO' && _puntosTotales < 9){                _barra.punto(2);                _puntosTotales++;            } else if(_puntosTotales>=1 && e.type != 'PUNTO'){                _barra.punto(-2);                _puntosTotales--;            } else if(_puntosTotales == 9){				_juego.addEventListener(MouseEvent.MOUSE_UP, soltar);               // puntosCompletos();            }            trace('punto: '+_puntosTotales);			function soltar(e:MouseEvent){                com.greensock.TweenMax.to(_juego, 1, {delay:1.5, onComplete:function(){                        _barra.punto(2);                        _puntosTotales++;                        puntosCompletos();                }});			}        }				private function inicio(e:MouseEvent = null){			removeChild(profesor);			com.greensock.TweenMax.to(_juego, 2, {x:stage.stageWidth/2, y:300, width:_ancho/2, height:_alto/2, delay:1.5, ease:com.greensock.easing.Expo.easeInOut, onComplete:function(){                _juego._fondo.nubes_mc.play();                _juego._fondo.tractor_mc.play();                _crono.iniciarCrono(_tiempo_juego); //Luego va a iniciar cuando se cierre al profe!!!!            }});		}					}	}