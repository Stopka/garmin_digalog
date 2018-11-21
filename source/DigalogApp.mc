using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class DigalogApp extends App.AppBase {
	var view;
    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    	SettingGroups.checkSettings();
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
    	view = new DigalogView();
        return [view];
    }

    // New app settings have been received so trigger a UI update
    function onSettingsChanged() {
    	view.loadSettings();
        Ui.requestUpdate();
    }

}