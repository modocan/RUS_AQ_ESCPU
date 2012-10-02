package views
{
	
	import com.hexagonstar.util.debug.Debug;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	
	public class MainView extends Sprite {
		
		private var _interfaz:InterfazView;
		private var _menu_categorias:MenuCategoriasView;
		private var _submenu_categorias:SubMenuCategoriasView;
		private var _personajes:PersonajesView;
		private var _fondo:Fondo_mc;
		private var _this:MainView;
		private var _btn_volver:BtnVolverView;
		private var _btn_fin:BtnFinView;
		private var _muneco:MunecoView;
		private var _nombre:NombreView;
		private var _listaAmigos:AmigosListView;
		
		
		public function MainView() {
			_this = this;
			_this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			Debug.trace('init MainView');
			_this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// Añadimos las vistas principales al Stage
			
			_fondo = new Fondo_mc();
			_this.addChild(_fondo);
			_menu_categorias = new MenuCategoriasView();
			_this.addChild(_menu_categorias);
			_submenu_categorias = new SubMenuCategoriasView();
			_this.addChild(_submenu_categorias);
			_personajes = new PersonajesView();
			_this.addChild(_personajes);
			_btn_volver = new BtnVolverView();
			_this.addChild(_btn_volver);
			_btn_fin = new BtnFinView();
			_this.addChild(_btn_fin);
			_muneco = new MunecoView();
			_this.addChild(_muneco);
			_nombre = new NombreView();
			_this.addChild(_nombre);
			/*_interfaz = new InterfazView();
			_this.addChild(_interfaz);
			_listaAmigos = new AmigosListView();
			_this.addChild(_listaAmigos);*/
		}
		
	}
}