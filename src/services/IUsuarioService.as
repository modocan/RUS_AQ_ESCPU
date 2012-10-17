/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 14/09/12
 * Time: 12:39
 * To change this template use File | Settings | File Templates.
 */
package services {
public interface IUsuarioService {

    function dameUsuario(_id:String):void

    function guardaAvatar(_data:Object):void

    function actualizaPuntos(_data:Object):void


}
}
