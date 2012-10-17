/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 08/10/12
 * Time: 16:54
 * To change this template use File | Settings | File Templates.
 */
package models {
public interface IJuegosModel {

    function getJuegos():Array
    function setJuegos(_data:Array):void

    function setJuegoActual(_data:uint):void
    function getJuegoActual():Object

    function parseaNota(_nota:String):Number

    function getPosJuegoActual():uint

}
}
