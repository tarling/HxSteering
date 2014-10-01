package;

import com.foed.EEdgeBehavior;
import com.foed.SteeredVehicle;
import com.foed.Vector2D;
import com.foed.Vehicle;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;

class PursueEvadeTest extends InitedSprite
{
	private var _pursuer:SteeredVehicle;
	private var _evader:SteeredVehicle;
	
	public function new()
	{
		super();
		
		
	}
	
	override function init():Void { 
		_pursuer=new SteeredVehicle();
		_pursuer.position=new Vector2D(200, 200);
		_pursuer.edgeBehavior=EEdgeBehavior.BOUNCE;
		addChild(_pursuer);
		
		_evader=new SteeredVehicle();
		_evader.position=new Vector2D(400, 300);
		_evader.edgeBehavior=EEdgeBehavior.BOUNCE;
		addChild(_evader);
		
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	private function onEnterFrame(event:Event):Void
	{
		_pursuer.pursue(_evader);
		_evader.evade(_pursuer);
		_pursuer.update();
		_evader.update();
	}
}