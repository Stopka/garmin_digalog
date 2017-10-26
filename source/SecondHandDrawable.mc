using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class SecondHandDrawable extends HidableDrawable {
	function setSeconds(sec){
		self.getDrawable().getDrawable().setRotation(Math.toRadians(sec*360/60.0));
	}
	
	function initialize(params){
		var app = App.getApp();
		var w = System.getDeviceSettings().screenWidth;
		var h = System.getDeviceSettings().screenHeight;
		var d = app.getProperty("DialWidth");
		var circle = new CircleShapeDrawable({},app.getProperty("HandSecondRadius"),w/2,(h-d)/2+app.getProperty("HandSecondOffset"));
		circle.setRotationCenter(w/2,h/2);
		var border = new BorderedDrawable(params,circle);
		border.setColor(app.getProperty("ColorSecond"));
		border.setBorderColor(app.getProperty("ColorBackground"));
		border.setBorderWidth(app.getProperty("BorderWidth"));
		HidableDrawable.initialize(params,border);
		
	}
}