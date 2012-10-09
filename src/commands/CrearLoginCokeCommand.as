/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 03/10/12
 * Time: 12:52
 * To change this template use File | Settings | File Templates.
 */
package commands {
import com.demonsters.debugger.MonsterDebugger;

import flash.external.ExternalInterface;

import models.IUsuarioModel;

import org.robotlegs.mvcs.Command;

public class CrearLoginCokeCommand extends Command {

    [Inject]
    public var usuario:IUsuarioModel;

    public function CrearLoginCokeCommand() {
        super();
    }


    override public function execute():void
    {
        MonsterDebugger.trace(this, '[USUARIO ID_TABLA COKE]')
        MonsterDebugger.trace(this, usuario.getIdTabla());
        MonsterDebugger.trace(this, usuario.get_idFB());

        ExternalInterface.call('crearLoginCoke', usuario.get_idFB());
    }

}
}
