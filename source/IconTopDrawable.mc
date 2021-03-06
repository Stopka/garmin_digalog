using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.Math  as Math;
using Toybox.System as Sys;

class IconTopDrawable {

	static function getDisturbStats(){
		var show = App.getApp().getProperty("ShowDisturb");
		var doNotDisturb=false;
		if(Sys.DeviceSettings has :doNotDisturb){
			doNotDisturb = Sys.getDeviceSettings().doNotDisturb;
		}
		Sys.println(doNotDisturb ? "Do not disturb" : "Can disturb");
		if(
			(show==0 || !doNotDisturb)
		){
			return null;
		}
		return {
			:doNotDisturb => doNotDisturb
		};
	}

	static function getBatteryStats(){
		var low=10;
		var limit=20;
		var show = App.getApp().getProperty("ShowBattery");
		var stats=Sys.getSystemStats();
		var charging = false;
		if(Sys.Stats has :charging){
			charging = stats.charging;
		}
		Sys.println("Battery: "+stats.battery.format("%02.2f")+(charging?" charging":""));
		if(
			(show==0) ||
			(show==1 && stats.battery > limit) ||
			(show==2 && !charging) ||
			(show==3 && stats.battery > limit && !charging)
		){
			return null;
		}
		return {
			:charging => charging,
			:battery=> stats.battery,
			:low => low,
			:limit => limit
		};
	}
	
	static function getConnectionStats(){
		var show = App.getApp().getProperty("ShowConnection");
		var connected=Sys.getDeviceSettings().phoneConnected;
		Sys.println(connected?"Phone connected":"Phone disconnected");
		if(
			(show==0) ||
			(show==1 && !connected) ||
			(show==2 && connected)
		){
			return null;
		}
		return {
			:connected => connected
		};
	}

	static function draw(dc){
		var stats = new [3];
		stats[0] = getBatteryStats();
		stats[1] = getConnectionStats();
		stats[2] = getDisturbStats();
		var iconCount = 0;
		for(var i = 0; i < stats.size(); i++ ) {
			if(stats[i]!=null){
				iconCount+=1;
			}
		}
		var dim = DeviceConfigs.getDialDimensions();
		var y=dim.get(:sh)+(dim.get(:d)-Gfx.getFontHeight(Gfx.FONT_NUMBER_HOT))/2-0.5*Gfx.getFontHeight(Gfx.FONT_MEDIUM);
		if(dim.get(:sh)<Gfx.getFontHeight(Gfx.FONT_MEDIUM)){
			//y=dim.get(:sh)+dim.get(:d)/7.0;
			y = dim.get(:sh)+(dim.get(:d)-Gfx.getFontHeight(Gfx.FONT_NUMBER_HOT))/2-1.5*Gfx.getFontHeight(Gfx.FONT_MEDIUM);
		}
		var w = Gfx.getFontHeight(Gfx.FONT_MEDIUM);//dim.get(:d)*0.12;
		var spacer = [w+2,0];
		var x=dim.get(:sw)+dim.get(:d)/2.0-(iconCount-1)*spacer[0]/2.0;
		if(dim.get(:sw)>=Gfx.getFontHeight(Gfx.FONT_MEDIUM)){
			spacer = [spacer[1],spacer[0]];
			y = dim.get(:sh)+dim.get(:d)/2.0-(iconCount-1)*spacer[1]/2.0;
			x = w/2;
		}
		if(stats[0]){
			drawBatteryIcon(dc,stats[0],x,y,w);
			x+=spacer[0];
			y+=spacer[1];
		}
		if(stats[1]){
			drawConnectionIcon(dc,stats[1],x,y,w);
			x+=spacer[0];
			y+=spacer[1];
		}
		if(stats[2]){
			drawDisturbIcon(dc,stats[2],x,y,w);
		}
	}
	
	static function drawRect(dc,x,y,w){
		/*
		dc.setColor(Gfx.COLOR_DK_GREEN,0);
		dc.setPenWidth(1);
		dc.drawRectangle(x-w/2, y-w/2, w, w);
		/**/
	}
	
	static function drawBatteryIcon(dc,stats,x,y,width){
		drawRect(dc,x,y,width);
		var height=width/2.0;
		var thickness=width/8.0;
		if(stats.get(:battery)<=stats.get(:low) && !stats.get(:charging)){
			dc.setColor(SettingGroups.getSetColor("ColorWarning"),0);
		}else{
			dc.setColor(SettingGroups.getSetColor("ColorIcon"),0);
		}
		dc.setPenWidth(thickness);
		dc.fillRectangle(x-width/2+thickness/2, y-height/2, (width-1.5*thickness)*stats.get(:battery)/100, height);
		dc.drawRectangle(x-width/2+thickness/2, y-height/2, width-1.5*thickness, height);
		dc.drawRectangle(x+width/2-thickness, y-height/2+height/3, thickness, height/3);
		if(stats.get(:charging)){
			dc.setColor(SettingGroups.getSetColor("ColorWarning"),0);
			dc.fillPolygon([
				[x-thickness*2,y-height/2+thickness],
				[x-thickness*2,y+height/2-thickness],
				[x,y],
			]);
			dc.fillPolygon([
				[x,y-height/2+thickness],
				[x,y+height/2-thickness],
				[x+thickness*2,y],
			]);
		}
	}
	
	static function drawConnectionIcon(dc,stats,x,y,w){
		drawRect(dc,x,y,w);
		var thickness=w/8;
		var innerw=5*w/7;
		dc.setPenWidth(thickness);
		dc.setColor(SettingGroups.getSetColor("ColorIcon"),0);
		if(Gfx.Dc has :setClip){
			dc.setClip(x-innerw/2, y-innerw/2, innerw, innerw);
			for(var i=0; i<3; i++){
				dc.drawEllipse(x-innerw/2, y+innerw/2, thickness*(2*i+1), thickness*(2*i+1));
			}
			dc.clearClip();
		}else{
			//Draw arc without cliping
			var center=[x-innerw/2, y+innerw/2];
			for(var i=0; i<3; i++){
				var point=[center[0],center[1]-thickness*(2*i+1)];
				for(var i=0; i<4; i++){
					var rotated=ShapeHelper.getPointRotated(point,center,Math.toRadians(90/4));
					dc.drawLine(point[0], point[1],rotated[0], rotated[1]);
					point = rotated;
				}
			}
		}
		if(!stats.get(:connected)){
			dc.setColor(SettingGroups.getSetColor("ColorWarning"),0);
			dc.drawLine(x+innerw/2, y-innerw/2,x, y);
			dc.drawLine(x, y-innerw/2, x+innerw/2, y);
		}
	}
	
	static function drawDisturbIcon(dc,stats,x,y,w){
		drawRect(dc,x,y,w);
		var thickness=w/8.0;
		var innerw=5*w/7.0;
		dc.setPenWidth(thickness);
		dc.setColor(SettingGroups.getSetColor("ColorIcon"),0);
		dc.fillEllipse(x, y, innerw/2.0, innerw/2.0);
		dc.setColor(SettingGroups.getSetColor("ColorBackground"),0);
		dc.drawLine(Math.ceil(x-innerw/4.0), y,Math.floor(x+innerw/4.0), y);
	}
    
}