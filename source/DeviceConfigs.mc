using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Time as Time;

class DeviceConfigs {

	static var dimensions = null;
	
	static function getDialDimensions(){
		if(dimensions==null){
			var settings = Sys.getDeviceSettings();
			var d;
			if(settings.screenWidth > settings.screenHeight){
				d = settings.screenHeight;
			}else{
				d = settings.screenWidth;
			}
			dimensions =  {
				:w => settings.screenWidth,
				:h => settings.screenHeight,
				:d => d,
				:sh => (settings.screenHeight-d)/2,
				:sw => (settings.screenWidth-d)/2
			};
		}
		return dimensions;
	}
	
	static function getDayY(){
		var dim = getDialDimensions();
		//If not enough space above dial
		if(dim.get(:sh)<Gfx.getFontHeight(Gfx.FONT_MEDIUM)){
			//Position above time text
			return (dim.get(:h)-Gfx.getFontHeight(Gfx.FONT_NUMBER_HOT))/2-Gfx.getFontHeight(Gfx.FONT_MEDIUM)-1;
		}
		return 0;
	}
	
	static function getDateY(){
		var dim = getDialDimensions();
		//If not enough space below dial
		if(dim.get(:sh)<Gfx.getFontHeight(Gfx.FONT_MEDIUM)){
			//Position below time text
			return (dim.get(:h)+Gfx.getFontHeight(Gfx.FONT_NUMBER_HOT))/2+1;
		}
		return dim.get(:h)-Gfx.getFontHeight(Gfx.FONT_MEDIUM);
	}
	
	static function getHourX(){
		var dim = DeviceConfigs.getDialDimensions();
		return 1*dim.get(:d)/4+dim.get(:sw);
	}
	
	static function getMinuteX(){
		var dim = DeviceConfigs.getDialDimensions();
		return 3*dim.get(:d)/4+dim.get(:sw);
	}
	
	static function getTime(){
		return Sys.getClockTime();
	}
	
	static function getDateTime(){
		return Time.Gregorian.info(Time.now(), Time.FORMAT_SHORT);
		//var clockTime = getTime();
        //return Time.Gregorian.utcInfo(Time.now().add(new Time.Duration(clockTime.timeZoneOffset)), Time.FORMAT_SHORT);
	}
}