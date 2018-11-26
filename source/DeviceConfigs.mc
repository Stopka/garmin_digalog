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
			return dim.get(:sh)+(dim.get(:d)-Gfx.getFontHeight(Gfx.FONT_NUMBER_HOT))/2-0.5*Gfx.getFontHeight(Gfx.FONT_MEDIUM);
		}
		return Gfx.getFontHeight(Gfx.FONT_MEDIUM)/2;
	}
	
	static function getDateY(){
		var dim = getDialDimensions();
		return dim.get(:h)-getDayY();
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