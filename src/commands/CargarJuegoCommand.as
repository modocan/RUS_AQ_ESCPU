/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 09/10/12
 * Time: 02:44
 * To change this template use File | Settings | File Templates.
 */
package commands {
import com.demonsters.debugger.MonsterDebugger;

import events.ConfiguradorEvent;

import events.JuegoEvent;

import models.IAvatarModel;

import models.IJuegosModel;

import org.robotlegs.mvcs.Command;

import views.JuegoView;

public class CargarJuegoCommand extends Command{

    [Inject]
    public var ev:JuegoEvent;

    [Inject]
    public var juegos:IJuegosModel;

    [Inject]
    public var avatar:IAvatarModel;

    public function CargarJuegoCommand()
    {
        super();
    }

    override public function execute():void
    {
        // TODO setear el juego que cargo y cargarlo

        juegos.setJuegoActual(uint(ev.datos));
        MonsterDebugger.trace(this, '[JUEGO QUE CARGO]');
        MonsterDebugger.trace(this, juegos.getJuegoActual());

        if(contextView.numChildren > 2)
        {
            contextView.removeChildAt(1);
        }

        var lista_ropa:Array = new Array();
        lista_ropa = [avatar.getBoca(), avatar.getCamisa(), avatar.getGafas(), avatar.getOjos(), avatar.getPantalon(), avatar.getPelo(), avatar.getZapatos()];

        MonsterDebugger.trace(this, '[COMANDO JUEGO]');
        MonsterDebugger.trace(this, lista_ropa);

        MonsterDebugger.trace(this, '[AVATAR]');
        MonsterDebugger.trace(this, avatar);

        eventDispatcher.dispatchEvent(new ConfiguradorEvent(ConfiguradorEvent.CREA_PRECARGA));

        var juego:JuegoView = new JuegoView(juegos.getJuegoActual().ruta as String, lista_ropa);
        juego.y = 34;

        contextView.addChildAt(juego, 1);

    }


}
}
