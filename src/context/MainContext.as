package context {

import commands.CargarJuegoCommand;
import commands.CreaConfiguradorCommand;
import commands.CrearLoginCokeCommand;
import commands.CrearSeleccionJuegosCommand;
import commands.ElementoElegidoCommand;
import commands.FBIniciadoCommand;
import commands.GuardarAvatarCommand;

import events.JuegoEvent;

import events.UsuarioEvent;

import flash.display.DisplayObjectContainer;
		
	import com.hexagonstar.util.debug.Debug;

import mediators.JuegoMediator;
import mediators.SeleccionJuegosMediator;
import mediators.SelectorMediator;

import models.AvatarModel;

import models.IAvatarModel;
import models.IJuegosModel;
import models.JuegosModel;

import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;

import services.IUsuarioService;
import services.UsuarioService;

import views.JuegoView;
import views.SeleccionJuegosView;
import views.SelectorView;

// Imports del proyecto
	
	import models.IDBModel;
	import models.DBModel;
	import models.IUsuarioModel;
	import models.UsuarioModel;
	import services.IFBService;
	import services.FBService;
	
	import events.ConfiguradorEvent;
	
	import commands.CreacionCommand;
	import commands.MenuCategoriasCommand;
	import commands.FBCommand;
	
	import mediators.MainMediator;
	import mediators.InterfazMediator;
	import mediators.MenuCategoriasMediator;
	import mediators.SubMenuCategoriasMediator;
	import mediators.MunecoMediator;
	import mediators.PersonajesMediator;
	import mediators.BtnVolverMediator;
	import mediators.BtnFinMediator;
	import mediators.NombreMediator;
	import mediators.AmigosListMediator;
	
	import views.MainView;
	import views.InterfazView;
	import views.MunecoView;
	import views.PersonajesView;
	import views.MenuCategoriasView;
	import views.SubMenuCategoriasView;
	import views.BtnVolverView;
	import views.BtnFinView;
	import views.NombreView;
	import views.AmigosListView;


	public class MainContext extends Context {
	
	    public function MainContext(contextView:DisplayObjectContainer=null) {
	        super(contextView);
	    }
	
	    override public function startup():void
	    {
	        mapCommands();
	        mapModels();
	        mapViews();
	
	        super.startup();
	    }
	
	    private function mapCommands():void
	    {
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, CreacionCommand, ContextEvent);
	        commandMap.mapEvent(ConfiguradorEvent.CLICK_EN_ELEMENTO, ElementoElegidoCommand, ConfiguradorEvent);
	        commandMap.mapEvent(ConfiguradorEvent.GUARDAR_AVATAR, GuardarAvatarCommand, ConfiguradorEvent);
			commandMap.mapEvent(ConfiguradorEvent.SEXO, MenuCategoriasCommand, ConfiguradorEvent);
			commandMap.mapEvent(UsuarioEvent.FB_INICIADO, FBIniciadoCommand, UsuarioEvent);
			commandMap.mapEvent(UsuarioEvent.USUARIO_NUEVO, CreaConfiguradorCommand, UsuarioEvent);
			commandMap.mapEvent(UsuarioEvent.COKEID_KO, CrearLoginCokeCommand, UsuarioEvent);
			commandMap.mapEvent(UsuarioEvent.COKEID_OK, CrearSeleccionJuegosCommand, UsuarioEvent);
			commandMap.mapEvent(JuegoEvent.SELECCION_JUEGO, CargarJuegoCommand, JuegoEvent);
	    }
	
	    private function mapModels():void
	    {
			injector.mapSingletonOf(IUsuarioModel, UsuarioModel);
	        injector.mapSingletonOf(IDBModel, DBModel);
			injector.mapSingletonOf(IFBService, FBService);
			injector.mapSingletonOf(IUsuarioService, UsuarioService);
			injector.mapSingletonOf(IAvatarModel, AvatarModel);
			injector.mapSingletonOf(IJuegosModel, JuegosModel);
	    }
	
	    private function mapViews():void
	    {
			mediatorMap.mapView(MainView, MainMediator);
			mediatorMap.mapView(InterfazView, InterfazMediator);
			mediatorMap.mapView(MenuCategoriasView, MenuCategoriasMediator);
			mediatorMap.mapView(SubMenuCategoriasView, SubMenuCategoriasMediator);
			mediatorMap.mapView(MunecoView, MunecoMediator);
			mediatorMap.mapView(PersonajesView, PersonajesMediator);
			mediatorMap.mapView(BtnVolverView, BtnVolverMediator);
			mediatorMap.mapView(BtnFinView, BtnFinMediator);
			mediatorMap.mapView(NombreView, NombreMediator);
			mediatorMap.mapView(AmigosListView, AmigosListMediator);
			mediatorMap.mapView(JuegoView, JuegoMediator);
			mediatorMap.mapView(SeleccionJuegosView, SeleccionJuegosMediator);
			mediatorMap.mapView(SelectorView, SelectorMediator);
	    }
	
	}
}
