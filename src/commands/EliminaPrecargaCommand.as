/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 19/10/12
 * Time: 18:29
 * To change this template use File | Settings | File Templates.
 */
package commands {
import org.robotlegs.mvcs.Command;

public class EliminaPrecargaCommand extends Command {

    public function EliminaPrecargaCommand()
    {
        super();
    }


    override public function execute():void
    {
        for(var i:uint = 0; i < contextView.numChildren; i++)
        {
            if(contextView.getChildAt(i) is PrecargaCerdo)
            {
                contextView.removeChild(contextView.getChildAt(i));
            }
        }
    }

}
}
