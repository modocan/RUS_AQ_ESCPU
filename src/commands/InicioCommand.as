/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 15/10/12
 * Time: 13:32
 * To change this template use File | Settings | File Templates.
 */
package commands {
import com.greensock.TweenMax;

import org.robotlegs.mvcs.Command;

import services.IFBService;

import views.MainView;

public class InicioCommand extends Command {

    [Inject]
    public var fb:IFBService;

    public function InicioCommand()
    {
        super();
    }


    override public function execute():void
    {
        if(contextView.getChildAt(1))
        {
            contextView.removeChildAt(1);
        }
        fb.init();
        //contextView.addChildAt(new MainView(), 1);
    }

}
}
