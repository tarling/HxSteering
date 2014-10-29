package steering.tests;

import flash.display.Sprite;
import flash.events.Event;
import steering.core.SteeredVehicle;
import steering.core.Vector2D;

class ArriveTest extends Sprite
{
	private var _vehicle:SteeredVehicle;
	
	public function new()
	{
		super();_vehicle=new SteeredVehicle();
		addChild(_vehicle);
		
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	private function onEnterFrame(event:Event):Void
	{
		_vehicle.arrive(new Vector2D(mouseX, mouseY));
		_vehicle.update();
	}
}