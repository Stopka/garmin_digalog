using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class PolygonShapeDrawable extends ShapeDrawable {
	var polygon;
	var translated;
	function initialize(params, polygon) {
		self.polygon = polygon;
        ShapeDrawable.initialize(params);
    }
    
    function getTranslated(){
    	if(translated==null){
    		translated = new [polygon.size()];
			for (var i = 0; i < polygon.size(); i += 1) {
			    translated[i] = getPointPosition(polygon[i]);
			}
    	}
    	return translated;
    }
    
    function setLocation(x, y){
    	translated = null;
		ShapeDrawable.setLocation(x, y);
	}
    
    function setRotation(value){
    	translated = null;
		ShapeDrawable.setRotation(value);
	}
	
	function setRotationCenter(x,y){
		translated = null;
		ShapeDrawable.setRotationCenter(x,y);
	}
	
	function draw(dc){
		dc.fillPolygon(getTranslated());
	}
	
	function drawBorder(dc){
		var points = getTranslated();
		var pointA;
		var pointB = points[points.size()-1];
		for(var i=0;i<points.size();i++){
			pointA=pointB;
			pointB=points[i];
			dc.drawLine(pointA[0],pointA[1],pointB[0],pointB[1]);
		}
	}
}