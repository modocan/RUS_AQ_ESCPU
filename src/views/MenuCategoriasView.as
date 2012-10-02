package views
{
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import com.hexagonstar.util.debug.Debug;
	
	import events.ConfiguradorEvent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class MenuCategoriasView extends MovieClip
	{
		private var _this:MenuCategoriasView;
		private var _interfaz_menu:MenuCategorias_mc;
		private var _posY:Number = 538;
		private var _posYIni:Number;
		private var _btn_select:String = 'btnPelo_mc';
		
		public function MenuCategoriasView()
		{
			_this = this;
			_this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			Debug.trace('init MenuCategoriasView');
			_this.removeEventListener(Event.ADDED_TO_STAGE, init);
			config();
		}
		
		private function config():void{
			_interfaz_menu = new MenuCategorias_mc();
			_this.addChild(_interfaz_menu);
			_this.y = stage.stageHeight + _this._interfaz_menu.height;
			_interfaz_menu.x = stage.stageWidth/2;
			_posYIni = _this.y;
		}
		
		public function entrar():void{
			_this.visible = true;
			TweenMax.to(_this, 0.7, {y:_posY, delay:1.5, ease:Expo.easeOut});
			setListeners();
		}
		
		private function setListeners():void{
			
			for(var i:int = 0; i < _interfaz_menu.botonera_mc.numChildren; i++){
				var _boton:MovieClip = MovieClip(_interfaz_menu.botonera_mc.getChildAt(i));
				_boton.buttonMode = true;
				_boton.gotoAndStop(1);
				_boton.addEventListener(MouseEvent.CLICK, clickEnBtnCategorias);
				_boton.addEventListener(MouseEvent.ROLL_OVER, sobre);
				_boton.addEventListener(MouseEvent.ROLL_OUT, fuera);
				if(_boton.name == 'btnPelos_mc'){
					_boton.gotoAndPlay('entrar');
					_boton.buttonMode = false;
				}
			}

		}
		
		public function borrar():void{
			TweenMax.to(_this, 0.7, {y:_posYIni, delay:0.5, ease:Back.easeOut, onComplete:function():void{_this.visible = false;}});
		}
		
		private function sobre(e:MouseEvent):void
		{
			if(e.currentTarget.buttonMode == true){
				e.currentTarget.gotoAndPlay('over');
			}
		}
		
		private function fuera(e:MouseEvent):void
		{
			if(e.currentTarget.buttonMode == true){
				if(e.currentTarget.currentFrame == 2){
					e.currentTarget.gotoAndStop(1);
				} else {
					e.currentTarget.gotoAndPlay('salir');
				}
			}	
		}
		
		private function activarBtn():void
		{
			for(var i:int = 0; i < _interfaz_menu.botonera_mc.numChildren; i++){
				var _boton:MovieClip = MovieClip(_interfaz_menu.botonera_mc.getChildAt(i));
				if(_btn_select != _boton.name && _boton.currentFrame > 1){
					_boton.gotoAndPlay('salir');
					_boton.buttonMode = true;
				}
			}
		}
		
		private function clickEnBtnCategorias(e:MouseEvent):void{
			Debug.trace('boton: '+e.currentTarget.name);
			if(e.currentTarget.buttonMode == true){
				e.currentTarget.buttonMode = false;
				e.currentTarget.gotoAndPlay('entrar');
				var evento:ConfiguradorEvent = new ConfiguradorEvent(ConfiguradorEvent.CLICK_EN_CATEGORIA);
				_btn_select = e.currentTarget.name;
				switch (_btn_select){
					case 'btnPelos_mc':
						Debug.trace(e.currentTarget.name);
						evento.datos = 'Pel';
					break;
					case 'btnBocas_mc':
						Debug.trace(e.currentTarget.name);
						evento.datos = 'Boc';
					break;
					case 'btnOjos_mc':
						Debug.trace(e.currentTarget.name);
						evento.datos = 'Ojo';
					break;
					case 'btnGafas_mc':
						Debug.trace(e.currentTarget.name);
						evento.datos = 'Gaf';
					break;
					case 'btnPantalones_mc':
						Debug.trace(e.currentTarget.name);
						evento.datos = 'Pan';
					break;
					case 'btnCamisas_mc':
						Debug.trace(e.currentTarget.name);
						evento.datos = 'Cam';
					break;
					case 'btnZapatos_mc':
						Debug.trace(e.currentTarget.name);
						evento.datos = 'Zap';
					break;
				}
				Debug.trace(_btn_select);
				
				_this.dispatchEvent(evento);
				activarBtn();
			}
			
		}
	}
}