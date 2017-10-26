using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class DigalogApp extends App.AppBase {

    function initialize() {
        AppBase.initialize();
        /*
        System.print("Screen: " );
        switch(System.getDeviceSettings().screenShape){
        	case System.SCREEN_SHAPE_RECTANGLE:
        		System.print("rectangle "); break;
        	case System.SCREEN_SHAPE_ROUND:
        		System.print("round "); break;
        	case System.SCREEN_SHAPE_SEMI_ROUND:
        		System.print("semiround "); break;
        	default:
        		System.print("unknown "); break;
        }
        System.print(System.getDeviceSettings().screenWidth);
        System.print("x");
        System.println(System.getDeviceSettings().screenHeight);        
        System.print("Color:" );
        System.print(" blue " );
        System.print(Gfx.COLOR_BLUE.format("%06X"));
        System.print(" red " );
        System.print(Gfx.COLOR_RED.format("%06X"));
        System.println("");
        /**/
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new DigalogView() ];
    }

    // New app settings have been received so trigger a UI update
    function onSettingsChanged() {
        Ui.requestUpdate();
    }

}