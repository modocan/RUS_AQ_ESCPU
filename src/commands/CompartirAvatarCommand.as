/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 20/10/12
 * Time: 12:52
 * To change this template use File | Settings | File Templates.
 */
package commands {
import events.ConfiguradorEvent;

import models.IUsuarioModel;

import org.robotlegs.mvcs.Command;

import services.IFBService;

public class CompartirAvatarCommand extends Command{

    [Inject]
    public var ev:ConfiguradorEvent;

    [Inject]
    public var service:IFBService;

    [Inject]
    public var usuario:IUsuarioModel;

    public function CompartirAvatarCommand()
    {
        super();
    }


    override public function execute():void
    {
        var datos:Object = new Object();
        datos.nombre = usuario.getNombreUsuario() as String;
        datos.foto = ev.datos;
        service.comparteAvatar(datos);
    }


}
}
