using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.Math  as Math;
using Toybox.System as Sys;

class IconBottomDrawable {

	static function getNotificationStats(){
		var low=10;
		var show = App.getApp().getProperty("ShowNotification");
		var notifications=Sys.getDeviceSettings().notificationCount;
		Sys.println("Notifications: "+notifications.format("%02d"));
		if(
			(show == 0) ||
			(show == 1 && notifications == 0) ||
			(show == 2 && notifications == 0)
		){
			return null;
		}
		return {
			:notifications => notifications,
			:show=> show
		};
	}
	
	static function getAlarmStats(){
		var low=10;
		var show = App.getApp().getProperty("ShowAlarm");
		var alarms=Sys.getDeviceSettings().alarmCount;
		Sys.println("Alarms: "+alarms.format("%02d"));
		if(
			(show == 0) ||
			(show == 1 && alarms == 0) ||
			(show == 2 && alarms == 0)
		){
			return null;
		}
		return {
			:alarms => alarms,
			:show=> show
		};
	}

	static function draw(dc){
		var stats = new [2];
		stats[0] = getNotificationStats();
		stats[1] = getAlarmStats();
		var iconCount = 0;
		for(var i = 0; i < stats.size(); i++ ) {
			if(stats[i]!=null){
				iconCount+=1;
			}
		}
		var dim = DeviceConfigs.getDialDimensions();
		var y=dim.get(:sh)+5*dim.get(:d)/6.0;
		var w = dim.get(:d)*0.12;
		var spacer = w+2;
		var x=dim.get(:sw)+dim.get(:d)/2.0-(iconCount-1)*spacer/2.0;
		if(stats[0]){
			drawNotificationIcon(dc,stats[0],x,y,w);
			x+=spacer;
		}
		if(stats[1]){
			drawAlarmIcon(dc,stats[1],x,y,w);
			x+=spacer;
		}
	}
	
	static function drawRect(dc,x,y,w){
		/*
		dc.setColor(Gfx.COLOR_DK_GREEN,0);
		dc.setPenWidth(1);
		dc.drawRectangle(x-w/2, y-w/2, w, w);
		/**/
	}
	
	static function drawNotificationIcon(dc,stats,x,y,width){
		drawRect(dc,x,y,width);
		var height=2*width/3.0;
		var thickness=width/8.0;
		dc.setColor(SettingGroups.getSetColor("ColorIcon"),0);
		dc.setPenWidth(thickness);
		dc.fillRectangle(x-width/2.0+thickness/2.0, y-height/2.0, width-thickness/2.0, height);
		dc.setColor(SettingGroups.getSetColor("ColorBackground"),0);
		dc.drawLine(x-width/2.0+thickness/2.0, y-height/2.0, x, y);
		dc.drawLine(x+width/2.0-thickness/2.0, y-height/2.0, x, y);
		if(stats.get(:show)>=2){
			dc.setColor(SettingGroups.getSetColor("ColorWarning"),Gfx.COLOR_TRANSPARENT);
			dc.drawText(x, y, Gfx.FONT_SYSTEM_TINY, stats.get(:notifications).format("%d"), Gfx.TEXT_JUSTIFY_VCENTER+Gfx.TEXT_JUSTIFY_CENTER);
		}
	}
	
	static function drawAlarmIcon(dc,stats,x,y,width){
		drawRect(dc,x,y,width);
		var w=2*width/3.0;
		var thickness=width/8.0;
		dc.setColor(SettingGroups.getSetColor("ColorIcon"),0);
		dc.setPenWidth(thickness);
		dc.fillEllipse(x, y, w/2, w/2);
		dc.setPenWidth(thickness);
		for(var i=-1;i<=5;i+=6){
			dc.setClip(x + width/2/i, y-width/2, 2*width/5, width/3);
			dc.drawEllipse(x, y, w/2+1.5*thickness, w/2+1.5*thickness);
		}
		dc.clearClip();
		if(stats.get(:show)>=2){
			dc.setColor(SettingGroups.getSetColor("ColorWarning"),Gfx.COLOR_TRANSPARENT);
			dc.drawText(x, y, Gfx.FONT_SYSTEM_TINY, stats.get(:alarms).format("%d"), Gfx.TEXT_JUSTIFY_VCENTER+Gfx.TEXT_JUSTIFY_CENTER);
		}
	}
    
}