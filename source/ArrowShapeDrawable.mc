using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class ArrowShapeDrawable extends PolygonShapeDrawable {
	var heigh=10;
	var width=5;
	var position=[0,0];
	
	function initialize(params, width, height, positionX, positionY) {
		self.height = height;
		self.width = width;
		self.position = [positionX,positionY];
        PolygonShapeDrawable.initialize(params, buildPolygon());
    }
    
    function buildPolygon(){
    	return [
			[position[0]+0,position[1]+0],
			[position[0]+width/2, position[1]+height],
			[position[0]-width/2, position[1]+height]
		];
    }
}