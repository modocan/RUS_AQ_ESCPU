package models {
	
	public interface IUsuarioModel {
	
	    function get_idFB():String

        function set_idFB(valor:String):void

        function setUsuario(datos:Object);

        function getNombreUsuario():String

        function setNombreUsuario(valor:String):void

        function getIdCoke():String

        function setIdCoke(valor:String):void

        function getIdTabla():String

        function setIdTabla(valor:String):void

        function getCompartido():String

        function setCompartido():void
	
	}
}
