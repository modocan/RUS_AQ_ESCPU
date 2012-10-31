package views
{



import com.hexagonstar.util.debug.Debug;
	
	import flash.display.MovieClip;
	import flash.events.Event;
import flash.events.MouseEvent;

public class AmigosListView extends MovieClip{
		private var _this:AmigosListView;
		private var interfaz:AmigosQueJugaron=new AmigosQueJugaron();
		private var _arrFinalAmigosQueJugaron:Array=new Array();
		private var _amigoQjugo:Object;
        private var maderaAmigo:MaderitaFoto_mc;
        private var cantidadAmigos:uint=0;
        private var nuevoX:uint=10;
        private var anchoContenedor:Number=0;
        private var tamanhoFoto:uint=106;
        private var mascaraFotos:MovieClip=new MovieClip();
        private var direccion:String;
        private var pararEnterFrame:Boolean=false;
		
		public function AmigosListView(){
			_this = this;
			_this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void{
			_this.removeEventListener(Event.ADDED_TO_STAGE, init);
			interfaz.y=620;
			interfaz.x=90;
			_this.addChild(interfaz);
            interfaz.flechaDer.visible=false;
            interfaz.flechaIzq.visible=false;


            interfaz.addChild(mascaraFotos);
            mascaraFotos.x=70;
            mascaraFotos.y=0;
            mascaraFotos.graphics.lineStyle();
            mascaraFotos.graphics.beginFill(0xFFFFFF,1);
            mascaraFotos.graphics.drawRect(0,0,530,120);
            mascaraFotos.graphics.endFill();

            interfaz.contenedorFotosAmigos_mc.mask=mascaraFotos;
        }
		
		public function pintarAmigos(amigos:Array,amigosTodos:Object):void{

			var amigosQjugaron:Array=amigos;
			var todosLosAmigos:Object=amigosTodos;
			
			for(var i:uint=0;i<todosLosAmigos.data.length;i++){
				var n:uint=0;
				if(todosLosAmigos.data[i].id==amigosQjugaron[0]){

					_amigoQjugo=new Object();
					_amigoQjugo.namename=todosLosAmigos.data[i].name;
					_amigoQjugo.id=todosLosAmigos.data[i].id;

                    cantidadAmigos++;

                    maderaAmigo=new MaderitaFoto_mc();
                    maderaAmigo.x = nuevoX;
                    interfaz.contenedorFotosAmigos_mc.addChild(maderaAmigo);
                    Debug.trace('......'+interfaz.contenedorFotosAmigos_mc.numChildren);
                    maderaAmigo.ponerFoto(_amigoQjugo);


                    nuevoX+=106;

					n++;
				}

			}

            interfaz.flechaDer.alpha=0.5;
            interfaz.flechaIzq.alpha=0.5;

            if(cantidadAmigos >5){
                interfaz.flechaDer.alpha=1;
                interfaz.flechaIzq.alpha=1;

                interfaz.flechaDer.addEventListener(MouseEvent.MOUSE_OVER, moverFotos);
                interfaz.flechaIzq.addEventListener(MouseEvent.MOUSE_OVER, moverFotos);

                interfaz.flechaDer.addEventListener(MouseEvent.MOUSE_OUT, pararMovimiento);
                interfaz.flechaIzq.addEventListener(MouseEvent.MOUSE_OUT, pararMovimiento);

                anchoContenedor=tamanhoFoto*cantidadAmigos;
            }
		}

        private function moverFotos(e:MouseEvent):void {   // ARREGLAR LOS LÍMITES Q ESTAN COMO EL ORTO!!!!!!!!!!!!!

           e.currentTarget.gotoAndStop(2);

           if(e.currentTarget.name=='flechaDer'){
               direccion='der';
               pararEnterFrame=false;

               if(interfaz.contenedorFotosAmigos_mc.x <= (530-Math.abs(interfaz.contenedorFotosAmigos_mc.width))+70){
                   pararEnterFrame=true;
                   pararMovimiento();
                   return;
               }

           }else if(e.currentTarget.name=='flechaIzq') {

               direccion='izq';
               pararEnterFrame=false;

               if(interfaz.contenedorFotosAmigos_mc.x>=60){
                   pararEnterFrame=true;
                   pararMovimiento();
                   return;

               }

           }

           this.addEventListener(Event.ENTER_FRAME, moverCont);
        }

        private function moverCont(e:Event):void{

            pararEnterFrame=false;
            if(direccion=='izq' && interfaz.contenedorFotosAmigos_mc.x>=60){
                pararEnterFrame=true;

            }
            if(direccion=='der' && interfaz.contenedorFotosAmigos_mc.x <= (530-Math.abs(interfaz.contenedorFotosAmigos_mc.width))+70){
                pararEnterFrame=true;

            }

            if(pararEnterFrame){
                pararMovimiento();
                return;
            }
            if(direccion=='izq'){
                interfaz.contenedorFotosAmigos_mc.x+=20;

            }else if(direccion=='der'){
                interfaz.contenedorFotosAmigos_mc.x-=20;

            }
        }

        private function pararMovimiento(e:MouseEvent=null):void{
            e.currentTarget.gotoAndStop(1);
            this.removeEventListener(Event.ENTER_FRAME, moverCont);
        }
		
	}
}