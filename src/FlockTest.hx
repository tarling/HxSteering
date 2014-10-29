package;

import com.foed.EEdgeBehavior;
import com.foed.FlockBehavior;
import com.foed.SteeredVehicle;
import com.foed.Vector2D;
import flash.events.Event;


class FlockTest extends InitedSprite
{
	private var _vehicles:Array<SteeredVehicle>;
	
	public function new()
	{
		super();
	}
	
	override function init():Void { 
		_vehicles=new Array();
		for(i in 0...30)
		{
			var vehicle:SteeredVehicle=new SteeredVehicle();
			vehicle.position=new Vector2D(Math.random()* stage.stageWidth, Math.random()* stage.stageHeight);
			vehicle.velocity=new Vector2D(Math.random()* 20 - 10, Math.random()* 20 - 10);
			vehicle.edgeBehavior=EEdgeBehavior.BOUNCE;
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