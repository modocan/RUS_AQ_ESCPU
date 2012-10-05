/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 26/09/12
 * Time: 12:41
 * To change this template use File | Settings | File Templates.
 */
package models {
public interface IAvatarModel
{

    // SETTERS
    function setPartes(_data:Object):void
    function setSexo(_data:String):void
    function setElemento(_data:Object):void
    function setIdAvatar(_data:String):void



    // GETTERS
    function getSexo():String

    function getPelo():Object
    function getCamisa():Object
    function getPantalon():Object
    function getOjos():Object
    function getBoca():Object
    function getZapatos():Object
    function getGafas():Object
    function getIdAvatar():String

}
}
