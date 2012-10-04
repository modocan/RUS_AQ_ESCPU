package  {
	
	import flash.display.MovieClip;
	
	import gs.TweenMax;
	import gs.easing.Expo;
	import com.hexagonstar.util.debug.Debug;
	import BarraEvents;
	
	public class BarraPuntos extends MovieClip {
		private var anchoMascara:Number=0;
		private var masc:MovieClip;
		private var nuevoAncho:Number=0;
		private var finPuntos:Boolean=false;
		
		private const UN_PUNTO:Number=10.5; // Así son 20 puntos en total!
		
		public function BarraPuntos() { // constructor code
			this.stop();
			masc=MovieClip(this.getChildByName('mascara_mc'));
			anchoMascara=masc.width;
		}
		
		public function punto(cant:uint){
			if(masc.width>=210){return;}
			finPuntos=false;
			var puntos:Number=UN_PUNTO;
			Debug.trace('anoto punto!!!');
			if(cant!=1){
			 Debug.trace('cantidad Puntos: '+cant);
			 puntos=puntos*cant;
			}
			nuevoAncho=masc.width+puntos;
			TweenMax.to(masc, 0.5, {width:nuevoAncho,ease:Expo.easeOut});
			if(nuevoAncho>=210){
				Debug.trace('PUNTOS COMPLETOS!!!!!');
				finPuntos=true;
				this.dispatchEvent(new BarraEvents(BarraEvents.PUNTOS_COMPLETOS));
			}
		}
		
		public function quitarPunto(cant:uint=0){
			if(masc.width<=3){return;}
			var puntos:Number=UN_PUNTO;
			if(cant!=0){
			 puntos=puntos*cant;
			}
			nuevoAncho=masc.width-puntos;
			TweenMax.to(masc, 2, {width:nuevoAncho,ease:Expo.easeOut});
		}
	}
	
}
