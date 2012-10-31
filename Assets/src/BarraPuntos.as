﻿package  {		import flash.display.MovieClip;		import gs.TweenMax;	import gs.easing.Expo;	import com.hexagonstar.util.debug.Debug;	import BarraEvents;		public class BarraPuntos extends MovieClip {		private var anchoMascara:Number=0;		private var masc:MovieClip;		private var nuevoAncho:Number=0;		private var finPuntos:Boolean=false;				private const UN_PUNTO:Number=10.5; // Así son 20 puntos en total!				public function BarraPuntos() { // constructor code			this.stop();			masc=MovieClip(this.getChildByName('mascara_mc'));			anchoMascara=masc.width;		}				public function punto(cant:Number=0):void{			if(masc.width>=210){return;}			finPuntos=false;			var puntos:Number=UN_PUNTO;			if(cant!=1){			 puntos=puntos*cant;			}			nuevoAncho=masc.width+puntos;			TweenMax.to(masc, 0.5, {width:nuevoAncho,ease:Expo.easeOut});			if(nuevoAncho>=210){				finPuntos=true;				this.dispatchEvent(new BarraEvents(BarraEvents.PUNTOS_COMPLETOS));			}		}				public function quitarPunto(cant:uint=0):void{			if(masc.width<=3){return;}			var puntos:Number=UN_PUNTO;			if(cant!=0){			 puntos=puntos*cant;			}			nuevoAncho=masc.width-puntos;			TweenMax.to(masc, 2, {width:nuevoAncho,ease:Expo.easeOut});		}				public function puntosFinales():String{			var puntosFinales:uint=uint(masc.width);			var puntuacion:String='';			if(puntosFinales<37){				puntuacion='muy_deficiente';			}else if(puntosFinales<71){				puntuacion='insuficiente';			}else if(puntosFinales<105){				puntuacion='suficiente';			}else if(puntosFinales<139){				puntuacion='bien';			}else if(puntosFinales<174){				puntuacion='notable';			}else if(puntosFinales<208){				puntuacion='sobresaliente';			}			return puntuacion;		}	}	}