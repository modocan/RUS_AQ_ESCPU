/**
 * Created with IntelliJ IDEA.
 * User: gonzalocedillo
 * Date: 19/10/12
 * Time: 18:57
 * To change this template use File | Settings | File Templates.
 */
package commands {
import events.ConfiguradorEvent;

import org.robotlegs.mvcs.Command;

public class ProgresoCargaCommand extends Command{

    [Inject]
    public var ev:ConfiguradorEvent;

    public function ProgresoCargaCommand()
    {
        super();
    }


    override public function execute():void
    {
        for(var i:uint = 0; i < contextView.numChildren; i++)
        {
            if(contextView.getChildAt(i) is PrecargaCerdo)
            {
                PrecargaCerdo(contextView.getChildAt(i)).texto_txt.text = ev.datos + '%';
            }
        }
    }

}
}
