/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 20/09/12
 * Time: 12:49
 * To change this template use File | Settings | File Templates.
 */
package {
import com.demonsters.debugger.MonsterDebugger;
import com.hexagonstar.util.debug.Debug;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;

public class Juego1View extends Sprite {

            private var muneco:Muneco_mc;
            private var teclaPulsada:Boolean=false;
            private var direccionMuneco:String;
            private var vel:uint=9;
            private var arr_gallinas:Array=new Array();
            private var arr_huevos:Array= new Array();
            private var arr_huevosSuelo:Array=new Array();


            private const NUM_GALLINAS:uint=8;

            private var timerAnimaciones:uint=0;
            private var munecoCaminando:Boolean=false;


            public function Juego1View() {


                MonsterDebugger.initialize(this);

                this.addEventListener(Event.ADDED_TO_STAGE, init);

                super();

            }

            private function init(e:Event):void {

                Debug.trace('Instancio');
                MonsterDebugger.trace(this, 'Juego1');

                pintarJuego({});

                this.removeEventListener(Event.ADDED_TO_STAGE, init);
                this.dispatchEvent(new Juego1Event(Juego1Event.JUEGO_CREADO));
                stage.addEventListener(KeyboardEvent.KEY_DOWN, teclaPresionada);
                stage.addEventListener(KeyboardEvent.KEY_UP, teclaNoPresionada);
            }

            public function pintarJuego(datos:Object){

                // Poner todas las cosas!!!!

                var fondo:FondoGallinero = new FondoGallinero();
                fondo.x = 0;
                fondo.y = 0;
                addChild(fondo);

                pintarGallinas();
                crearMuneco(datos);
                iniciarJuego();

            }


            private function iniciarJuego():void {

                addEventListener(Event.ENTER_FRAME, track)

            }

            private function teclaPresionada(e:KeyboardEvent):void {

                if(e.keyCode==39){
                    direccionMuneco='d';
                    teclaPulsada=true;
                    if(!munecoCaminando){
                        muneco.setAnimMuneco('personajeCaminando');
                        munecoCaminando=true;
                    }
                }else if(e.keyCode==37){
                    direccionMuneco='i';
                    teclaPulsada=true;
                    if(!munecoCaminando){
                        muneco.setAnimMuneco('personajeCaminando');
                        munecoCaminando=true;
                    }
                }else{
                    teclaPulsada=false;
                    direccionMuneco='';
                    if(munecoCaminando){
                        muneco.setAnimMuneco('');
                        munecoCaminando=false;
                    }
                }
            }

            private function teclaNoPresionada(e:KeyboardEvent):void {
                if(teclaPulsada && direccionMuneco==''){return;}
                teclaPulsada=false;
                direccionMuneco='';
                if(munecoCaminando){
                    muneco.setAnimMuneco('');
                    munecoCaminando=false;
                }
            }



            public function crearMuneco(datos:Object):void{
                muneco=new Muneco_mc();
                muneco.config('1',400,440);
                muneco.ponerCesta();
                //muneco.addEventListener(Event.ADDED_TO_STAGE)
                addChild(muneco);
                muneco.width = 120;
                muneco.height = 212;
            }

            private function pintarGallinas():void {

                for(var i:uint=0; i<NUM_GALLINAS;i++){
                    var gallina:Gallina = new Gallina();
                    arr_gallinas.push(gallina);
                    gallina.x =Math.floor(Math.random()*750+40);
                    gallina.y=85;
                    gallina.addEventListener(Event.ADDED_TO_STAGE, initGallina);
                    addChild(gallina);

                 }

                function initGallina(e:Event):void
                {
                    e.currentTarget.removeEventListener(Event.ADDED_TO_STAGE, initGallina);
                    Gallina(e.currentTarget).anima();

                }

            }

            private function track(e:Event):void{

                // Mover muñeco:

                if(teclaPulsada){
                    var velocidad:Number =vel;

                    if(muneco.x > 50 && direccionMuneco=='i'){
                        velocidad = vel*-1;
                        muneco.x = muneco.x+ velocidad;
                    }
                    if(muneco.x < 750 && direccionMuneco=='d'){
                        muneco.x = muneco.x+ velocidad;
                    }

                }

                //-------------------------


                // Mover Gallinas:

                for(var _g:uint=0; _g<arr_gallinas.length; _g++){

                    if(Gallina(arr_gallinas[_g]).estado=='gallinaCaminaDer'){
                        if(Gallina(arr_gallinas[_g]).x>=700){
                            Gallina(arr_gallinas[_g]).anima('');
                        } else{
                            arr_gallinas[_g].x=arr_gallinas[_g].x+5;
                        }


                    }else if(Gallina(arr_gallinas[_g]).estado=='gallinaCaminaIzq'){
                        if(Gallina(arr_gallinas[_g]).x<=50){
                            Gallina(arr_gallinas[_g]).anima('');
                        } else{
                            arr_gallinas[_g].x=arr_gallinas[_g].x-5;
                        }
                    }

                    //-------------------------

                    // Mira si alguna gallona tiene que tirar un huevo para crear el nuevo huevo:

                    if(Gallina(arr_gallinas[_g]).tirar){
                        arr_gallinas[_g].tirar=false;
                        //Debug.trace('vino al for pa tirar el puto huevo');
                        var huevo:Huevo = new Huevo();
                        huevo.x = arr_gallinas[_g].x + 60;
                        huevo.y = arr_gallinas[_g].y + 80;
                        arr_huevos.push(huevo);
                        Gallina(arr_gallinas[_g]).gotoAndPlay(1);
                        addChild(huevo);
                    }

                    // Cambiar animacion de las gallinas:

                    if(timerAnimaciones==30){
                        if(!Gallina(arr_gallinas[_g]).tirar){
                            Gallina(arr_gallinas[_g]).anima('');
                        }
                    }
                }

                //-------------------------

                // Mover y parar huevos:

                if(timerAnimaciones==30){
                    //Debug.trace('desde el enter frame llamo a tirar huevos!!!');
                    tirarHuevos();
                    timerAnimaciones=0;
                }
                timerAnimaciones++;

                for(var h:uint = 0;h<arr_huevos.length;h++){
                    if(arr_huevos[h]){ // si el huevo esta cayendo...
                        arr_huevos[h].y += 8; // incrementa el Y
                        if(arr_huevos[h].y>=520){  // Si ya llegó al suelo lo saca del array.
                            arr_huevos[h].chocarYromper();
                            arr_huevosSuelo.push(new Array(arr_huevos[h],0));
                            arr_huevos.splice(h,1);
                        }
                    }

                //-------------------------

                //Detecta colisión con cesta:

                    if(arr_huevos[h]){
                        if(muneco.cesta.zonaColision_mc.hitTestObject(arr_huevos[h])){
                            //Debug.trace('colisionnnnnn!!!!!!!!!!!!!!!!!! :)');
                            //Debug.trace('---'+arr_huevos[h]);
                            colision(h);
                        }
                    }


                }

                //-------------------------

                //Borra huevos piso:

                for(var hue:int=0; hue<arr_huevosSuelo.length;hue++){
                    arr_huevosSuelo[hue][1]++;
                    if(arr_huevosSuelo[hue][1]==48){
                        arr_huevosSuelo[hue][0].gotoAndPlay('desaparecer');
                    }

                    if(!arr_huevosSuelo[hue][0]._visible){
                        removeChild(arr_huevosSuelo[hue][0]);
                        arr_huevosSuelo.splice(hue,1);
                    }
                }


            } //------------------------- FIN TRACK!


            private function colision(hue:uint):void {
                this.removeChild(arr_huevos[hue]);
                //Debug.trace('----------'+arr_huevos[hue]);
                arr_huevos.splice(hue,1);
            }

            private function tirarHuevos():void {
                for(var g:uint = 0;g<arr_gallinas.length;g++){
                    var num:uint=Math.floor(Math.random()*10);
                    //Debug.trace('el random pa ver que gallina tira huevo es: '+num)
                    if(num==5 || num==8){
                        //Debug.trace('entro a tirar huevo!', Debug.LEVEL_FATAL)
                        Gallina(arr_gallinas[g]).anima('gallinaAleteo');
                        break;
                    }
                }
            }




    }
}