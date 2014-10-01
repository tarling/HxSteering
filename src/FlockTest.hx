package;

import com.foed.EEdgeBehavior;
import com.foed.SteeredVehicle;
import com.foed.Vector2D;
import flash.events.Event;


class FlockTest extends InitedSprite
{
	private var _vehicles:Array<Dynamic>;
	private var _numVehicles:Int=30;
	
	public function new()
	{
		super();
	}
	
	override function init():Void { 
		_vehicles=new Array();
		for(i in 0..._numVehicles)
		{
			var vehicle:SteeredVehicle=new SteeredVehicle();
			vehicle.position=new Vector2D(Math.random()* stage.stageWidth, Math.random()* stage.stageHeight);
			vehicle.velocity=new Vector2D(Math.random()* 20 - 10, Math.random()* 20 - 10);
			vehicle.edgeBehavior=EEdgeBehavior.BOUNCE;
			_vehicles.push(vehicle);
			addChild(vehicle);
		}
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
		
		
	}
	
	private function onEnterFrame(event:Event):Void
	{
		for(i in 0..._numVehicles)
		{
			_vehicles[i].flock(_vehicles);
			_vehicles[i].update();
		}
	}
}