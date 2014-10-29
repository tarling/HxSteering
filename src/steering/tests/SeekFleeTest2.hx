package steering.tests;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import steering.core.EEdgeBehavior;
import steering.core.SteeredVehicle;
import steering.core.Vector2D;

class SeekFleeTest2 extends Sprite
{
	private var _vehicleA:SteeredVehicle;
	private var _vehicleB:SteeredVehicle;
	private var _vehicleC:SteeredVehicle;
	
	public function new()
	{
		super();_vehicleA=new SteeredVehicle();
		_vehicleA.position=new Vector2D(200, 200);
		_vehicleA.edgeBehavior=EEdgeBehavior.BOUNCE;
		addChild(_vehicleA);
		
		_vehicleB=new SteeredVehicle();
		_vehicleB.position=new Vector2D(400, 200);
		_vehicleB.edgeBehavior=EEdgeBehavior.BOUNCE;
		addChild(_vehicleB);
		
		_vehicleC=new SteeredVehicle();
		_vehicleC.position=new Vector2D(300, 260);
		_vehicleC.edgeBehavior=EEdgeBehavior.BOUNCE;
		addChild(_vehicleC);
		
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	private function onEnterFrame(event:Event):Void
	{
		_vehicleA.seek(_vehicleB.position);
		_vehicleA.flee(_vehicleC.position);
		
		_vehicleB.seek(_vehicleC.position);
		_vehicleB.flee(_vehicleA.position);
		
		_vehicleC.seek(_vehicleA.position);
		_vehicleC.flee(_vehicleB.position);
		
		_vehicleA.update();
		_vehicleB.update();
		_vehicleC.update();
	}
}