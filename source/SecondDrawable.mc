using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.Math as Math;

class SecondDrawable {
	static var lastPosition = null;
	static function draw(dc, sec){
		var dim = DeviceConfigs.getDialDimensions();
		var d = dim.get(:d);
		var point = ShapeHelper.getPointRotated(
			[d/2,dim.get(:sh)+d/24/2-1], 
			[dc.getWidth()/2, dc.getHeight()/2], 
			Math.toRadians(sec*360/60)
		);
		lastPosition = point;
		setClip(dc);
		ShapeHelper.drawCircle(
			dc, 
			point, 
			d/24/2, 
			SettingGroups.getSetColor("ColorSecond"), 
			SettingGroups.getSetColor("ColorBackground"),
			1
		);
	}
	
	static function setClip(dc){
		if(lastPosition==null){
			return;
		}
		var d = DeviceConfigs.getDialDimensions().get(:d);
		dc.setClip(
			lastPosition[0]-d/24/2, 
			lastPosition[1]-d/24/2,
			d/24,
			d/24 
		);
	}
}