package  {
	
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import CronoEvents;
	import flash.events.Event;
	
	
	public class Crono extends MovieClip {
		
		private var timerCrono:Timer = new Timer(123,0);
		private var tiempoJuego:uint=0;
		var miliseg:int;
		var segundos:int;
		var minutos:int;
		var milisegCortado:int;
		var restoSegundos:int;
		
		public function Crono() {  // constructor code
			//iniciarCrono(40);
			
		}
		
		public function iniciarCrono(tiempo:Number){ // hay q pasarle el timepo q tiene que contar expresado en segundos.
			
			tiempoJuego=tiempo*1000;
			miliseg=tiempoJuego;

			timerCrono.addEventListener(TimerEvent.TIMER, cuentaAtras);
			timerCrono.start();
		}
		
		private function cuentaAtras(e:TimerEvent):void{
			
			segundos=miliseg/1000;
			
			minutos=Math.floor(segundos/60);

			segundos=segundos%60;
			

			milisegCortado=int(String(miliseg).substr(3,2));
			
			if(milisegCortado<10){
				this.txt_miliseg.text='0'+String(milisegCortado);
			}else{
				this.txt_miliseg.text=String(milisegCortado);
			}
			
			if(segundos<10){
				this.txt_segundos.text='0'+String(segundos);
			}else{
				this.txt_segundos.text=String(segundos);
			}
			
			if(minutos<10){
				this.txt_minutos.text='0'+String(minutos);
			}else{
				this.txt_minutos.text=String(minutos);
			}
			
			if(minutos==0){
				if(segundos==0){
					if(uint(milisegCortado)==0){
						pararCrono();
						return;
					}
				}
			}
			miliseg-=123;
	
		}
		
		public function pararCrono(){
			trace('parar crono!!!!');
			timerCrono.removeEventListener(TimerEvent.TIMER, cuentaAtras);
			timerCrono.stop();
			this.dispatchEvent(new CronoEvents(CronoEvents.TIEMPO_COMPLETO));
		}
	}
	
}
