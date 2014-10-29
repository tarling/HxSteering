package steering.tests;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import steering.core.Vector2D;
import steering.core.Vehicle;

class VehicleTest extends Sprite
{
	private var _vehicle:Vehicle;
	
	public function new()
	{
		super();_vehicle=new Vehicle();
		addChild(_vehicle);
		
		_vehicle.position=new Vector2D(100, 100);
		
		_vehicle.velocity.length=5;
		_vehicle.velocity.angle=Math.PI / 4;
		
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	private function onEnterFrame(event:Event):Void
	{
		_vehicle.update();
	}
}