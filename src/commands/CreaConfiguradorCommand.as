/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 26/09/12
 * Time: 12:47
 * To change this template use File | Settings | File Templates.
 */
package commands {
import org.robotlegs.mvcs.Command;

import views.MainView;

public class CreaConfiguradorCommand extends Command {

    public function CreaConfiguradorCommand()
    {
        super();
    }


    override public function execute():void
    {
        var main:MainView = new MainView();
        main.y = 34;
        contextView.addChildAt(main, 1);
    }


}
}
