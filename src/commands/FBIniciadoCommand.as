/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 18/09/12
 * Time: 17:46
 * To change this template use File | Settings | File Templates.
 */
package commands {
import com.demonsters.debugger.MonsterDebugger;
import com.hexagonstar.util.debug.Debug;

import models.IUsuarioModel;

import org.robotlegs.mvcs.Command;

import services.IUsuarioService;

public class FBIniciadoCommand extends Command{

    [Inject]
    public var usuario:IUsuarioModel;

    [Inject]
    public var usuario_service:IUsuarioService;

    public function FBIniciadoCommand() {
        super();
    }


    override public function execute():void
    {
        usuario_service.dameUsuario(usuario.get_idFB());
    }


}
}
