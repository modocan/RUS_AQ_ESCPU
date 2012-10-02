package commands {
	
import com.hexagonstar.util.debug.Debug;

import events.ConfiguradorEvent;

import services.IFBService;

import org.robotlegs.mvcs.Command;

	public class FBCommand extends Command {
	
	    [Inject]
	    public var _evt:ConfiguradorEvent;
	
	    [Inject]
	    public var _modelo:IFBService;
	
	
	    public function FBCommand() {
	        super();
	    }
	
	    override public function execute():void
	    {
			Debug.trace('Comando FBCommand');
			//_modelo.init();
	    }
	
	}
}
