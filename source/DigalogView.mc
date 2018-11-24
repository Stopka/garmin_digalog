using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Application as App;
using Toybox.Time as Time;
using Toybox.System as Sys;

class DigalogView extends Ui.WatchFace {
	
	var buffer = null;
	var isSleeping = false;
	var isPartialOff = true;
	var showSeconds = 2;
	
	function initialize(){
		Ui.WatchFace.initialize();
	}

	// The entry point for the View is onLayout(). This is called before the
    // View is shown to load resources and set up the layout of the View.
    // @param [Graphics.Dc] dc The drawing context
    // @return [Boolean] true if handled, false otherwise
    function onLayout( dc ){
    	setLayout(Rez.Layouts.WatchFace( dc ));
    	if (Gfx has :BufferedBitmap) {              // check to see if device has BufferedBitmap enabled
	        buffer = new Gfx.BufferedBitmap({
	        	:width=>dc.getWidth(),
	            :height=>dc.getHeight()
			});
		}
    }
    
    function getBufferDc(dc){
    	if(buffer){
    		return buffer.getDc();
    	}
    	return dc;
    }
    
    function drawBuffer(dc){
    	if(buffer){
    		dc.drawBitmap(0, 0, buffer);
    	}
    }

    // When the View is brought into the foreground, onShow() is called.
    // @return [Boolean] true if handled, false otherwise
    function onShow(){
    	Ui.WatchFace.onShow();
    	loadSettings();
    }
    
    function loadSettings(){
    	var drawable;
    	drawable = View.findDrawableById("TimeDay");
        drawable.setColor(SettingGroups.getSetColor("ColorDay"));
        drawable = View.findDrawableById("TimeDate");
        drawable.setColor(SettingGroups.getSetColor("ColorDate"));
        drawable = View.findDrawableById("TimeHours");
        drawable.setColor(SettingGroups.getSetColor("ColorHour"));
        drawable = View.findDrawableById("TimeMinutes");
        drawable.setColor(SettingGroups.getSetColor("ColorMinute"));
        drawable = View.findDrawableById("TimeSeconds");
        drawable.setColor(SettingGroups.getSetColor("ColorSecond"));
        showSeconds = App.getApp().getProperty("ShowSeconds");
    }

    // When a View is active, onUpdate() is used to update dynamic content.
    // This function is called when the View is brought to the foreground.
    // For widgets and watch-apps it is also called when WatchUi.requestUpdate()
    // is called. For watchfaces it is called once a minute and for datafields
    // it is called once a second. If a class that extends View does not
    // implement this function then any Drawables contained in the View will
    // automatically be drawn.
    // @param [Graphics.Dc] dc The drawing context
    // @return [Boolean] true if handled, false otherwise
    function onUpdate( dc ){
    	dc.clearClip();
    	var bufferDc = getBufferDc(dc);
    	DialDrawable.draw(bufferDc);
    	var dateTime = DeviceConfigs.getDateTime();
    	var drawable;
    	drawable = View.findDrawableById("TimeDay");
        drawable.setText(SettingGroups.getWeekDay(dateTime.day_of_week));
        drawable.draw(bufferDc);
        drawable = View.findDrawableById("TimeDate");
        var dateFormat = SettingGroups.getSetDateFormat();
        var dateString = Lang.format(dateFormat, [
        		dateTime.day.format("%02d"), 
        		dateTime.month.format("%02d"),
        		dateTime.year.format("%04d"),
        	]);
        drawable.setText(dateString);
        drawable.draw(bufferDc);
    	drawable = View.findDrawableById("TimeHours");
    	var hour = dateTime.hour;
    	if(!Sys.getDeviceSettings().is24Hour){
    		hour = hour%12;
    	}
        drawable.setText(hour.format("%02d"));
        drawable.draw(bufferDc);
        drawable = View.findDrawableById("TimeMinutes");
        drawable.setText(dateTime.min.format("%02d"));
        drawable.draw(bufferDc);
        IconTopDrawable.draw(bufferDc);
        IconBottomDrawable.draw(bufferDc);
        ArrowDrawable.draw(bufferDc,dateTime.hour,dateTime.min);
    	drawBuffer(dc);
    	if(
    		(showSeconds == 0) ||
    		(showSeconds == 1 && isSleeping) ||
    		(showSeconds == 2 && isPartialOff && isSleeping) 
    	){
	    	drawCenter(dc);
        }else{
        	drawSeconds(dc, dateTime.sec);
        }
        isPartialOff=true;
    }
    
    function drawCenter(dc){
    	var r = DeviceConfigs.getDialDimensions().get(:d)/24;
    	dc.setColor(SettingGroups.getSetColor("ColorDial"),0);
		dc.fillEllipse(dc.getWidth()/2,dc.getHeight()/2,r,r);
    }
    
    function setCenterClip(dc){
    	var d = DeviceConfigs.getDialDimensions().get(:d);
    	dc.setClip((dc.getWidth()-d/5)/2,(dc.getHeight()-d/5)/2,d/5,d/5);
    }
    
    function drawSeconds(dc, sec){
    	SecondDrawable.setClip(dc);
    	drawBuffer(dc);
    	SecondDrawable.draw(dc, sec);
    	setCenterClip(dc);
    	drawBuffer(dc);
    	var drawable = View.findDrawableById("TimeSeconds");
        drawable.setText(sec.format("%02d"));
        drawable.draw(dc);
    }
    
    function onPartialUpdate(dc){
    	isPartialOff = false;
    	if(showSeconds!=2){
    		return;
    	}
    	var time = DeviceConfigs.getTime();
    	drawSeconds(dc, time.sec);
    }
    
    function onPowerBudgetExceeded(powerInfo){
    	System.println("onPowerBudgetExceeded");
    	isPartialOff = true;
    	Sys.println(powerInfo);
    }
    
    function onEnterSleep(){
    	System.println("onEnterSleep");
    	isSleeping = true;
    }
    
    function onExitSleep(){
    	System.println("onExitSleep");
    	isSleeping = false;
    }

}
