/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 28/09/12
 * Time: 12:26
 * To change this template use File | Settings | File Templates.
 */
package commands {
import events.ConfiguradorEvent;

import models.IAvatarModel;


import org.robotlegs.mvcs.Command;

public class ElementoElegidoCommand extends Command{

    [Inject]
    public var ev:ConfiguradorEvent;

    [Inject]
    public var avatar:IAvatarModel;

    public function ElementoElegidoCommand()
    {
        super();
    }

    override public function execute():void
    {
        avatar.setElemento(ev.datos);
    }

}
}
