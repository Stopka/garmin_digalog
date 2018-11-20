using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.Math as Math;

class DialDrawable {
	
	static function drawMark(dc, i, d, center){
		var l = d/37.0;
		var w = 1;
		if(i % 5 == 0){
			l = l * 1.5;
			w = w * 2;
		}
		if(i % 15 == 0){
			l = l * 1.5;
			w = w * 2;
		}
		var points = [
			[center[0],center[1]-d/2],
			[center[0],center[1]-d/2+l]
		];
		var rotation = Math.toRadians(i*360/60);
		points = ShapeHelper.getPolygonRotated(points,center,rotation);
		dc.setPenWidth(w);
		dc.drawLine(points[0][0],points[0][1],points[1][0],points[1][1]);
	}

	static function draw(dc){
		dc.setColor(SettingGroups.getSetColor("ColorDial"), SettingGroups.getSetColor("ColorBackground"));
		var dimensions = DeviceConfigs.getDialDimensions();
		var d = dimensions.get(:d);
		var center = [
			dimensions.get(:sw)+d/2,
			dimensions.get(:sh)+d/2
		];
		dc.clear();
		for( var i = 0; i < 60; i += 1 ){
			drawMark(dc, i, d, center);
		}
	}
}