package services {

import com.demonsters.debugger.MonsterDebugger;
import com.facebook.graph.Facebook;
import com.facebook.graph.data.FacebookSession;
import com.hexagonstar.util.debug.Debug;
	
	import events.ConfiguradorEvent;
import events.UsuarioEvent;

import flash.display.Bitmap;

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
    private var at:String;
    private var miAvatarCompartir:Bitmap;
    private const APP_ID:String = '430270773696817';

    public function FBService(){

        // Permisos de Facebook
        Security.loadPolicyFile('http://api.facebook.com/crossdomain.xml');
        Security.loadPolicyFile('http://profile.ak.fbcdn.net/crossdomain.xml');
        Security.allowDomain('http://profile.ak.fbcdn.net');
        Security.allowInsecureDomain('http://profile.ak.fbcdn.net');

        Security.loadPolicyFile('https://api.facebook.com/crossdomain.xml');
        Security.loadPolicyFile('https://profile.ak.fbcdn.net/crossdomain.xml');
        Security.allowDomain('http://profile.ak.fbcdn.net');
        Security.allowInsecureDomain('http://profile.ak.fbcdn.net');
        Security.loadPolicyFile('http://s.ytimg.com/crossdomain.xml');
    }


    public function init():void{

        Debug.trace('Init FB');
        ExternalInterface.addCallback('reciboDatos', recibeUsuario);
        ExternalInterface.addCallback("sendToActionScript", AmigosQueYaHanJugado);
        ExternalInterface.addCallback("reciboTodosLosAmigos", todosLosAmigos);
        //ExternalInterface.addCallback("publicarAvatar", publicarAvatar);
        ExternalInterface.call('conectaFB');
        ExternalInterface.call('cargarAmigos');
    }


    private function recibeUsuario(success:Object):void
    {
        Facebook.init('273344839447085', initComp);



        function initComp(success:Object, fail:Object)
        {
            if(success)
            {
                MonsterDebugger.trace(this, '[FB OK]');
                MonsterDebugger.trace(this, success);

                at = success.accessToken as String;
            }
            else if(fail)
            {
                MonsterDebugger.trace(this, '[FB KO]');
                MonsterDebugger.trace(this, fail);
            }
        }

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


    public function comparteAvatar(_data:Object):void
    {
        MonsterDebugger.trace(this, 'COMPARTO AVTR');
        var parametros:Object = new Object();
        parametros.message = "Prueba";
        parametros.image = _data.foto as Bitmap;
        parametros.fileName = "image"+Math.round(Math.random() * 9999999999)+".jpg";
        parametros.access_token = at;



        Facebook.api("me/photos",fotoCompartida,parametros,"POST");

        function fotoCompartida(_suc:Object, _fail:Object)
        {
            if(_suc)
            {
                MonsterDebugger.trace(this, '[FOTO OK]');
                MonsterDebugger.trace(this, _suc);
            }
            else if(_fail)
            {
                MonsterDebugger.trace(this, '[FOTO KO]');
                MonsterDebugger.trace(this, _fail);
            }
        }
    }


    public function publicarAvatar():void
    {

        MonsterDebugger.trace(this, 'COMPARTO AVTR');
        var parametros:Object = new Object();
        parametros.message = "Prueba";
        parametros.image = miAvatarCompartir;
        parametros.fileName = "image"+Math.round(Math.random() * 9999999999)+".jpg";
        parametros.access_token = at;



        Facebook.api("me/photos",fotoCompartida,parametros,"POST");

        function fotoCompartida(_suc:Object, _fail:Object)
        {
            if(_suc)
            {
                MonsterDebugger.trace(this, '[FOTO OK]');
                MonsterDebugger.trace(this, _suc);
            }
            else if(_fail)
            {
                MonsterDebugger.trace(this, '[FOTO KO]');
                MonsterDebugger.trace(this, _fail);
            }
        }
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

    private function todosLosAmigos(a:Object, b:Array):void{
        var todosLosAmigos:Object=a;
        amigosQjugaron = b;

        var evento:ConfiguradorEvent = new ConfiguradorEvent(ConfiguradorEvent.AMIGOS_QUE_JUGARON);
        evento.datos.amigosQueJugaron = amigosQjugaron;
        evento.datos.todosLosAmigos = todosLosAmigos;
        eventDispatcher.dispatchEvent(evento);
    }
		
		
	}
}
