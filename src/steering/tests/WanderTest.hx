package steering.tests;

import flash.display.Sprite;
import flash.events.Event;
import steering.behaviors.WanderBehavior;
import steering.core.EEdgeBehavior;
import steering.core.SteeredVehicle;
import steering.core.Vector2D;


class WanderTest extends Sprite
{
	private var _vehicle:SteeredVehicle;
	
	public function new()
	{
		super();
		_vehicle=new SteeredVehicle();
		_vehicle.position = new Vector2D(200, 200);
		_vehicle.edgeBehavior = EEdgeBehavior.WRAP;
		addChild(_vehicle);
		
		_vehicle.addBehavior(new WanderBehavior(_vehicle));
		
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	private function onEnterFrame(event:Event):Void
	{
		_vehicle.update();
	}
}