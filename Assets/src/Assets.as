package {

import flash.display.Sprite;
import flash.text.TextField;

public class Assets extends Sprite {
    public function Assets() {
        var textField:TextField = new TextField();
        textField.text = "Hello, World";
        addChild(textField);
    }
}
}
