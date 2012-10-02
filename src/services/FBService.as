package services {

import com.demonsters.debugger.MonsterDebugger;
	import com.hexagonstar.util.debug.Debug;
	
	import events.ConfiguradorEvent;
import events.UsuarioEvent;

import flash.display.MovieClip;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.Security;

import models.IUsuarioModel;

import org.robotlegs.mvcs.Actor;

import services.IFBService;

public class FBService extends Actor implements IFBService {

    [Inject]
    public var usuario_model:IUsuarioModel;

    private var usuario:Object;
    private var amigosQjugaron:Array;
    private const APP_ID:String = '273344839447085';

    public function FBService(){

        // Permisos de Facebook
        Security.loadPolicyFile('http://api.facebook.com/crossdomain.xml');
        Security.loadPolicyFile('http://profile.ak.fbcdn.net/crossdomain.xml');
        Security.allowDomain('http://profile.ak.fbcdn.net');
        Security.allowInsecureDomain('http://profile.ak.fbcdn.net');
    }


    public function init():void{

        Debug.trace('Init FB');
        ExternalInterface.addCallback('reciboDatos', recibeUsuario);
        ExternalInterface.addCallback("sendToActionScript", AmigosQueYaHanJugado);
        ExternalInterface.addCallback("reciboTodosLosAmigos", todosLosAmigos);
        ExternalInterface.call('conectaFB');
        //ExternalInterface.call('cargarAmigos');

    }


    private function recibeUsuario(success:Object):void
    {
        Debug.trace('[Respuesta JS]');

        Debug.traceObj(success);

        usuario = new Object();

        usuario.nombre = success.first_name;
        usuario.apellidos = success.last_name;
        usuario.id = success.id;

        /*usuario_model.setNombreUsuario(success.first_name + ' ' + success.last_name);
        usuario_model.set_idFB(success.id);*/

        usuario_model.setNombreUsuario(String(success.first_name));
        usuario_model.set_idFB(String(success.id));

        Debug.trace('[guardo en modelo]');

        eventDispatcher.dispatchEvent(new UsuarioEvent(UsuarioEvent.FB_INICIADO));

        /*var evento:ConfiguradorEvent = new ConfiguradorEvent(ConfiguradorEvent.NOMBRE_USUARIO);
        evento.datos.nombre = usuario.nombre+' '+usuario.apellidos;
        eventDispatcher.dispatchEvent(evento);*/
    }





    public function comparte(texto:String):void
    {
        /*var datos:Object = new Object();
        datos.caption = caption_post;
        datos.description = _description;
        datos.name = _name;
        datos.link = _link;
        datos.picture = _picture;
        datos.message = _texto;

        ExternalInterface.call('compartePregunta', datos);*/
    }

    private function AmigosQueYaHanJugado(Amigos:Array):void {
        Debug.trace('Vino a amigos q ya jugaron!!!!');
        amigosQjugaron=new Array();
        amigosQjugaron=Amigos;
        //Debug.inspect(Amigos);
        //Debug.trace('amigos q jugaron: '+amigosQjugaron);



        /*if(cargaPintarAmigos){
            pintarAmigos();
        } else {
            cargaPintarAmigos = true;
        }*/
    }

    private function todosLosAmigos(a:Object):void{
        var todosLosAmigos:Object=a;
        //Debug.inspect(todosLosAmigos);
        Debug.trace('Vino a todosLosAmigos');

        var evento:ConfiguradorEvent = new ConfiguradorEvent(ConfiguradorEvent.AMIGOS_QUE_JUGARON);
        evento.datos.amigosQueJugaron = amigosQjugaron;
        evento.datos.todosLosAmigos = todosLosAmigos;
        eventDispatcher.dispatchEvent(evento);
    }
		
		
	}
}
