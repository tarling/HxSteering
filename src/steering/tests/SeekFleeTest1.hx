package steering.tests;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import steering.core.EEdgeBehavior;
import steering.core.SteeredVehicle;
import steering.core.Vector2D;

class SeekFleeTest1 extends Sprite
{
	private var _seeker:SteeredVehicle;
	private var _fleer:SteeredVehicle;
	
	public function new()
	{
		super();
		_seeker=new SteeredVehicle();
		_seeker.position=new Vector2D(200, 200);
		_seeker.edgeBehavior=EEdgeBehavior.BOUNCE;
		addChild(_seeker);
		
		_fleer=new SteeredVehicle();
		_fleer.position=new Vector2D(400, 300);
		_fleer.edgeBehavior=EEdgeBehavior.BOUNCE;
		addChild(_fleer);
		
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	private function onEnterFrame(event:Event):Void
	{
		_seeker.seek(_fleer.position);
		_fleer.flee(_seeker.position);
		_seeker.update();
		_fleer.update();
	}
}