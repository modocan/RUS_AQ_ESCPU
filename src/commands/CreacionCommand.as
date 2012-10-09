package commands
{

import models.IDBModel;

import org.robotlegs.mvcs.Command;

import services.IFBService;

import views.InterfazView;
import views.JuegoView;
import views.MainView;

public class CreacionCommand extends Command
{

    [Inject]
    public var fb:IFBService;



    public function CreacionCommand()
    {
        super();
    }

    override public function execute():void
    {
        contextView.addChild(new InterfazView());




        //contextView.addChildAt(new JuegoView(), 0);



        // TODO de momentos instanciamos "a pelo" el configurador. Luego habrá que comprobar para decidir
        contextView.addChildAt(new MainView(), 0);
        //

        fb.init();

        //contextView.addChildAt(new PruebaView(), 0);
    }

}
}
