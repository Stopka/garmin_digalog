using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.Math  as Math;

class ArrowDrawable {
	
	static function draw(dc, hour, min){
		drawHour(dc, hour, min);
		drawMinute(dc, min);
	}
	
	static function drawHour(dc, hour, min){
		var dimensions = DeviceConfigs.getDialDimensions();
		var d = dimensions.get(:d);
		var points = buildArrowPolygon(d/8,d/10,dimensions.get(:w)/2,dimensions.get(:sh)+2+d/8);
		points = ShapeHelper.getPolygonRotated(
			points,
			[dc.getWidth()/2, dc.getHeight()/2],
			Math.toRadians((hour+min/60.0)*360.0/12.0)
		);
		ShapeHelper.drawPolygon(
			dc,
			points,
			SettingGroups.getSetColor("ColorHour"),
			SettingGroups.getSetColor("ColorBackground"),
			d*0.01
		);
	}
	
	static function drawMinute(dc, min){
		var dimensions = DeviceConfigs.getDialDimensions();
		var d = dimensions.get(:d);
		var points = buildArrowPolygon(d/10,d/8,dimensions.get(:w)/2,dimensions.get(:sh)+2);
		points = ShapeHelper.getPolygonRotated(
			points,
			[dc.getWidth()/2, dc.getHeight()/2],
			Math.toRadians(min*360/60)
		);
		ShapeHelper.drawPolygon(
			dc,
			points,
			SettingGroups.getSetColor("ColorMinute"),
			SettingGroups.getSetColor("ColorBackground"),
			d*0.01
		);
	}
    
    static function buildArrowPolygon(width,height,offsetX,offsetY){
		return [
			[offsetX+0, offsetY+0],
			[offsetX+width/2, offsetY+height],
			[offsetX-width/2, offsetY+height]
		];
	}
    
}