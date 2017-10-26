using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class CenterDrawable extends HidableDrawable {

	function initialize(params){
		HidableDrawable.initialize(params,buildDrawable());
	}

	function buildDrawable() {
    	return new Rez.Drawables.Center();
    }

}