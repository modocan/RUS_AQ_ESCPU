package views
{
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import com.hexagonstar.util.debug.Debug;
	
	import events.ConfiguradorEvent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class BtnVolverView extends MovieClip
	{
		private var _this:BtnVolverView;
		private var _btn_volver:Btn_volver_mc;
		private var _posYIni:Number;
		private var _posX:Number = 95;
		private var _posY:Number = 560;
		
		public function BtnVolverView()
		{
			_this = this;
			_this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			Debug.trace('init BtnVolverView');
			_this.removeEventListener(Event.ADDED_TO_STAGE, init);
			config();
		}
		
		private function config():void{
			_btn_volver = new Btn_volver_mc();
			_this.addChild(_btn_volver);
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
			var evento:ConfiguradorEvent = new ConfiguradorEvent(ConfiguradorEvent.VOLVER);
			//evento.datos.volver = '';
			_this.dispatchEvent(evento);
		}
		
		public function entrar():void
		{
			_this.mouseEnabled = true;
			_this.visible = true;
			TweenMax.to(_this, 0.7, {y:_posY, delay:0.5, ease:Back.easeOut});
		}
		
		public function borrar():void
		{
			TweenMax.to(_this, 0.7, {y:_posYIni, delay:0.5, ease:Back.easeOut, onComplete:function():void{_this.visible = false;}});
		}
	}
}