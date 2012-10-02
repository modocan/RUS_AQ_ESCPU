package views
{
	import com.hexagonstar.util.debug.Debug;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class AmigosListView extends MovieClip{
		private var _this:AmigosListView;
		private var interfaz:AmigosQueJugaron=new AmigosQueJugaron();
		private var _arrFinalAmigosQueJugaron:Array=new Array();
		private var _amigoQjugo:Object;
		
		public function AmigosListView(){
			_this = this;
			_this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void{
			Debug.trace('init AmigosListView');
			_this.removeEventListener(Event.ADDED_TO_STAGE, init);
			interfaz.y=620;
			interfaz.x=90;
			_this.addChild(interfaz);
		}
		
		public function pintarAmigos(amigos:Array,amigosTodos:Object):void{
			
			Debug.trace('entro a pintarAmigos con los maigos q ya jugaron= '+amigos[0]);
			Debug.trace('amigo 1= '+amigosTodos.data[0].id);
			//Debug.inspect(amigosTodos);
			Debug.trace('todosLosAmigos.data.length ='+todosLosAmigos.data.length);

			var amigosQjugaron:Array=amigos;
			var todosLosAmigos:Object=amigosTodos;
			
			for(var i:uint=0;i<todosLosAmigos.data.length;i++){
				var n:uint=0;
				if(todosLosAmigos.data[i].id==amigosQjugaron[0]){
					Debug.trace('entro al for con el amigo q ya jugó= '+todosLosAmigos.data[i].name);
					_amigoQjugo=new Object();
					_amigoQjugo.name=todosLosAmigos.data[i].name;
					_amigoQjugo.id=todosLosAmigos.data[i].id;
					n++;
				}
				/*amigosQjugaron[i]*/
			}
		}
		
	}
}