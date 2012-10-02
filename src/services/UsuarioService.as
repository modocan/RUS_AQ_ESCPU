/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 14/09/12
 * Time: 12:39
 * To change this template use File | Settings | File Templates.
 */
package services {
import com.adobe.serialization.json.JSON;
import com.demonsters.debugger.MonsterDebugger;
import com.hexagonstar.util.debug.Debug;

import events.UsuarioEvent;

import flash.net.NetConnection;
import flash.net.Responder;

import models.IAvatarModel;

import models.IUsuarioModel;

import org.robotlegs.mvcs.Actor;

public class UsuarioService extends Actor implements IUsuarioService{


    private const GATEWAY:String = 'http://aquariustest.cocacola.es/appsaquarius/escuela/pruebas_GONZALO/amfphp/gateway.p' +
            'hp';
    private var cn:NetConnection;


    [Inject]
    public var usuario:IUsuarioModel;

    [Inject]
    public var avatar:IAvatarModel;


    public function UsuarioService() {
        super ();
    }


    public function guardaAvatar(_data:Object):void
    {

        //MonsterDebugger.trace(this, _data);

        cn = new NetConnection();
        cn.connect(GATEWAY);
        cn.call('ContactService.verElementos',
                new Responder(function(_success:Object)
                {
                    MonsterDebugger.trace(this, '[RESPUESTA GUARDAR]');
                    MonsterDebugger.trace(this, _success);
                    //MonsterDebugger.trace(this, JSON.decode(_success as String));
                },

                function(fallo:Object)
                {
                    MonsterDebugger.trace(this, '[FALLO GUARDAR]');
                    MonsterDebugger.trace(this, fallo);
                }),
                '1');
        cn.close();
    }


    public function dameUsuario(_id:String):void
    {

        cn = new NetConnection();
        cn.connect(GATEWAY);
        cn.call('ContactService.dameJugador',
                new Responder(function(_data:Object){


                    if(_data != 'KO')
                    {
                        var resp:Object = JSON.decode(_data as String);
                        usuario.setUsuario(resp[0]);
                        avatar.setPartes(resp[1]);
                    }
                    else
                    {
                        MonsterDebugger.trace(this, '[NO EXISTE USUARIO]');
                        eventDispatcher.dispatchEvent(new UsuarioEvent(UsuarioEvent.USUARIO_NUEVO));
                    }



                }, function(fallo:Object){

                    MonsterDebugger.trace(this, fallo);

                }),
                _id);
        cn.close();
    }


}
}