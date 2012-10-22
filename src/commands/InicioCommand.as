/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 15/10/12
 * Time: 13:32
 * To change this template use File | Settings | File Templates.
 */
package commands {
import com.greensock.TweenMax;

import models.IJuegosModel;

import org.robotlegs.mvcs.Command;

import services.IFBService;

import views.MainView;
import views.SeleccionJuegosView;

public class InicioCommand extends Command {

    [Inject]
    public var fb:IFBService;

    [Inject]
    public var juegos:IJuegosModel;

    public function InicioCommand()
    {
        super();
    }


    override public function execute():void
    {
        if(contextView.getChildAt(1))
        {
            contextView.removeChildAt(1);
        }
        fb.init();

        /*var conf:MainView = new MainView();
        conf.y = 34;
        contextView.addChildAt(conf, 1);*/

        /*var puntos:Array = new Array();
        puntos = [juegos.getJuegos()[0].puntos, juegos.getJuegos()[1].puntos, juegos.getJuegos()[2].puntos];


        var sele:SeleccionJuegosView = new SeleccionJuegosView(puntos);
        sele.y = 34;

        contextView.addChildAt(sele, 1);*/

    }

}
}
