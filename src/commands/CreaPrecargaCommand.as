/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 19/10/12
 * Time: 18:26
 * To change this template use File | Settings | File Templates.
 */
package commands {
import org.robotlegs.mvcs.Command;

import starling.utils.formatString;

import views.InterfazView;

import views.MainView;

public class CreaPrecargaCommand extends Command
{

    public function CreaPrecargaCommand()
    {
        super();
    }


    override public function execute():void
    {
        var main:InterfazView;
        for(var i:uint = 0; i < contextView.numChildren; i++)
        {
            if(contextView.getChildAt(i) is InterfazView)
            {
                main = InterfazView(contextView.getChildAt(i));
            }
        }

        var precarga:PrecargaCerdo = new PrecargaCerdo();
        precarga.x = contextView.width/2;
        precarga.y = 334;
        precarga.scaleX = precarga.scaleY = 0.3;
        contextView.addChild(precarga);
    }

}
}
