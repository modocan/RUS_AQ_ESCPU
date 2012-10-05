/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 26/09/12
 * Time: 12:41
 * To change this template use File | Settings | File Templates.
 */
package models {
import com.demonsters.debugger.MonsterDebugger;

import org.robotlegs.mvcs.Actor;

public class AvatarModel extends Actor implements IAvatarModel{


    private var _pantalon:Object = new Object();
    private var _boca:Object = new Object();
    private var _ojos:Object = new Object();
    private var _camisa:Object = new Object();
    private var _gafas:Object = new Object();
    private var _zapatos:Object = new Object();
    private var _pelo:Object = new Object();


    private var id_avatar:String;
    private var sexo:String;


    public function AvatarModel()
    {
        super();

        _pantalon.name = 'nada';
        _boca.name = 'nada';
        _ojos.name = 'nada';
        _camisa.name = 'nada';
        _gafas.name = 'nada';
        _zapatos.name = 'nada';
        _pelo.name = 'nada';
    }


    public function setElemento(_data:Object):void
    {
        switch(_data.mc)
        {
            case 'pelo_mc':
                    _pelo = _data;
                break;

            case 'ojos_mc':
                _ojos = _data;
                break;

            case 'gafas_mc':
                _gafas = _data;
                break;

            case 'boca_mc':
                _boca = _data;
                break;

            case 'camisa_mc':
                _camisa = _data;
                break;

            case 'pantalon_mc':
                _pantalon = _data;
                break;

            case 'zapato_mc':
                _zapatos = _data;
                break;

            case 'falda_mc':
                _pantalon = _data;
                break;

            case 'top_mc':
                _camisa = _data;
                break;
        }
    }


    public function setPartes(_data:Object):void
    {

        this._ojos = { mc: 'ojos_mc', name: _data.ojos as String }
        this._boca = { mc: 'boca_mc', name: _data.boca as String }
        this._pelo = { mc: 'pelo_mc', name: _data.pelo as String }

        // GAFAS
        if(_data.gafas != 'nada')
        {
            this._gafas = { mc: 'gafas_mc', name: _data.gafas as String }

        }


        // PANTALON - FALDA
        if(_data.pantalon != 'nada')
        {
            if(_data.pantalon.length > 0 && _data.pantalon.parte1)
            {
                var nItem:String = String(_data.pantalon).substr(String(_data.pantalon).length - 1, 1);

                this._pantalon = {
                    tipoPartes: '_pantalon',
                    parte1: 'PiernaIzq_' + nItem,
                    parte2: 'Paquete_' + nItem,
                    parte3: 'PiernaDer_' + nItem
                }
            }
            else
            {
                var nItem:String = String(_data.falda).substr(String(_data.falda).length - 1, 1);

                this._pantalon = {
                    tipoPartes: '_pantalon',
                    parte2: 'Falda_' + nItem,
                    mc: 'falda_mc'
                }
            }
        }



        // CAMISA -TOP
        if(_data.camisa != 'nada')
        {
            if(_data.camisa.length > 0 && _data.camisa.parte1)
            {
                var nItemCamisa:String = String(_data.camisa).substr(String(_data.camisa).length - 1, 1);

                this._camisa = {
                    tipoPartes: '_camisa',
                    parte1: 'BrazoIzq_' + nItemCamisa,
                    parte2: 'Torso_' + nItemCamisa,
                    parte3: 'BrazoDer_' + nItemCamisa
                }
            }
            else
            {
                var nItemCamisa:String = String(_data.falda).substr(String(_data.falda).length - 1, 1);

                this._pantalon = {
                    tipoPartes: '_camisa',
                    parte2: 'Top_' + nItemCamisa,
                    mc: 'top_mc'
                }
            }
        }



        //ZAPATOS
        if(_data.zapatos != 'nada')
        {
            var nItemZapatos:String = String(_data.zapatos).substr(String(_data.zapatos).length - 1, 1);
            this._zapatos = {

                tipoPartes: '_zapatos',
                parte1: 'ZapatoIzq_' + nItemZapatos,
                parte2: 'ZapatoDer_' + nItemZapatos

            }
        }

        var cosa:Array = new Array();
        cosa = [_pantalon, _boca, _camisa, _gafas, _ojos, _pelo, _zapatos];
        MonsterDebugger.trace(this, '[SET AVATAR]');
        MonsterDebugger.trace(this, cosa);

    }


    public function setSexo(_data:String):void
    {
         this.sexo = _data;
    }

    public function setIdAvatar(_data:String):void
    {
        this.id_avatar = _data;
    }



    // GETTERS
    public function getSexo():String
    {
        return this.sexo;
    }

    public function getPantalon():Object {
        return _pantalon;
    }

    public function getBoca():Object {
        return _boca;
    }

    public function getOjos():Object {
        return _ojos;
    }

    public function  getCamisa():Object {
        return _camisa;
    }

    public function getGafas():Object {
        return _gafas;
    }

    public function getZapatos():Object {
        return _zapatos;
    }

    public function getPelo():Object {
        return _pelo;
    }

    public function getIdAvatar():String
    {
        return this.id_avatar;
    }
}
}
