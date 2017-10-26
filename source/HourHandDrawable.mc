using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class HourHandDrawable extends BorderedDrawable {
	function setHours(hr,min){
		hr=hr+min/60.0;
		self.getDrawable().setRotation(Math.toRadians(hr*360/12.0));
	}
	
	function initialize(params){
		var app = App.getApp();
		var w = System.getDeviceSettings().screenWidth;
		var h = System.getDeviceSettings().screenHeight;
		var d = app.getProperty("DialWidth");
		var arrow = new ArrowShapeDrawable({},app.getProperty("HandHourWidth"),app.getProperty("HandHourHeight"),w/2,(h-d)/2+app.getProperty("HandHourOffset"));
		arrow.setRotationCenter(w/2,h/2);
		setColor(app.getProperty("ColorHour"));
		setBorderColor(app.getProperty("ColorBackground"));
		setBorderWidth(app.getProperty("BorderWidth"));
		BorderedDrawable.initialize(params,arrow);
	}
}