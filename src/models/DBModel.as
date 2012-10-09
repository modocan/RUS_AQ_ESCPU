package models {

import com.adobe.serialization.json.JSON;
import com.demonsters.debugger.MonsterDebugger;
import com.hexagonstar.util.debug.Debug;

import events.ConfiguradorEvent;

import flash.net.NetConnection;
import flash.net.Responder;

import org.robotlegs.mvcs.Actor;

	public class DBModel extends Actor implements IDBModel {
	
	    private const GATEWAY:String = 'http://aquariustest.cocacola.es/appsaquarius/escuela/amfphp/gateway.php';
	    private var cn:NetConnection;
		
		// Categorías
		private var _pelos:Array;
		private var _gafas:Array;
		private var _ojos:Array;
		private var _bocas:Array;
		private var _camisas:Array;
		private var _pantalones:Array;
		private var _zapatos:Array;

        private var peloElegido:String = '';
        private var gafasElegido:String = '';
        private var ojosElegido:String = '';
        private var bocasElegido:String = '';
        private var camisasElegido:String = '';
        private var pantalonesElegido:String = '';
        private var zapatosElegido:String = '';

	    public function DBModel() {
	        super();
	    }
	
	    public function cargarElementos(_sexo:String):void
	    {
	        var envio:Object = new Object();
	        envio.sexo = _sexo;
	       
	        cn = new NetConnection();
	        cn.connect(GATEWAY);
	        cn.call('ContactService.comboAvatar', new Responder(respuestaElementos), _sexo);
			cn.close();
	    }
	
	    private function respuestaElementos(respuesta:Object):void
	    {
            respuesta = JSON.decode(respuesta as String);

			_pelos = new Array();
			_gafas = new Array();
			_ojos = new Array();
			_bocas = new Array();
			_camisas = new Array();
			_pantalones = new Array();
			_zapatos = new Array();


            for each(var el:Object in respuesta.falda)
            {
                _pantalones.push(['1', el.nombre]);
            }

            for each(var el:Object in respuesta.top)
            {
                _camisas.push(['1', el.nombre]);
            }

            for each(var el:Object in respuesta.boca)
            {
                _bocas.push(['1', el.nombre]);
            }

            for each(var el:Object in respuesta.camisa)
            {
                _camisas.push(['1', el.nombre]);
            }

            for each(var el:Object in respuesta.gafas)
            {
                _gafas.push(['1', el.nombre]);
            }

            for each(var el:Object in respuesta.ojos)
            {
                _ojos.push(['1', el.nombre]);
            }

            for each(var el:Object in respuesta.pantalon)
            {
                _pantalones.push(['1', el.nombre]);
            }

            for each(var el:Object in respuesta.pelo)
            {
                _pelos.push(['1', el.nombre]);
            }

            for each(var el:Object in respuesta.zapatos)
            {
                _zapatos.push(['1', el.nombre]);
            }


			var evento:ConfiguradorEvent = new ConfiguradorEvent(ConfiguradorEvent.ELEMENTOS_CARGADOS);
			
			var _object:Object = new Object;

			/*_pelos = respuesta.pelo as Array;
			_gafas = respuesta.gafas as Array;
			_ojos = respuesta.ojos as Array;
			_bocas = respuesta.boca as Array;
			_pantalones = respuesta.pantalon as Array;
			_zapatos = respuesta.zapato as Array;*/

			evento.datos.pelos = _pelos;
			evento.datos.gafas = _gafas;
			evento.datos.ojos = _ojos;
			evento.datos.bocas = _bocas;
			evento.datos.camisas = _camisas;
			evento.datos.pantalones = _pantalones;
			evento.datos.zapatos = _zapatos;
			eventDispatcher.dispatchEvent(evento);
	    }
	
	}
}
