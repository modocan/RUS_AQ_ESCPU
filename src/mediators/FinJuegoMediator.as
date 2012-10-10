/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 10/10/12
 * Time: 01:40
 * To change this template use File | Settings | File Templates.
 */
package mediators {
import events.JuegoEvent;

import org.robotlegs.mvcs.Mediator;

import views.FinJuegoView;

public class FinJuegoMediator extends Mediator{

    [Inject]
    public var vista:FinJuegoView;

    public function FinJuegoMediator()
    {
        super();
    }


    override public function onRegister():void
    {
        eventMap.mapListener(vista, JuegoEvent.VOLVER, volver);
    }

    private function volver(e:JuegoEvent):void
    {
        eventDispatcher.dispatchEvent(new JuegoEvent(JuegoEvent.VOLVER));
    }


}
}
