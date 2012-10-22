package events {
	import flash.events.Event;
	
	public class ConfiguradorEvent extends Event
	{
		public static const AVATAR_GUARDADO:String = 'ConfiguradorEvent.AVATAR_GUARDADO';
		public static const AVATAR_LISTO:String = 'ConfiguradorEvent.AVATAR_LISTO';
		public static const GUARDAR_AVATAR:String = 'ConfiguradorEvent.GUARDAR_AVATAR';
		public static const LOADER_LOGIN:String = 'ConfiguradorEvent.LOADER_LOGIN';
		public static const COMPARTIR_MURO:String = 'ConfiguradorEvent.COMPARTIR_MURO';
		public static const SEXO:String = 'ConfiguradorEvent.SEXO';
		public static const PINTAR_MENUS:String = 'ConfiguradorEvent.PINTAR_MENUS';
		public static const CATEGORIA:String = 'ConfiguradorEvent.CATEGORIA';
		public static const ELEMENTO:String = 'ConfiguradorEvent.ELEMENTO';
		public static const ELEMENTOS_CARGADOS:String = 'ConfiguradorEvent.ELEMENTOS_CARGADOS';
		public static const VOLVER:String = 'ConfiguradorEvent.VOLVER';
		public static const CLICK_EN_ELEMENTO:String = 'ConfiguradorEvent.CLICK_EN_ELEMENTO';
		public static const CLICK_EN_CATEGORIA:String = 'ConfiguradorEvent.CLICK_EN_CATEGORIA';
		public static const CARGAR_AMIGOS:String = 'ConfiguradorEvent.CARGAR_AMIGOS';
		public static const NOMBRE_USUARIO:String = 'ConfiguradorEvent.NOMBRE_USUARIO';
		public static const AMIGOS_QUE_JUGARON:String = 'ConfiguradorEvent.AMIGOS_QUE_JUGARON';
		public static const INICIO_HOME:String = 'ConfiguradorEvent.INICIO_HOME';
		public static const ACTIVA_FINALIZAR:String = 'ConfiguradorEvent.ACTIVA_FINALIZAR';
		public static const CREA_PRECARGA:String = 'ConfiguradorEvent.CREA_PRECARGA';
		public static const ELIMINA_PRECARGA:String = 'ConfiguradorEvent.ELIMINA_PRECARGA';
		public static const PROGRESO_CARGA:String = 'ConfiguradorEvent.PROGRESO_CARGA';
		public static const COMPARTIR_AVATAR:String = 'ConfiguradorEvent.COMPARTIR_AVATAR';

		private var _datos:Object = new Object();
			
		public function ConfiguradorEvent(tipo:String) {
			super(tipo);
		}
			
		public function get datos():Object {
			return _datos;
		}
			
		public function set datos(value:Object):void {
			_datos = value;
		}

	}
}