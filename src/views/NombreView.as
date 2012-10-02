package views
{
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import com.hexagonstar.util.debug.Debug;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextFieldAutoSize;
	
	public class NombreView extends MovieClip
	{
		private var _this:NombreView;
		private var _nombre_mc:Nombre_mc;
		private var _margen:int = 5;
		private var _posX:Number = 232;
		private var _posY:Number = 90;
		private var _posYIni:Number;
		private var _nombre:String;
		private var _max_caract:int = 25;
		
		public function NombreView()
		{
			_this = this;
			_this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			Debug.trace('init NombreView');
			_this.removeEventListener(Event.ADDED_TO_STAGE, init);
			config();
		}
		
		private function config():void
		{
			_this.visible = false;
			_nombre_mc = new Nombre_mc();
			_this.addChild(_nombre_mc);
			_posYIni = -_this.height;
			_this.y = _posYIni;
			_this.x = _posX;
		}
		
		public function entrar():void
		{
			Debug.trace('entrar NombreView');
			_this.visible = true;
			TweenMax.to(_this, 0.7, {y:_posY, delay:0.5, ease:Back.easeOut});
		}
		
		public function borrar():void
		{
			Debug.trace('borrar NombreView: '+_posYIni);
			TweenMax.to(_this, 0.7, {y:_posYIni, delay:0.5, ease:Back.easeOut, onComplete:function():void{_this.visible = false;}});
		}
		
		public function set nombre(valor:String):void
		{
			_nombre = valor.toUpperCase();
			if(_nombre.length > _max_caract){
				_nombre = _nombre.substring(0, _max_caract);
				_nombre = _nombre+'...';
			}
			_nombre_mc.texto_txt.text = _nombre;
			_nombre_mc.texto_txt.autoSize = TextFieldAutoSize.CENTER;
			_nombre_mc.lateral_izq.x = -_nombre_mc.texto_txt.width/2 - _margen;
			_nombre_mc.lateral_der.x = _nombre_mc.texto_txt.width/2 + _margen;
			_nombre_mc.marco_mc.width = _nombre_mc.texto_txt.width + _margen*2;
			_nombre_mc.fondo_mc.width = _nombre_mc.marco_mc.width+_nombre_mc.lateral_izq.width*2 - _margen*2;
		}
		
	}
}