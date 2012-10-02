﻿package views{import com.demonsters.debugger.MonsterDebugger;import com.greensock.TweenMax;	import com.greensock.easing.*;	import com.hexagonstar.util.debug.Debug;		import events.ConfiguradorEvent;		import flash.display.MovieClip;	import flash.events.Event;	import flash.events.MouseEvent;	import flash.utils.getDefinitionByName;		public class MunecoView extends MovieClip	{		private var _this:MunecoView;		private var _muneco:MiMuneco;				private var _bragas:Braga_mc = new Braga_mc();		private var _sujetador:Sujetador_mc = new Sujetador_mc();		private var _calzoncillos:Calzoncillos_mc = new Calzoncillos_mc();        public var sexoActual:String;				// Posiciones		private var _posCentral:Number = 311;		private var _posXIni:Number;		private var _posX:Number = 232;		private var _posY:Number = 287;        public var cesta:Cesta_mc;        private var _sexo:String;        public var estado:String;        private var arr_estados:Array = ['personaje_mc', 'pesonajeCaminando'];						public function MunecoView()		{			_this = this;			_this.visible = false;			_this.addEventListener(Event.ADDED_TO_STAGE, init);		}				private function init(e:Event):void		{			_this.removeEventListener(Event.ADDED_TO_STAGE, init);			eventosRaton();		}        // TODO hacer que pinte el muñeco mujer en mujer y hombre en hombre        public function config(sexo:String, pX:Number=0, pY:Number=0):void        {            _muneco = new MiMuneco();            _this.addChild(_muneco);            _sexo = sexo;            _this.name = _sexo;            setAnimMuneco('');            if(_sexo == 'chica'){                _muneco.personaje_mc.cuerpo_mc.camiseta_mc.torso_mc.addChild(_sujetador);                _muneco.personaje_mc.cuerpo_mc.paquete_mc.addChild(_bragas);            } else {                _muneco.personaje_mc.cuerpo_mc.paquete_mc.addChild(_calzoncillos);            }            if(pX == 0 && pY == 0){ // Si viene desde el configurador:                _posXIni =  - _this.width*2;                _this.y = _posY;                _this.x = _posXIni;                eventosRaton();                entrar();            }            else{    // Si viene de cualquier otro lado:                _this.x = pX;                _this.y = pY;                _this.visible=true;            }        }				private function eventosRaton():void{			_this.mouseChildren = false;			_this.buttonMode = true;		}								public function entrar():void		{			_this.mouseEnabled = true;			_this.visible = true;			TweenMax.to(_this, 0.7, {x:_posX, delay:0.5, ease:Back.easeOut});			}				public function centrar(sexo:String):void		{			if(_this.name == sexo)			{				TweenMax.to(_this, 0.7, {x:_posCentral, delay:0.5, ease:Back.easeOut});			}		}				public function volver():void{			TweenMax.to(_this, 0.7, {x:_posXIni, delay:0.5, ease:Back.easeOut, onComplete:function():void{_this.removeChildAt(0);}});		}				public function vestirMuneco(objElemento:Object):void{						var elemento:Class;			var instancia:*;			if(objElemento.tipoPartes){					var mcPapa1:MovieClip;				var mcPapa2:MovieClip;				var mcPapa3:MovieClip;				if(objElemento.tipoPartes=='pantalon'){					mcPapa1=MovieClip(_muneco.personaje_mc.pieIzq_mc.piernaIzq_mc);					mcPapa2=MovieClip(_muneco.personaje_mc.cuerpo_mc.paquete_mc);					mcPapa3=MovieClip(_muneco.personaje_mc.pieDer_mc.piernaDer_mc);					if(mcPapa1.numChildren>0){						mcPapa1.removeChildAt(0);					}					if(mcPapa2.numChildren>0){						mcPapa2.removeChildAt(0);					}					if(mcPapa3.numChildren>0){						mcPapa3.removeChildAt(0);					}                    if(objElemento.name=='nada'){                        var interior:MovieClip;                        if(sexoActual=='0'){                            interior = new Braga_mc() as MovieClip;                            mcPapa2.addChild(interior);                            return;                        }else{                            interior = new Calzoncillos_mc() as MovieClip;                            mcPapa2.addChild(interior);                            return;                        }                    }                    if(objElemento.mc == 'falda_mc')                    {                        elemento = getDefinitionByName( objElemento.parte2 ) as Class;                        instancia= new elemento();                        mcPapa2.addChild(instancia);                    }                    else                    {                        elemento = getDefinitionByName( objElemento.parte1 ) as Class;                        instancia= new elemento();                        mcPapa1.addChild(instancia);                        elemento = getDefinitionByName( objElemento.parte2 ) as Class;                        instancia= new elemento();                        mcPapa2.addChild(instancia);                        elemento = getDefinitionByName( objElemento.parte3 ) as Class;                        instancia= new elemento();                        mcPapa3.addChild(instancia);                    }														}else if(objElemento.tipoPartes=='camisa'){					mcPapa1=MovieClip(_muneco.personaje_mc.cuerpo_mc.brazoIzq_mc.mangaIzq_mc);					mcPapa2=MovieClip(_muneco.personaje_mc.cuerpo_mc.camiseta_mc.torso_mc);					mcPapa3=MovieClip(_muneco.personaje_mc.cuerpo_mc.brazoDer_mc.mangaDer_mc);					if(mcPapa1.numChildren>0){						mcPapa1.removeChildAt(0);					}					if(mcPapa2.numChildren>0){						mcPapa2.removeChildAt(0);					}					if(mcPapa3.numChildren>0){						mcPapa3.removeChildAt(0);					}                    if(objElemento.name=='nada'){                        var interior:MovieClip;                        if(sexoActual=='0'){                            interior = new Sujetador_mc() as MovieClip;                            mcPapa2.addChild(interior);                            return;                        }else{                            return;                        }                    }                    if(objElemento.mc=='top_mc'){						elemento = getDefinitionByName( objElemento.parte2 ) as Class;						instancia= new elemento();						mcPapa2.addChild(instancia);					}else{						elemento = getDefinitionByName( objElemento.parte1 ) as Class;						instancia= new elemento();						mcPapa1.addChild(instancia);						elemento = getDefinitionByName( objElemento.parte2 ) as Class;						instancia= new elemento();						mcPapa2.addChild(instancia);						elemento = getDefinitionByName( objElemento.parte3 ) as Class;						instancia= new elemento();						mcPapa3.addChild(instancia);					}				}else if(objElemento.tipoPartes=='zapatos'){					mcPapa1=MovieClip(_muneco.personaje_mc.pieIzq_mc.zapatoIzq_mc);					mcPapa2=MovieClip(_muneco.personaje_mc.pieDer_mc.zapatoDer_mc);					if(mcPapa1.numChildren>0){						mcPapa1.removeChildAt(0);					}					if(mcPapa2.numChildren>0){						mcPapa2.removeChildAt(0);					}					if(objElemento.name=='nada'){return;}					elemento = getDefinitionByName( objElemento.parte1 ) as Class;					instancia= new elemento();					mcPapa1.addChild(instancia);					elemento = getDefinitionByName( objElemento.parte2 ) as Class;					instancia= new elemento();					mcPapa2.addChild(instancia);					/*instancia.tipoPartes='zapatos';					instancia.zapatoDer='zapatoDer_'+tipoElemento[1];					instancia.zapatoIzq='zapatoIzq_'+tipoElemento[1];*/										}				}else{						var mcPapa:MovieClip=MovieClip(_muneco.personaje_mc.cabeza_mc.getChildByName(objElemento.mc));										if(mcPapa.numChildren>0){						mcPapa.removeChildAt(0);					}										if(objElemento.name=='nada'){						return;					}										elemento = getDefinitionByName( objElemento.name ) as Class;					instancia= new elemento();										mcPapa.addChild(instancia);				}					}        // Cambiar Animación muñeco:        public function setAnimMuneco (anim:String=''){            for (var _i:int = 0; _i < _muneco.numChildren; _i++){                MovieClip(_muneco.getChildAt(_i)).gotoAndStop(1);                MovieClip(_muneco.getChildAt(_i)).visible = false;            }            if(anim != ''){                MovieClip(_muneco.getChildByName(anim)).visible = true;                MovieClip(_muneco.getChildByName(anim)).gotoAndPlay(1);                estado = _muneco.getChildByName(anim).name;            }            else{                MovieClip(_muneco.getChildByName('personaje_mc')).visible = true;                MovieClip(_muneco.getChildByName('personaje_mc')).gotoAndPlay(1);                estado = _muneco.getChildByName('personaje_mc').name;            }            Debug.trace('ESTADO = '+estado);        }        // Solo para Juego 1:        public function ponerCesta():void {            cesta=new Cesta_mc();            _muneco.personaje_mc.cuerpo_mc.contenedorCesta_mc.addChild(cesta);            cesta.gotoAndStop(1);            cesta=new Cesta_mc();            _muneco.personajeCaminando.cuerpo_mc.contenedorCesta_mc.addChild(cesta);            cesta.play();        }			}}