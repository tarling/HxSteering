package steering.tests;

import flash.events.Event;
import steering.behaviors.AvoidBehavior;
import steering.behaviors.WanderBehavior;
import steering.Circle;
import steering.core.EEdgeBehavior;
import steering.core.SteeredVehicle;


class AvoidTest extends InitedSprite
{
	private var _vehicle:SteeredVehicle;
	
	public function new()
	{
		super();
		
	}
	
	override function init():Void {
		
		var obstacles:Array<Circle>=new Array();
		for(i in 0...10)
		{
			var circle:Circle=new Circle(Math.random()* 50 + 50);
			circle.x=Math.random()* stage.stageWidth;
			circle.y=Math.random()* stage.stageHeight;
			addChild(circle);
			obstacles.push(circle);
		};
		
		_vehicle=new SteeredVehicle();
		_vehicle.edgeBehavior=EEdgeBehavior.BOUNCE;
		addChild(_vehicle);
		
		_vehicle.addBehavior(new WanderBehavior(_vehicle));
		
		var avoid:AvoidBehavior = new AvoidBehavior(_vehicle);
		avoid.obstacles = obstacles;
		_vehicle.addBehavior(avoid);
		
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
		
	}
	
	private function onEnterFrame(event:Event):Void
	{
		_vehicle.update();
	}
}