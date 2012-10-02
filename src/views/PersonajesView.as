package views
{
import com.demonsters.debugger.MonsterDebugger;
import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import com.hexagonstar.util.debug.Debug;
	
	import events.ConfiguradorEvent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class PersonajesView extends MovieClip
	{
		private var _btnSexo:Btn_sexo;
		private var _this:PersonajesView;
		
		// Pos común
		private var _posCentral:Number = 311;
		private var _posY:Number = 284;
		private var _posIni:Number;
		

		public function PersonajesView()
		{
			_this = this;
			_this.visible = false;
			_this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			_this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			config();
		}
		
		private function config():void
		{
			_btnSexo = new Btn_sexo();
			_btnSexo.chica.addEventListener(MouseEvent.CLICK,onClick);
			_btnSexo.chico.addEventListener(MouseEvent.CLICK,onClick);
			_this.addChild(_btnSexo);
			_posIni = stage.stageHeight + _this.height;
			_this.x = stage.stageWidth/2;
			_this.y = _posIni;
			entrar();
		}
		
		private function habilitarBotones():void
		{
			_btnSexo.chico.mouseEnabled = true;
			_btnSexo.chico.mouseEnabled = true;
		}
		
		private function deshabilitarBotones():void
		{
			_btnSexo.chico.mouseEnabled = false;
			_btnSexo.chico.mouseEnabled = false;
		}
		
		public function entrar():void
		{
			habilitarBotones();
			_this.visible = true;
			TweenMax.to(_this, 0.7, {y:_posY, ease:Expo.easeOut, delay:1});
		}
		
		public function borrar():void
		{
			TweenMax.to(_this, 0.7, {y:_posIni, ease:Expo.easeOut, onComplete:function():void{_this.visible = false;}});
		}
		
		// Seleccionamos el sexo del personaje
		private function onClick(e:MouseEvent):void
		{
			deshabilitarBotones();
			var evento:ConfiguradorEvent = new ConfiguradorEvent(ConfiguradorEvent.SEXO);


            if(e.currentTarget.name == 'chico')
            {
                evento.datos.sexo = '1';
            }
            else
            {
                evento.datos.sexo = '0';
            }
			_this.dispatchEvent(evento);
			borrar();
		}
		
	}
}