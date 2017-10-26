using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Application as App;
using Toybox.Time as Time;
using Toybox.System as Sys;

class DigalogView extends Ui.WatchFace {
	var weekDays;
	var sleep = true;
	var enableSeconds=true;
	var formats;
    function initialize() {
    	self.weekDays = [
    		Rez.Strings.DaySunday,
			Rez.Strings.DayMonday,
			Rez.Strings.DayTuesday,
			Rez.Strings.DayWednesday,
			Rez.Strings.DayThursday,
			Rez.Strings.DayFriday,
			Rez.Strings.DaySaturday
		];
		formats=[
			"$1$.$2$.$3$",
			"$1$/$2$/$3$",
			"$2$/$1$/$3$",
			"$3$/$2$/$1$",
			"$3$-$2$-$1$"
		];
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
        
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
        var app = App.getApp();
    	var view;   
       	view = View.findDrawableById("TimeDay");
       	view.setColor(app.getProperty("ColorDay"));
       	view = View.findDrawableById("TimeHours");
       	view.setColor(app.getProperty("ColorHour"));
       	view = View.findDrawableById("TimeMinutes");
       	view.setColor(app.getProperty("ColorMinute"));
       	view = View.findDrawableById("TimeSeconds");
       	view.setColor(app.getProperty("ColorSecond"));
       	view = View.findDrawableById("TimeDate");
       	view.setColor(app.getProperty("ColorDate"));
       	enableSeconds = app.getProperty("EnableSeconds");
    }

    // Update the view
    function onUpdate(dc) {
        var clockTime = System.getClockTime();
        var dateInfo = Time.Gregorian.info(Time.now(), Time.FORMAT_SHORT);
       	var view;   
       	view = View.findDrawableById("HourHandDrawable");
        view.setHours(clockTime.hour,clockTime.min);     
       	view = View.findDrawableById("TimeHours");
       	var hours = clockTime.hour;
        if (!Sys.getDeviceSettings().is24Hour) {
            hours = hours % 12;
        }
        view.setText(hours.format("%02d"));
       	view = View.findDrawableById("CenterDrawable");
       	view.setShow(self.sleep||!enableSeconds);
        
        view = View.findDrawableById("TimeMinutes");
        view.setText(clockTime.min.format("%02d"));
        
        view = View.findDrawableById("MinuteHandDrawable");
        view.setMinutes(clockTime.min);
        
        view = View.findDrawableById("TimeSeconds");
        view.setText(self.sleep||!enableSeconds?"":clockTime.sec.format("%02d"));
        
        view = View.findDrawableById("SecondHandDrawable");
        view.setSeconds(clockTime.sec);
        view.setShow(!self.sleep&&enableSeconds);

		view = View.findDrawableById("TimeDay");
		view.setText(SettingGroups.getWeekDay(dateInfo.day_of_week-1));
		
		view = View.findDrawableById("TimeDate");
		view.setText(Lang.format(SettingGroups.getSetDateFormat(),[
			dateInfo.day.format("%02d"),
			dateInfo.month.format("%02d"),
			dateInfo.year.format("%04d")
		]));

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    	self.sleep = false;
    	
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    	self.sleep = true;
    }

}
