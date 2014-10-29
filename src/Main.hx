package;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import steering.tests.ArriveTest;
import steering.tests.AvoidTest;
import steering.tests.FleeTest;
import steering.tests.FlockTest;
import steering.tests.PathTest;
import steering.tests.PursueEvadeTest;
import steering.tests.PursueTest;
import steering.tests.SeekFleeTest1;
import steering.tests.SeekFleeTest2;
import steering.tests.SeekTest;
import steering.tests.Steering;
import steering.tests.Steering2;
import steering.tests.VehicleTest;
import steering.tests.WanderTest;

/**
 * ...
 * @author 
 */
class Main extends Sprite 
{
	//
	public function new():Void 
	{
		super();
	}
	
	static function main():Void {
		
		//Lib.current.addChild(new ArriveTest());
		//Lib.current.addChild(new AvoidTest());
		//Lib.current.addChild(new FleeTest());
		Lib.current.addChild(new FlockTest());
		//Lib.current.addChild(new PathTest());
		//Lib.current.addChild(new PursueEvadeTest());
		//Lib.current.addChild(new PursueTest());
		//Lib.current.addChild(new SeekFleeTest1());
		//Lib.current.addChild(new SeekFleeTest2());
		//Lib.current.addChild(new SeekTest());
		//Lib.current.addChild(new Steering());
		//Lib.current.addChild(new Steering2());
		//Lib.current.addChild(new VehicleTest());
		//Lib.current.addChild(new WanderTest());
	}
	
}