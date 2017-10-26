using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class MinuteHandDrawable extends BorderedDrawable {
	function setMinutes(min){
		self.getDrawable().setRotation(Math.toRadians(min*360/60.0));
	}
	
	function initialize(params){
		var app = App.getApp();
		var w = System.getDeviceSettings().screenWidth;
		var h = System.getDeviceSettings().screenHeight;
		var d = app.getProperty("DialWidth");
		var arrow = new ArrowShapeDrawable({},app.getProperty("HandMinuteWidth"),app.getProperty("HandMinuteHeight"),w/2,(h-d)/2);
		arrow.setRotationCenter(w/2,h/2);
		setColor(app.getProperty("ColorMinute"));
		setBorderColor(app.getProperty("ColorBackground"));
		setBorderWidth(app.getProperty("BorderWidth"));
		BorderedDrawable.initialize(params,arrow);
	}
}