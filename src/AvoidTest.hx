package;

import com.foed.Circle;
import com.foed.EEdgeBehavior;
import com.foed.SteeredVehicle;
import com.foed.Vehicle;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;


class AvoidTest extends InitedSprite
{
	private var _vehicle:SteeredVehicle;
	private var _circles:Array<Circle>;
	private var _numCircles:Int=10;
	
	public function new()
	{
		super();
		
	}
	
	override function init():Void {
		
		_vehicle=new SteeredVehicle();
		_vehicle.edgeBehavior=EEdgeBehavior.BOUNCE;
		addChild(_vehicle);
		
		_circles=new Array();
		for(i in 0..._numCircles)
		{
			var circle:Circle=new Circle(Math.random()* 50 + 50);
			circle.x=Math.random()* stage.stageWidth;
			circle.y=Math.random()* stage.stageHeight;
			addChild(circle);
			_circles.push(circle);
		}
		
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
		
	}
	
	private function onEnterFrame(event:Event):Void
	{
		_vehicle.wander();
		_vehicle.avoid(_circles);
		_vehicle.update();
	}
}