package;

import com.foed.SteeredVehicle;
import com.foed.Vector2D;
import com.foed.WanderBehavior;
import flash.display.Sprite;
import flash.events.Event;


class Steering2 extends Sprite
{
	private var _small:SteeredVehicle;
	private var _medium:SteeredVehicle;
	private var _large:SteeredVehicle;
	
	
	public function new()
	{
		super();
		_small=new SteeredVehicle();
		_small.scaleX=_small.scaleY=.5;
//			_small.mass=.5;
		_small.position=new Vector2D(300, 400);
		addChild(_small);
		
		_small.addBehavior(new WanderBehavior(_small));
		
		_medium=new SteeredVehicle();
		_medium.position=new Vector2D(100, 100);
		addChild(_medium);
		
//			_large=new SteeredVehicle();
//			_large.scaleX=_large.scaleY=1.5;
//			_large.mass=2;
//			_large.position=new Vector2D(600, 140);
//			addChild(_large);
		
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	private function onEnterFrame(event:Event):Void
	{
		_medium.seek(_small.position);
		_small.update();
		_medium.update();
//			_large.update();
	}
	
}