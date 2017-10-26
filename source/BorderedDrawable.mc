using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class BorderedDrawable extends ColorableDrawable {
	protected var infill=true;
	protected var borderColor = Gfx.COLOR_BLACK;
	protected var borderWidth=0;
	
	function initialize(params, drawable) {
        ColorableDrawable.initialize(params, drawable);
    }
	
	function enableInfill(value){
		self.infill = value;
	}
	
	function isInfillEnabled(){
		return self.infill;
	}
	
	function getBorderColor(){
		return self.borderColor;
	}
	
	function setBorderColor(value){
		self.borderColor = value;
	}
	
	function setBorderWidth(value){
		self.borderWidth = value;
	}
	
	function getBorerWidth(){
		return self.borderWidth;
	}
	
	function draw(dc){
		if(infill){
			ColorableDrawable.draw(dc);
		}
		if(borderWidth>0){
			dc.setColor(borderColor, bgcolor);
			dc.setPenWidth(borderWidth);
			drawable.drawBorder(dc);
		}
	}
}