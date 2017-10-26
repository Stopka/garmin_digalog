using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class ColorableDrawable extends TransientDrawable {
	protected var color=Gfx.COLOR_TRANSPARENT;
	protected var bgcolor=Gfx.COLOR_WHITE;
	
	function initialize(params, drawable) {
        TransientDrawable.initialize(params, drawable);
    }
    
    function setColor(color){
    	self.color = color;
    }
    
    function getColor(){
    	return color;
    }
	
	function draw(dc){
		dc.setColor(color, bgcolor);
		drawable.draw(dc);
	}

}