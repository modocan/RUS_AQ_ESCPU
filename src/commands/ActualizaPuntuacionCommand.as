/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 10/10/12
 * Time: 11:23
 * To change this template use File | Settings | File Templates.
 */
package commands {
import com.demonsters.debugger.MonsterDebugger;

import events.JuegoEvent;

import models.IJuegosModel;
import models.IUsuarioModel;

import org.robotlegs.mvcs.Command;

import services.IUsuarioService;

public class ActualizaPuntuacionCommand extends Command {

    [Inject]
    public var ev:JuegoEvent;

    [Inject]
    public var juegos:IJuegosModel;

    [Inject]
    public var usuario:IUsuarioModel;

    [Inject]
    public var usuario_service:IUsuarioService;

    public function ActualizaPuntuacionCommand()
    {
        super();
    }


    override public function execute():void
    {
        var puntuacionNueva:Number =  Number(juegos.parseaNota(ev.datos as String));
        var puntuacionAnterior:Number =  Number(juegos.parseaNota(juegos.getJuegos()[juegos.getPosJuegoActual()].puntos));


        MonsterDebugger.trace(this, '[COMPARA PUNTOS]');
        MonsterDebugger.trace(this, puntuacionNueva);
        MonsterDebugger.trace(this, puntuacionAnterior);

        if(puntuacionNueva > puntuacionAnterior);
        {
            MonsterDebugger.trace(this, '[entro]');

            var reg_anterior:Array = new Array();
            reg_anterior = juegos.getJuegos();

            reg_anterior[juegos.getPosJuegoActual()].puntos = ev.datos as String;



            juegos.setJuegos(reg_anterior);

            MonsterDebugger.trace(this, '[NUEVOS PUNTOS]');
            MonsterDebugger.trace(this, juegos.getJuegos());

            var _data:Object = new Object();
            _data = {
                id_fb: usuario.get_idFB() as String,
                nota: ev.datos as String,
                //nota: '1',
                juego: 'PTOS' + (juegos.getPosJuegoActual() + 1), //PTOS1 - PTOS2 - PTOS3
                nombre: usuario.getNombreUsuario() as String
            }

            MonsterDebugger.trace(this, 'juego a guardar: ' + _data.juego);
            MonsterDebugger.trace(this, 'id_fb a guardar: ' + _data.id_fb);
            MonsterDebugger.trace(this, 'nombre a guardar: ' + _data.nombre);
            MonsterDebugger.trace(this, 'nota a guardar: ' + _data.nota);

            usuario_service.actualizaPuntos(_data);
        }
    }


}
}
