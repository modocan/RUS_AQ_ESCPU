package models {

import com.demonsters.debugger.MonsterDebugger;

import events.ConfiguradorEvent;
import events.UsuarioEvent;

import org.robotlegs.mvcs.Actor;

	public class UsuarioModel extends Actor implements IUsuarioModel {

        private var login_cocacola:String;
        private var nombre_usuario:String;
        private var id_facebook:String;
        private var compartido:String;
        private var id_tabla:String;


	    public function UsuarioModel() {
	        super();
	    }


        public function get_idFB():String
        {
            return id_facebook;
        }

        public function set_idFB(valor:String):void
        {
            id_facebook = valor;
        }

        public function setNombreUsuario(valor:String):void
        {
            this.nombre_usuario = valor;
        }

        public function getNombreUsuario():String
        {
            return this.nombre_usuario;
        }

        public function setIdCoke(_data:String):void
        {
            this.login_cocacola = _data;
        }

        public function getIdCoke():String
        {
            return this.login_cocacola;
        }


        public function setIdTabla(_data:String):void
        {
            this.id_tabla = _data;
        }

        public function getIdTabla():String
        {
            return this.id_tabla;
        }

        public function setUsuario(datos:Object)
        {
            MonsterDebugger.trace(this, '[SET USUARIO]');
            MonsterDebugger.trace(this, datos);

            this.id_facebook = datos.id_fb as String;
            this.nombre_usuario = datos.nombre as String;
            this.compartido = datos.COMPARTIDO as String;
            this.id_tabla = datos.id as String;

            if(datos.id_coke)
            {
                MonsterDebugger.trace(this, '[1]');
                this.login_cocacola = datos.id_coke as String;
                dispatch(new UsuarioEvent(UsuarioEvent.COKEID_OK));
            }
            else
            {
                MonsterDebugger.trace(this, '[2]');
                dispatch(new UsuarioEvent(UsuarioEvent.COKEID_KO));
            }
        }
	
	}
}
