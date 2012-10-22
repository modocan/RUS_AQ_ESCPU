/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 05/10/12
 * Time: 11:37
 * To change this template use File | Settings | File Templates.
 */
package commands {
import com.demonsters.debugger.MonsterDebugger;

import models.IJuegosModel;

import org.robotlegs.mvcs.Command;

import views.SeleccionJuegosView;


public class CrearSeleccionJuegosCommand extends Command{

    [Inject]
    public var juegos:IJuegosModel;

    public function CrearSeleccionJuegosCommand()
    {
        super();
    }


    override public function execute():void
    {
        MonsterDebugger.trace(this, '[SELECCION_COMMAND]');

        if(contextView.numChildren > 2)
        {
            MonsterDebugger.trace(this, '[QUITO CONFIG]');
            contextView.removeChildAt(1);
        }

        MonsterDebugger.trace(this, '[CREO SELECCIONADOR]');

        var puntos:Array = new Array();
        puntos = [juegos.getJuegos()[0].puntos, juegos.getJuegos()[1].puntos, juegos.getJuegos()[2].puntos];

        MonsterDebugger.trace(this, puntos);


        var sele:SeleccionJuegosView = new SeleccionJuegosView(puntos);
        sele.y = 34;
        contextView.addChildAt(sele, 1);
    }


}
}
