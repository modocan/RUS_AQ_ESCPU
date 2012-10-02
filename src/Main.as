package
{
import com.demonsters.debugger.MonsterDebugger;

import context.MainContext;
	
	import flash.display.MovieClip;
	import flash.system.Security;
	
	import org.robotlegs.core.IContext;
	
	[SWF(frameRate="24", height="800", width="810")]
	
	public class Main extends MovieClip {
		
		private var contexto:IContext;
		
		public function Main() {
			
			Security.loadPolicyFile('http://api.facebook.com/crossdomain.xml');
			Security.loadPolicyFile('http://profile.ak.fbcdn.net/crossdomain.xml');
			Security.allowDomain('http://profile.ak.fbcdn.net');
			Security.allowInsecureDomain('http://profile.ak.fbcdn.net');

            MonsterDebugger.initialize(this);

			contexto = new MainContext(this);
		}
	}
}
