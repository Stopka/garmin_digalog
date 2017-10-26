using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class HidableDrawable extends TransientDrawable {
	protected var show = true;
	
	function initialize(params, drawable) {
        TransientDrawable.initialize(params, drawable);
    }
    
    function setShow(value){
    	self.show = value;
    }

    function draw(dc) {
        if(self.getDrawable() != null && self.show){
        	TransientDrawable.draw(dc);
        }
    }

}
