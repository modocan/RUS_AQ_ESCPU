package views
{
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import com.hexagonstar.util.debug.Debug;
	
	import events.ConfiguradorEvent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class BtnFinView extends MovieClip
	{
		private var _this:BtnFinView;
		private var _btn_fin:Btn_fin_mc;
		private var _posYIni:Number;
		private var _posX:Number = 715;
		private var _posY:Number = 560;
		
		public function BtnFinView()
		{
			_this = this;
			_this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			Debug.trace('init BtnFinView');
			_this.removeEventListener(Event.ADDED_TO_STAGE, init);
			config();
		}
		
		private function config():void{
			_this.visible = false;
			_btn_fin = new Btn_fin_mc();
			_this.addChild(_btn_fin);
			_this.x = _posX;
			_this.mouseChildren = false;
			_this.buttonMode = true;
			_this.addEventListener(MouseEvent.ROLL_OVER,rollOver);
			_this.addEventListener(MouseEvent.ROLL_OUT,rollOut);
			_this.addEventListener(MouseEvent.CLICK,onClick);
			_this.y = stage.stageHeight + _this.height;
			_posYIni = _this.y;
		}
		
		private function rollOver(e:MouseEvent):void{
			//TweenMax.to(_this._personaje.texto_txt, 0.7, {alpha:1, ease:Expo.easeOut});
		}
		
		private function rollOut(e:MouseEvent):void{
			//TweenMax.to(_this._personaje.texto_txt, 0.7, {alpha:0, ease:Expo.easeOut, onComplete:function(){_this._personaje.texto_txt.visible = false;}});
		}
		
		// Seleccionamos el sexo del personaje
		private function onClick(e:MouseEvent):void
		{
			_this.mouseEnabled = false;
			var evento:ConfiguradorEvent = new ConfiguradorEvent(ConfiguradorEvent.GUARDAR_AVATAR);
			//evento.datos.volver = '';
			_this.dispatchEvent(evento);
		}
		
		public function entrar():void{
			_this.visible = true;
			_this.mouseEnabled = true;
			TweenMax.to(_this, 0.7, {y:_posY, delay:0.5, ease:Back.easeOut});
		}
		
		public function borrar():void{
			TweenMax.to(_this, 0.7, {y:_posYIni, delay:0.5, ease:Back.easeOut, onComplete:function():void{_this.visible = false;}});
		}
	}
}