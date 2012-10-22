package views
{

import com.greensock.TweenMax;
import com.hexagonstar.util.debug.Debug;

import events.ConfiguradorEvent;

import flash.display.Bitmap;

import flash.display.BitmapData;
import flash.display.MovieClip;

import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Matrix;
import flash.geom.Rectangle;


public class MainView extends Sprite
{
		
		private var _interfaz:InterfazView;
		private var _menu_categorias:MenuCategoriasView;
		private var _submenu_categorias:SubMenuCategoriasView;
		private var _personajes:PersonajesView;
		private var _fondo:Fondo_mc;
		private var _this:MainView;
		private var _btn_volver:BtnVolverView;
		private var _btn_fin:BtnFinView;
		private var _muneco:MunecoView;
        private var btn_compartit:CompartirAvatar;
        private var btn_guardar:GuardarAvatar;
		private var _nombre:NombreView;
		private var _listaAmigos:AmigosListView;
		
		
		public function MainView() {
			_this = this;
			_this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			_this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// Añadimos las vistas principales al Stage

			_menu_categorias = new MenuCategoriasView();
			_this.addChild(_menu_categorias);
			_submenu_categorias = new SubMenuCategoriasView();
			_this.addChild(_submenu_categorias);
			_personajes = new PersonajesView();
			_this.addChild(_personajes);
			_btn_volver = new BtnVolverView();
			_this.addChild(_btn_volver);
			_btn_fin = new BtnFinView();
            _btn_fin.visible = false;
            _btn_fin.alpha = 0;
            _btn_fin.addEventListener(MouseEvent.CLICK, clicFin);
			_this.addChild(_btn_fin);
			_muneco = new MunecoView();
            _muneco.scaleX = _muneco.scaleY = 0.7;
			_this.addChild(_muneco);
			_nombre = new NombreView();
			_this.addChild(_nombre);


		}

        private function clicFin(e:MouseEvent):void
        {
            _btn_fin.removeEventListener(MouseEvent.CLICK, clicFin);

            _muneco.colocarCompartir();
            _btn_volver.capa();
            _btn_volver.addEventListener(MouseEvent.CLICK, clicVolver);
            _submenu_categorias.borrar();
            _menu_categorias.borrar();
            _nombre.borrar();

            TweenMax.to(_btn_fin, 0.5, {alpha: 0, scaleX: 0, scaleY: 0, onComplete: function(){


                btn_compartit = new CompartirAvatar();
                btn_compartit.x = (_this.width/2) - ((btn_compartit.width/2));
                btn_compartit.y = 440;
                btn_compartit.buttonMode = true;
                btn_compartit.scaleX = btn_compartit.scaleY = btn_compartit.alpha = 0;
                btn_compartit.addEventListener(Event.ADDED_TO_STAGE, initClip);
                btn_compartit.addEventListener(MouseEvent.CLICK, clicCompartir);
                _this.addChild(btn_compartit);


                btn_guardar = new GuardarAvatar();
                btn_guardar.x = (_this.width/2) + (btn_guardar.width);
                btn_guardar.y = 440;
                btn_guardar.scaleX = btn_guardar.scaleY = btn_guardar.alpha = 0;
                btn_guardar.buttonMode = true;
                btn_guardar.addEventListener(MouseEvent.CLICK, clicGuardar);
                btn_guardar.addEventListener(Event.ADDED_TO_STAGE, initClip);
                _this.addChild(btn_guardar);


            }});


            function initClip(e:Event):void
            {
                MovieClip(e.currentTarget).removeEventListener(Event.ADDED_TO_STAGE, initClip);

                TweenMax.to(MovieClip(e.currentTarget), 0.4, {alpha: 1, scaleY: 1, scaleX: 1});
            }
        }

    private function clicGuardar(e:MouseEvent):void
    {
        btn_compartit.removeEventListener(MouseEvent.CLICK, clicGuardar);

        _this.dispatchEvent(new ConfiguradorEvent(ConfiguradorEvent.GUARDAR_AVATAR));
    }

    private function clicCompartir(e:MouseEvent):void
    {

        btn_compartit.removeEventListener(MouseEvent.CLICK, clicCompartir);
        btn_compartit.buttonMode = false;

        var queco:Muneco_mc = new Muneco_mc();
        for(var i:uint = 0; i < _muneco.numChildren; i++)
        {
            if(_muneco.getChildAt(i) is Muneco_mc)
            {
                queco = Muneco_mc(_muneco.getChildAt(i));
            }
        }

        var per:Personaje_mc = Personaje_mc(queco.getChildByName('personaje_mc'));


        var rect : Rectangle = new Rectangle(0, 0, queco.width + 60, queco.height + 60);
        var matrix : Matrix = new Matrix();
        matrix.translate((queco.width/2) + 30, MovieClip(per.getChildByName('cabeza_mc')).height + 10);
        var bd: BitmapData = new BitmapData(rect.width, rect.height, false, 0xFFFFFF);
        bd.draw(queco, matrix, null, null, rect, true);
        var bm:Bitmap = new Bitmap(bd, 'auto', true);

        var evento:ConfiguradorEvent = new ConfiguradorEvent(ConfiguradorEvent.COMPARTIR_AVATAR);
        evento.datos = bm;
        _this.dispatchEvent(evento);
    }

    private function clicVolver(e:MouseEvent):void
    {
        _btn_volver.removeEventListener(MouseEvent.CLICK, clicVolver);
        _btn_volver.activa();

        btn_guardar.removeEventListener(MouseEvent.CLICK, clicGuardar);
        btn_compartit.removeEventListener(MouseEvent.CLICK, clicCompartir);

        TweenMax.to(btn_compartit, 0.4, {alpha: 0, scaleX: 0, scaleY: 0});
        TweenMax.to(btn_guardar, 0.4, {alpha: 0, scaleX: 0, scaleY: 0, onComplete: function(){
            _this.removeChild(btn_compartit);
            _this.removeChild(btn_guardar);

            _muneco.entrar();
            _submenu_categorias.entrar();
            _menu_categorias.entrar2();
            _nombre.entrar();

            _btn_fin.addEventListener(MouseEvent.CLICK, clicFin);
            TweenMax.to(_btn_fin, 0.4, {alpha: 1, scaleX: 1, scaleY: 1});
        }});
    }





        public function activaFinalizar():void
        {

            _btn_fin.scaleX = _btn_fin.scaleY = 0;
            _btn_fin.visible = true;
            TweenMax.to(_btn_fin, 0.4, {alpha: 1, scaleX: 1, scaleY: 1});
        }
		
	}
}