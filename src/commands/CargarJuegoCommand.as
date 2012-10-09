/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 09/10/12
 * Time: 02:44
 * To change this template use File | Settings | File Templates.
 */
package commands {
import events.JuegoEvent;

import models.IJuegosModel;

import org.robotlegs.mvcs.Command;

import views.JuegoView;

public class CargarJuegoCommand extends Command{

    [Inject]
    public var ev:JuegoEvent;

    [Inject]
    public var juegos:IJuegosModel;

    public function CargarJuegoCommand()
    {
        super();
    }

    override public function execute():void
    {
        // TODO setear el juego que cargo y cargarlo

        juegos.setJuegoActual(uint(ev.datos));

        if(contextView.numChildren > 2)
        {
            contextView.removeChildAt(1);
        }

        contextView.addChildAt(new JuegoView(juegos.getJuegoActual().ruta as String), 1);

    }


}
}
