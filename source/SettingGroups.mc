using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class SettingGroups {
	
	static function getWeekDay(val){
		var weekDays=[
    		Rez.Strings.DaySunday,
			Rez.Strings.DayMonday,
			Rez.Strings.DayTuesday,
			Rez.Strings.DayWednesday,
			Rez.Strings.DayThursday,
			Rez.Strings.DayFriday,
			Rez.Strings.DaySaturday
		];
		return weekDays[val-1];
	}
	
	static function getDateFormat(val){
		var dateFormats=[
			"$1$.$2$.$3$",
			"$1$/$2$/$3$",
			"$2$/$1$/$3$",
			"$3$/$2$/$1$",
			"$3$-$2$-$1$"
		];
		if(val<0 || val>=dateFormats.size()){
			return dateFormats[0];
		}
		return dateFormats[val];
	}
	
	static function getSetDateFormat(){
		return getDateFormat(App.getApp().getProperty("DateFormat"));
	}
	
	static function getColor(val){
		var colors=[
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
		if(val<0 || val>=colors.size()){
			return colors[0];
		}
		return colors[val];
	}
	
	static function getSetColor(key){
		return getColor(App.getApp().getProperty(key));
	}
	
}