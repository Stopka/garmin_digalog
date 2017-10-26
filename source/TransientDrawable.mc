using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class TransientDrawable extends Ui.Drawable {
	protected var drawable;
	
	function initialize(params, drawable) {
        self.drawable = drawable; //getDrawable();
        Drawable.initialize(params);
    }
	
	function getDrawable(){
		return self.drawable;
	}
	
	function draw(dc){
		self.drawable.draw(dc);
	}
	
	function setLocation(x, y) {
        self.drawable.setLocation(x, y);
    }

    function setSize(w, h) {
        self.drawable.setSize(w, h);
    }

}