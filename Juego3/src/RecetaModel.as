/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 07/10/12
 * Time: 15:29
 * To change this template use File | Settings | File Templates.
 */
package {

import com.demonsters.debugger.MonsterDebugger;

import flash.display.DisplayObject;
import flash.events.EventDispatcher;
[Bindable]
public class RecetaModel {

    public var _ingrediente_1:Object;
    public var _ingrediente_2:Object;
    public var _ingrediente_3:Object;
    public var _ingrediente_4:Object;
    public var _ingrediente_5:Object;
    public var _nombre:String;
    public var tachados:uint = 0;

    public var cosa:String = 'cosiña';


    /** Only one instance of the model locator **/

    private static var instance:RecetaModel = new RecetaModel();

    /** Bindable Data **/

    public var flexData:String = "SuperApp";
    public var userScore:int = 0;

    public function RecetaModel()
    {
        if(instance)
        {
            throw new Error ("We cannot create a new instance. Please use RecetaModel.getInstance()");
        }
    }

    public static function getInstance():RecetaModel
    {
        return instance;
    }


    public function comparaIngrediente(ing:String):String
    {
        var resp:String = '';

        switch (ing)
        {
            case  _ingrediente_1.clase:
                    resp = _ingrediente_1.texto;
                break;

            case  _ingrediente_2.clase:
                resp = _ingrediente_2.texto;
                break;

            case  _ingrediente_3.clase:
                resp = _ingrediente_3.texto;
                break;

            case  _ingrediente_4.clase:
                resp = _ingrediente_4.texto;
                break;

            case _ingrediente_5.clase:
                resp = _ingrediente_5.texto;
                break;
        }

        return resp;
    }


    public function setReceta(_receta:Object):void
    {
        _ingrediente_1 = new Object();
        _ingrediente_1 = {clase: _receta.ingredientes.ing1_clip, texto: _receta.ingredientes.ing1};

        _ingrediente_2 = new Object();
        _ingrediente_2 = {clase: _receta.ingredientes.ing2_clip, texto: _receta.ingredientes.ing2};

        _ingrediente_3 = new Object();
        _ingrediente_3 = {clase: _receta.ingredientes.ing3_clip, texto: _receta.ingredientes.ing3};

        _ingrediente_4 = new Object();
        _ingrediente_4 = {clase: _receta.ingredientes.ing4_clip, texto: _receta.ingredientes.ing4};

        _ingrediente_5 = new Object();
        _ingrediente_5 = {clase: _receta.ingredientes.ing5_clip, texto: _receta.ingredientes.ing5};

        _nombre = _receta.receta;
        tachados = 0;

    }


}
}

