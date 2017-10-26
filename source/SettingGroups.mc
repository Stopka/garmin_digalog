using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class SettingGroups {
	static var weekDays=[
    		Rez.Strings.DaySunday,
			Rez.Strings.DayMonday,
			Rez.Strings.DayTuesday,
			Rez.Strings.DayWednesday,
			Rez.Strings.DayThursday,
			Rez.Strings.DayFriday,
			Rez.Strings.DaySaturday
		];
	static var dateFormats=[
			"$1$.$2$.$3$",
			"$1$/$2$/$3$",
			"$2$/$1$/$3$",
			"$3$/$2$/$1$",
			"$3$-$2$-$1$"
		];
	static var colors=[
        	Gfx.COLOR_TRANSPARENT,
			Gfx.COLOR_BLACK,
        	Gfx.COLOR_WHITE,
        	Gfx.COLOR_RED,
        	Gfx.COLOR_GREEN,
        	Gfx.COLOR_BLUE,
        	Gfx.COLOR_ORANGE,
        	Gfx.COLOR_YELLOW,
        	Gfx.COLOR_PINK,
        	Gfx.COLOR_PURPLE,
        	Gfx.COLOR_LT_GRAY,
        	Gfx.COLOR_DK_GRAY,
        	Gfx.COLOR_DK_RED,
        	Gfx.COLOR_DK_GREEN,
        	Gfx.COLOR_DK_BLUE
		];
	
	static function getWeekDay(val){
		return weekDays[val-1];
	}
	
	static function getDateFormat(val){
		if(val<0 || val>=dateFormats.size()){
			return dateFormats[0];
		}
		return dateFormats[val];
	}
	
	static function getSetDateFormat(){
		return getDateFormat(App.getApp().getProperty("DateFormat"));
	}
	
	static function getColor(val){
		if(val<0 || val>=color.size()){
			return color[0];
		}
		return color[val];
	}
	
	static function getSetColor(key){
		return getColor(App.getApp().getProperty(key));
	}
}