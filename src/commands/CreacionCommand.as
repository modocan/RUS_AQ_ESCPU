package commands
{

import events.UsuarioEvent;

import flash.events.Event;

import models.IDBModel;

import org.robotlegs.mvcs.Command;

import services.IFBService;

import views.HomeView;

import views.InterfazView;

import views.InterfazView;
import views.JuegoView;
import views.MainView;
import views.SeleccionJuegosView;

public class CreacionCommand extends Command
{



    public function CreacionCommand()
    {
        super();
    }

    override public function execute():void
    {
        var fondo:FonoJuego = new FonoJuego();
        fondo.y = 34;
        fondo.addEventListener(Event.ADDED_TO_STAGE, initFondo);
        contextView.addChild(fondo);


        function initFondo(e:Event):void
        {
            FonoJuego(e.currentTarget).removeEventListener(Event.ADDED_TO_STAGE, initFondo);

            var interfaz:InterfazView = new InterfazView();
            interfaz.y = 34;
            interfaz.addEventListener(Event.ADDED_TO_STAGE, initInterfaz);
            contextView.addChild(interfaz);

        }

        function initInterfaz(e:Event):void
        {
            InterfazView(e.currentTarget).removeEventListener(Event.ADDED_TO_STAGE, initInterfaz);

            var hom:HomeView = new HomeView();
            hom.y = 24;
            contextView.addChildAt(hom, 1);

            //fb.init();

            //contextView.addChildAt(new MainView(), 1);

            //contextView.addChildAt(new SeleccionJuegosView(['suficiente', 'bien', 'notable']), 1);
        }


    }

}
}
