package commands {

import com.demonsters.debugger.MonsterDebugger;
import com.hexagonstar.util.debug.Debug;

import events.ConfiguradorEvent;

import models.IAvatarModel;

import models.IDBModel;

import org.robotlegs.mvcs.Command;

	public class MenuCategoriasCommand extends Command {
	
	    [Inject]
	    public var _evt:ConfiguradorEvent;
	
	    [Inject]
	    public var _modelo:IDBModel;

        [Inject]
        public var avatar:IAvatarModel;
	
	
	    public function MenuCategoriasCommand()
        {
	        super();
	    }
	
	    override public function execute():void
	    {
            avatar.setSexo(_evt.datos.sexo as String);
			_modelo.cargarElementos(_evt.datos.sexo as String);
	    }
	
	}
}
