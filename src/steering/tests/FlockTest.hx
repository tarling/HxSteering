package steering.tests;

import flash.events.Event;
import steering.behaviors.FlockBehavior;
import steering.core.EEdgeBehavior;
import steering.core.SteeredVehicle;
import steering.core.Vector2D;


class FlockTest extends InitedSprite
{
	private var _vehicles:Array<SteeredVehicle>;
	
	public function new()
	{
		super();
	}
	
	override function init():Void { 
		_vehicles=new Array();
		for(i in 0...100)
		{
			var vehicle:SteeredVehicle=new SteeredVehicle();
			vehicle.position=new Vector2D(Math.random()* stage.stageWidth, Math.random()* stage.stageHeight);
			vehicle.velocity=new Vector2D(Math.random()* 20 - 10, Math.random()* 20 - 10);
			vehicle.edgeBehavior = EEdgeBehavior.BOUNCE;
			vehicle.inSightDist = 200;
			addChild(vehicle);
			
			_vehicles.push(vehicle);
		}
		
		for(vehicle in _vehicles)
		{
			var flock:FlockBehavior = new FlockBehavior(vehicle);
			flock.vehicles = cast(_vehicles);
			vehicle.addBehavior(flock);
		}
		
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	private function onEnterFrame(event:Event):Void
	{
		for(vehicle in _vehicles)
		{
			vehicle.update();
		}
	}
}