/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 28/09/12
 * Time: 12:46
 * To change this template use File | Settings | File Templates.
 */
package commands {
import com.demonsters.debugger.MonsterDebugger;

import models.IAvatarModel;
import models.IUsuarioModel;

import org.robotlegs.mvcs.Command;

import services.IUsuarioService;

public class GuardarAvatarCommand extends Command{

    [Inject]
    public var usuario_service:IUsuarioService;

    [Inject]
    public var usuario:IUsuarioModel;

    [Inject]
    public var avatar:IAvatarModel;

    public function GuardarAvatarCommand()
    {
        super();
    }


    override public function execute():void
    {
        var datos:Object = new Object();
        datos =
        {

            id_fb: usuario.get_idFB(),
            nombre: usuario.getNombreUsuario(),
            sexo: avatar.getSexo(),

            avatar:
            {
                pelo: avatar.getPelo().name,
                ojos: avatar.getOjos().name,
                boca: avatar.getBoca().name,
                camisa: avatar.getCamisa().name,
                pantalon: avatar.getPantalon().name,
                zapatos: avatar.getZapatos().name,
                top: avatar.getCamisa().name,
                falda: avatar.getPantalon().name,
                sombrero: avatar.getPelo().name,
                gafas: avatar.getGafas().name

            }

        }

        usuario_service.guardaAvatar(datos);
    }


}
}
