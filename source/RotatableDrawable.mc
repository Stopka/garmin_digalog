using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class RotatableDrawable extends Ui.Drawable {
	var rotation = 0;
	var rotationCenter=[0,0];
	
	function initialize(params) {
        Drawable.initialize(params);
    }
	
	function setRotation(value){
		self.rotation = value;
	}
	
	function setRotationCenter(x,y){
		rotationCenter[0]=x;
		rotationCenter[1]=y;
	}
	
	function getPointPosition(point){
		return [
			Math.cos(rotation)*(point[0]-rotationCenter[0])-Math.sin(rotation)*(point[1]-rotationCenter[1])+rotationCenter[0]+locY,
			Math.sin(rotation)*(point[0]-rotationCenter[0])+Math.cos(rotation)*(point[1]-rotationCenter[1])+rotationCenter[1]+locY
		];
	}
}