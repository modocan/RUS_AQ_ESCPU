/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 15/10/12
 * Time: 13:15
 * To change this template use File | Settings | File Templates.
 */
package mediators {
import events.ConfiguradorEvent;

import org.robotlegs.mvcs.Mediator;

import views.HomeView;

public class HomeMediator extends Mediator{

    [Inject]
    public var vista:HomeView;

    public function HomeMediator()
    {
        super();
    }


    override public function onRegister():void
    {
        eventMap.mapListener(vista, ConfiguradorEvent.INICIO_HOME, inicio);
    }

    private function inicio(e:ConfiguradorEvent):void
    {
        eventDispatcher.dispatchEvent(new ConfiguradorEvent(ConfiguradorEvent.INICIO_HOME));
    }


}
}
