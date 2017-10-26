using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class CircleShapeDrawable extends ShapeDrawable {
	var radius;
	var center;
	
	function setCenterPosition(x, y){
		self.center = [x,y];
	}
	
	function getCenterPosition(){
		return self.center;
	}
	
	function setRadius(value){
		self.radius = value;
	}
	
	function getRadius(value){
		self.radius = value;
	}
	
	function initialize(params, radius, centerX, centerY) {
		setRadius(radius);
		setCenterPosition(centerX,centerY);
        ShapeDrawable.initialize(params);
    }
	
	function draw(dc){
		var point = getPointPosition(center);
		dc.fillCircle(point[0], point[1], radius);
	}
	
	function drawBorder(dc){
		var point = getPointPosition(center);
		dc.drawCircle(point[0], point[1], radius);
	}
}