package views
{

import com.demonsters.debugger.MonsterDebugger;
import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import com.hexagonstar.util.debug.Debug;
	
	import events.ConfiguradorEvent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	import flash.text.TextField;
	
	//import mx.logging.AbstractTarget;
	
	public class SubMenuCategoriasView extends MovieClip
	{
		private var _this:SubMenuCategoriasView;
		private var _submenu:Submenu_mc;
		private var _posXIni:Number;
		private var _posX:Number = 619;
		private var _posY:Number = 292;
		private var categoriaActual:String='boca_mc';
		private var categoriaAcargar:String;
		private var _ancho:Number;
		private var _alto:Number;
        private var _sex:Boolean =false;
		private var _pagSubmenuActual:uint;
		private var pagsCategoria:Number;
		private var ultimoElementoPag:uint;
		private var primerElementoPag:uint;
		private var pagActual:uint;
		private var flechaDer:Boolean=false;
		private var flechaIzq:Boolean=false;
		
		private var _arrElementosBocas:Array = new Array(
															["1","Boca_1"]
															,["1","Boca_2"]
															,["1","Boca_3"]
															,["1","Boca_4"]
															,["1","Boca_5"]
															,["1","Boca_6"]
															,["1","Boca_7"]
															,["1","Boca_8"]
															,["1","Boca_9"]
															,["1","Boca_10"]
															,["1","Boca_11"]
														);
		
		private var _arrElementosPelos:Array = new Array(

															["1","Pelo_1"]
															,["1","Pelo_2"]
															,["1","Pelo_3"]								
															,["1","Pelo_4"]
															,["1","Pelo_5"]
															,["1","Pelo_6"]
															,["1","Pelo_7"]
															,["1","Pelo_8"]
															,["1","Pelo_9"]
														);
		
		private var _arrElementosOjos:Array = new Array(
															["1","Ojos_1"]
															,["1","Ojos_2"]
															,["1","Ojos_3"]								
															,["1","Ojos_4"]
															,["1","Ojos_5"]
															,["1","Ojos_6"]
															,["1","Ojos_7"]
															,["1","Ojos_8"]
															,["1","Ojos_9"]
															,["1","Ojos_10"]
															,["1","Ojos_11"]								
															,["1","Ojos_12"]
															,["1","Ojos_13"]
															
														);
		
		private var _arrElementosCamisas:Array = new Array(
																["1","Camisa_1"]
																,["1","Camisa_2"]
																,["1","Camisa_3"]								
																,["1","Camisa_4"]
																,["1","Camisa_5"]
																,["1","Camisa_6"]
																,["1","Camisa_7"]
																,["1","Camisa_8"]
																,["1","Camisa_9"]
																,["1","Camisa_10"]
																,["1","Camisa_11"]
																,["1","Camisa_12"]
																,["1","Camisa_13"]
																,["1","Camisa_14"]
																,["1","Camisa_15"]
																,["1","Top_1"]
																,["1","Top_2"]
															);
			
		private var _arrElementosPantalones:Array = new Array(
																["1","Pantalon_1"]
																,["1","Pantalon_2"]
																,["1","Pantalon_3"]								
																,["1","Pantalon_4"]
																,["1","Pantalon_5"]
																,["1","Pantalon_6"]
																,["1","Pantalon_7"]
																,["1","Pantalon_8"]
																,["1","Pantalon_9"]
																,["1","Pantalon_10"]
																,["1","Pantalon_11"]
																,["1","Pantalon_12"]
																,["1","Pantalon_13"]
																,["1","Pantalon_14"]
																,["1","Pantalon_15"]
																,["1","Pantalon_16"]
																,["1","Pantalon_17"]
																,["1","Pantalon_18"]
															);
		
		private var _arrElementosZapatos:Array = new Array(
																["1","Zapato_1"]
																,["1","Zapato_2"]
																,["1","Zapato_3"]								
																,["1","Zapato_4"]
															);

		private var _arrElementosGafas:Array = new Array(
															["1","Gafas_1"]
														);
		private var _arrElementos:Array = new Array();
		

		public function SubMenuCategoriasView(){
			_this = this;
			_this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void{
			_this.removeEventListener(Event.ADDED_TO_STAGE, init);
			config();
		}
		
		private function config():void{
			_this.visible = false;
			_this.y = _posY;
			_submenu = new Submenu_mc();
			_this.addChild(_submenu);
			_this.x = stage.stageWidth + _this.width;
			_posXIni = _this.x;
		}

		
		public function cargarSubmenu(datos:Object):void{
			//_arrElementos=datos

            trace('LOS CARGO!');

            MonsterDebugger.trace(this, '[DATOS ELEMENTOS]');
            MonsterDebugger.trace(this, datos);

            llenarArrays(datos);

            _sex = false;

			pintarElementos('Pel', undefined);
		}

        private function llenarArrays(_data:Object):void
        {
            _arrElementosBocas = _data.bocas as Array;
            _arrElementosCamisas = _data.camisas as Array;
            _arrElementosGafas = _data.gafas as Array;
            _arrElementosOjos = _data.ojos as Array;
            _arrElementosPantalones = _data.pantalones as Array;
            _arrElementosPelos = _data.pelos as Array;
            _arrElementosZapatos = _data.zapatos as Array;
        }
		
		public function pintarElementos(cat:Object,numC:uint=undefined):void{

			var numCont:uint=0;
			if(numC){
                trace('paso 1');
				ultimoElementoPag=numC+8;
				primerElementoPag=numC;
				if(pagActual==1){
					_submenu.interfaz_submenu_mc.subMenuFlechaIzq_mc.gotoAndPlay('entrar');
					_submenu.interfaz_submenu_mc.subMenuFlechaIzq_mc.removeEventListener(MouseEvent.CLICK, cambiarPagSubmenu);
					flechaIzq=false;
				}else if(pagActual==pagsCategoria){
					_submenu.interfaz_submenu_mc.sunMenuFlechaDer_mc.gotoAndPlay('entrar');
					_submenu.interfaz_submenu_mc.sunMenuFlechaDer_mc.removeEventListener(MouseEvent.CLICK, cambiarPagSubmenu);
					flechaDer=false;
				}
			}else{
                trace('paso 2');
				if(categoriaActual==cat && _sex){
					return;
				}
                _sex = false;
				categoriaActual=String(cat);
				var textoOpc:TextField=_submenu.interfaz_submenu_mc.txt_opciones;	
				textoOpc.alpha=0;
				Debug.trace('----'+categoriaActual);
				if(categoriaActual=='Pel'){
					_arrElementos=_arrElementosPelos;
					//_arrElementos.splice(0,0, new Array(['0','Nada_mc']));
					if(_arrElementos[0][1]!='Nada_mc'){
						_arrElementos.unshift(['0','Nada_mc']);
					}
					Debug.trace(_arrElementos);
					textoOpc.text='PEINADOS';
				}else if(categoriaActual=='Boc'){
					_arrElementos=_arrElementosBocas;
					textoOpc.text='BOCAS';
				}else if(categoriaActual=='Cam'){
					_arrElementos=_arrElementosCamisas;
                    if(_arrElementos[0][1]!='Nada_mc'){
                        _arrElementos.unshift(['0','Nada_mc']);
                    }
					textoOpc.text='CAMISAS';
				}else if(categoriaActual=='Pan'){
					_arrElementos=_arrElementosPantalones;
					if(_arrElementos[0][1]!='Nada_mc'){
						_arrElementos.unshift(['0','Nada_mc']);
					}
					textoOpc.text='PANTALONES';
				}else if(categoriaActual=='Gaf'){
					_arrElementos=_arrElementosGafas;
					textoOpc.text='GAFAS';
					if(_arrElementos[0][1]!='Nada_mc'){
						_arrElementos.unshift(['0','Nada_mc']);
					}
				}else if(categoriaActual=='Ojo'){
					_arrElementos=_arrElementosOjos;
					textoOpc.text='OJOS';
				}else if(categoriaActual=='Zap'){
					_arrElementos=_arrElementosZapatos;
					textoOpc.text='ZAPATOS';
					if(_arrElementos[0][1]!='Nada_mc'){
						_arrElementos.unshift(['0','Nada_mc']);
					}
				}
				
				TweenMax.to(textoOpc, 0.3, {alpha:1, ease:Expo.easeOut, delay:0.1});
				pagsCategoria=Math.ceil(_arrElementos.length/9);
				if(pagsCategoria>1 && !flechaDer){
					_submenu.interfaz_submenu_mc.sunMenuFlechaDer_mc.gotoAndPlay('salir');
					_submenu.interfaz_submenu_mc.sunMenuFlechaDer_mc.addEventListener(MouseEvent.CLICK, cambiarPagSubmenu);
					flechaDer=true;
				}else if(pagsCategoria==1 && flechaDer){
					_submenu.interfaz_submenu_mc.sunMenuFlechaDer_mc.gotoAndPlay('entrar');
					_submenu.interfaz_submenu_mc.sunMenuFlechaDer_mc.removeEventListener(MouseEvent.CLICK, cambiarPagSubmenu);
					flechaDer=false;
				}
				
				
				if(flechaIzq){
					_submenu.interfaz_submenu_mc.subMenuFlechaIzq_mc.gotoAndPlay('entrar');
					_submenu.interfaz_submenu_mc.subMenuFlechaIzq_mc.removeEventListener(MouseEvent.CLICK, cambiarPagSubmenu);
					flechaIzq=false;
				}

				pagActual=1;
				ultimoElementoPag=9;
				primerElementoPag=1;

                MonsterDebugger.trace(this, '[ELEMENTOS]');
                MonsterDebugger.trace(this, _arrElementos);

			}

			for(var n:uint=1;n<=9;n++){
				Debug.trace(MovieClip(_submenu.interfaz_submenu_mc.getChildByName('contenedorImg_0'+n)).contenedorPaElemento_mc.numChildren);
				if(MovieClip(_submenu.interfaz_submenu_mc.getChildByName('contenedorImg_0'+n)).contenedorPaElemento_mc.numChildren>0){
					MovieClip(_submenu.interfaz_submenu_mc.getChildByName('contenedorImg_0'+n)).contenedorPaElemento_mc.removeChildAt(0);
					MovieClip(_submenu.interfaz_submenu_mc.getChildByName('contenedorImg_0'+n)).celditaRopa_mc.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
					MovieClip(_submenu.interfaz_submenu_mc.getChildByName('contenedorImg_0'+n)).celditaRopa_mc.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
					MovieClip(_submenu.interfaz_submenu_mc.getChildByName('contenedorImg_0'+n)).removeEventListener(MouseEvent.CLICK, elementoElegido);
					
				}
			}
			
			Debug.trace('_arrElementos.length: '+_arrElementos.length);
			for(var i:uint=0;i<_arrElementos.length;i++){
				categoriaAcargar=String(_arrElementos[i][1]).substr(0,3);
				if(i<primerElementoPag-1){
					Debug.trace('todavia no lllego al primero q tiene q pintar!');
				}else{
					numCont++;
					var contenedor:MovieClip=MovieClip(_submenu.interfaz_submenu_mc.getChildByName('contenedorImg_0'+numCont));
					var contenedorAspectRatio:Number;
					var instanciaAspectRatio:Number;

					var elemento:Class = getDefinitionByName( _arrElementos[i][1]) as Class;
					var instancia:*= new elemento();

					var contenedorWidth:uint=43;
					var contenedorHeight:uint=44;
					var instanciaWidth:uint;
					var instanciaHeight:uint;

					if(instancia.width>contenedorWidth-10){
						instanciaWidth=Math.floor(contenedorWidth-10);
						instanciaHeight=Math.floor(instancia.height*instanciaWidth/instancia.width);
						instancia.height=instanciaHeight;
						instancia.width=instanciaWidth;
						//Debug.trace('instancia.width: '+instancia.width);
						//Debug.trace('instancia.height: '+instancia.height);
						if(instancia.height>contenedorHeight-2){
							instanciaHeight=Math.floor(contenedorHeight-10);
							instanciaWidth=Math.floor(instancia.width*instanciaHeight/instancia.height);
							instancia.height=instanciaHeight;
							instancia.width=instanciaWidth;
							//Debug.trace('nuevo instancia.width: '+instancia.width);
							//Debug.trace('nuevo instancia.height: '+instancia.height);
						}
					}
					
					instancia.alpha = 0;
					instancia.width = 0.1;
					instancia.height = 0.1;
					if(contenedor){
						contenedor.contenedorPaElemento_mc.addChild(instancia);
						contenedor.celditaRopa_mc.gotoAndStop('out');
					}
					TweenMax.to(instancia, 0.7, {alpha:1, width:instanciaWidth, height:instanciaHeight, ease:Expo.easeOut, delay:0.1*numCont});
					instancia.id=_arrElementos[i][0];
					instancia.name=_arrElementos[i][1];
					Debug.trace('instancia.name es: '+instancia.name);
					
					var tipoElemento:Array=_arrElementos[i][1].split('_');
					instancia.mc=tipoElemento[0].toLowerCase()+'_mc';

                    if(tipoElemento[0]=='Camisa'){
                        instancia.tipoPartes='camisa';
                        instancia.parte1='BrazoIzq_'+tipoElemento[1];
                        instancia.parte2='Torso_'+tipoElemento[1];
                        instancia.parte3='BrazoDer_'+tipoElemento[1];
                    }else if(tipoElemento[0]=='Top'){
                        instancia.tipoPartes='camisa';
                        instancia.parte2=_arrElementos[i][1];
                    }else if(tipoElemento[0]=='Pantalon'){
                        instancia.tipoPartes='pantalon';
                        instancia.parte1='PiernaIzq_'+tipoElemento[1];
                        instancia.parte2='Paquete_'+tipoElemento[1];
                        instancia.parte3='PiernaDer_'+tipoElemento[1];
                    }else if(tipoElemento[0]=='Falda'){
                        instancia.tipoPartes='pantalon';
                        instancia.parte2=_arrElementos[i][1];
                    }else if(tipoElemento[0]=='Zapato'){
                        instancia.tipoPartes='zapatos';
                        instancia.parte1='ZapatoIzq_'+tipoElemento[1];
                        instancia.parte2='ZapatoDer_'+tipoElemento[1];
                    }else if(tipoElemento[0]=='Nada'){
                        if(categoriaActual=='Gaf'){
                            instancia.mc='gafas_mc'
                            instancia.name='nada';
                        }else if(categoriaActual=='Pel'){
                            instancia.mc='pelo_mc'
                            instancia.name='nada';
                        }else if(categoriaActual=='Cam'){
                            instancia.tipoPartes='camisa';
                            instancia.name='nada';
                        }else if(categoriaActual=='Zap'){
                            instancia.tipoPartes='zapatos';
                            instancia.name='nada';
                        }else if(categoriaActual=='Pan'){
                            instancia.tipoPartes='pantalon';
                            instancia.name='nada';
                        }
                    }

					/*if(tipoElemento[0]=='Camisa'){
						instancia.tipoPartes='camisa';
						instancia.parte1='BrazoIzq_'+tipoElemento[1];
						instancia.parte2='Torso_'+tipoElemento[1];
						instancia.parte3='BrazoDer_'+tipoElemento[1];
					}else if(tipoElemento[0]=='Top'){
						instancia.tipoPartes='camisa';
						instancia.parte2=_arrElementos[i][1];
					}else if(tipoElemento[0]=='Pantalon'){
						instancia.tipoPartes='pantalon';
						instancia.parte1='PiernaIzq_'+tipoElemento[1];
						instancia.parte2='Paquete_'+tipoElemento[1];
						instancia.parte3='PiernaDer_'+tipoElemento[1];
					}else if(tipoElemento[0]=='Zapato'){
						instancia.tipoPartes='zapatos';
						instancia.parte1='ZapatoIzq_'+tipoElemento[1];
						instancia.parte2='ZapatoDer_'+tipoElemento[1];
					}else if(tipoElemento[0]=='Nada'){
						if(categoriaActual=='Gaf'){
							instancia.mc='gafas_mc'
							instancia.name='nada';
						}else if(categoriaActual=='Pel'){
							instancia.mc='pelo_mc'
							instancia.name='nada';
						}else if(categoriaActual=='Cam'){
							instancia.tipoPartes='camisa';
							instancia.name='nada';
						}else if(categoriaActual=='Zap'){
							instancia.tipoPartes='zapatos';
							instancia.name='nada';
						}
					}*/
					
					if(contenedor){
						contenedor.celditaRopa_mc.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
						contenedor.celditaRopa_mc.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
						contenedor.addEventListener(MouseEvent.CLICK, elementoElegido);
					}

					if(numCont>ultimoElementoPag){
						Debug.trace('Llego al ultimo elemento!');
						return;
					}
				}
				
					
			}
			for(var c:uint=1;c<=9;c++){
				if(MovieClip(_submenu.interfaz_submenu_mc.getChildByName('contenedorImg_0'+c)).contenedorPaElemento_mc.numChildren==0){
					MovieClip(_submenu.interfaz_submenu_mc.getChildByName('contenedorImg_0'+c)).celditaRopa_mc.gotoAndStop('sinElem');
				}
			}
			
		}
			
		private function elementoElegido(e:MouseEvent):void{
			var arrDatosElemento:Object=new Object();

            MonsterDebugger.trace(this, '[PASO1]');
			arrDatosElemento.name=e.currentTarget.contenedorPaElemento_mc.getChildAt(0).name;
            MonsterDebugger.trace(this, '[PASO2]');
			arrDatosElemento.id=e.currentTarget.contenedorPaElemento_mc.getChildAt(0).id;
            MonsterDebugger.trace(this, '[PASO3]');
			arrDatosElemento.mc=e.currentTarget.contenedorPaElemento_mc.getChildAt(0).mc;
            MonsterDebugger.trace(this, '[PASO4]');
			if(e.currentTarget.contenedorPaElemento_mc.getChildAt(0).tipoPartes){
                MonsterDebugger.trace(this, '[PASO5]');

                MonsterDebugger.trace(this, e.currentTarget.contenedorPaElemento_mc.getChildAt(0));

                MonsterDebugger.trace(this, '[PASO6]');


				arrDatosElemento.tipoPartes=e.currentTarget.contenedorPaElemento_mc.getChildAt(0).tipoPartes;
                if(e.currentTarget.contenedorPaElemento_mc.getChildAt(0).parte1)
                {
                    arrDatosElemento.parte1=e.currentTarget.contenedorPaElemento_mc.getChildAt(0).parte1;
                }

                if(e.currentTarget.contenedorPaElemento_mc.getChildAt(0).parte2)
                {
                    arrDatosElemento.parte2=e.currentTarget.contenedorPaElemento_mc.getChildAt(0).parte2;
                }

                if(e.currentTarget.contenedorPaElemento_mc.getChildAt(0).parte3){
					arrDatosElemento.parte3=e.currentTarget.contenedorPaElemento_mc.getChildAt(0).parte3;
				}
				
				
			}

            MonsterDebugger.trace(this, '[ARRAY ELEM]');
            MonsterDebugger.trace(this, arrDatosElemento);

			var evento:ConfiguradorEvent = new ConfiguradorEvent(ConfiguradorEvent.CLICK_EN_ELEMENTO);
			evento.datos = arrDatosElemento;
			_this.dispatchEvent(evento);
		
		}
		
		private function cambiarPagSubmenu(e:MouseEvent):void{
			var primerEl:uint;
			if(e.currentTarget.name=='sunMenuFlechaDer_mc'){
				primerEl=ultimoElementoPag+1;
				pagActual++;
				if(!flechaIzq){
					_submenu.interfaz_submenu_mc.subMenuFlechaIzq_mc.gotoAndPlay('salir');
					_submenu.interfaz_submenu_mc.subMenuFlechaIzq_mc.addEventListener(MouseEvent.CLICK, cambiarPagSubmenu);
					flechaIzq=true;
				}
				pintarElementos(categoriaActual,primerEl);
			}else if(e.currentTarget.name=='subMenuFlechaIzq_mc'){
				primerEl=primerElementoPag-9;
				pagActual--;
				if(!flechaDer){
					_submenu.interfaz_submenu_mc.sunMenuFlechaDer_mc.gotoAndPlay('salir');
					_submenu.interfaz_submenu_mc.sunMenuFlechaDer_mc.addEventListener(MouseEvent.CLICK, cambiarPagSubmenu);
					flechaDer=true;
				}
				pintarElementos(categoriaActual,primerEl);
			}
		}

        public function activaFinalizar():void
        {

        }
		
		public function entrar():void{
			_this.visible = true;
			TweenMax.to(_this, 0.7, {x:_posX, delay:0.5, ease:Expo.easeOut});
		}
		
		public function borrar():void{
			TweenMax.to(_this, 0.7, {x:_posXIni, delay:0.5, ease:Back.easeOut, onComplete:function():void{_this.visible = false;}});
		}
		
		private function onMouseOver(e:MouseEvent):void{
			e.currentTarget.gotoAndStop('on');
		}
		
		private function onMouseOut(e:MouseEvent):void{
			e.currentTarget.gotoAndStop('out');
		}
		
		
		
	}
}