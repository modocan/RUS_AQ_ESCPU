package {

import flash.display.Loader;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.ProgressEvent;
import flash.external.ExternalInterface;
import flash.net.URLRequest;
import flash.text.TextField;

[SWF(frameRate="24", height="820", width="810", backgroundColor="#FFFFFF")]
public class Cargador extends Sprite {

    private var _this:Cargador;
    private var cargador:Loader;
    private var precarga:PrecargaCerdo;

    public function Cargador()
    {

        super();
        _this = this;
        _this.addEventListener(Event.ADDED_TO_STAGE, init);

    }

    private function init(e:Event):void
    {
        _this.removeEventListener(Event.ADDED_TO_STAGE, init);

        precarga = new PrecargaCerdo();
        precarga.x = _this.stage.stageWidth/2;
        precarga.y = _this.stage.stageHeight/2;
        precarga.scaleX = precarga.scaleY = 0.4;
        precarga.addEventListener(Event.ADDED_TO_STAGE, initPrecarga);
        _this.addChild(precarga);


        function initPrecarga(e:Event):void
        {
            precarga.removeEventListener(Event.ADDED_TO_STAGE, initPrecarga);

            cargador = new Loader();
            cargador.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progresoCarga);
            cargador.contentLoaderInfo.addEventListener(Event.COMPLETE, finPrecarga);
            cargador.visible = false;
            cargador.load(new URLRequest('EscuelaPueblo.swf'));
            _this.addChild(cargador);
        }

    }

    private function finPrecarga(e:Event):void
    {
        _this.removeChild(precarga);
        cargador.visible = true;
        ExternalInterface.call('colocaPie');
    }

    private function progresoCarga(e:ProgressEvent):void
    {
        var porc:Number = Math.ceil((Number(e.currentTarget.bytesLoaded) * 100)/Number(e.currentTarget.bytesTotal));
        precarga.texto_txt.text = String(porc) + '%';
    }
}
}
