using Toybox.Math as Math;

class ShapeHelper{

	static function drawCircle(dc, point, radius, infillColor, lineColor, lineWidth){
		dc.setColor(infillColor,0);
		dc.fillEllipse(point[0], point[1], radius, radius);
		dc.setColor(lineColor,0);
		dc.setPenWidth(lineWidth);
		dc.drawEllipse(point[0], point[1], radius, radius);
	}

	static function drawPolygon(dc, points, infillColor, lineColor, lineWidth){
		dc.setColor(infillColor,0);
		dc.fillPolygon(points);
		dc.setColor(lineColor,0);
		dc.setPenWidth(lineWidth);
		drawPolygonBorder(dc, points);
	}
	
	static function drawPolygonBorder(dc, points){
		var pointA;
		var pointB = points[points.size()-1];
		for(var i=0;i<points.size();i++){
			pointA=pointB;
			pointB=points[i];
			dc.drawLine(pointA[0],pointA[1],pointB[0],pointB[1]);
		}
	}
	
	static function getPolygonRotated(polygon,center,rotation){
		var result = new [polygon.size()];
		for (var i = 0; i < polygon.size(); i += 1) {
		    result[i] = getPointRotated(polygon[i],center,rotation);
		}
		return result;
	}
	
	static function getPointRotated(point,center,rotation){
		return [
			Math.cos(rotation)*(point[0]-center[0])-Math.sin(rotation)*(point[1]-center[1])+center[0],
			Math.sin(rotation)*(point[0]-center[0])+Math.cos(rotation)*(point[1]-center[1])+center[1]
		];
	}
}