package steering.tests;

import flash.display.Sprite;
import flash.events.Event;

/**
 * ...
 * @author 
 */
class InitedSprite extends Sprite
{

	public function new() 
	{
		super();
		if(stage != null)init();
		else addEventListener(Event.ADDED_TO_STAGE, stageReady);
	}
	
	private function stageReady(e:Event=null):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, stageReady);
		init();
	}
	
	private function init():Void {
		
	}
	
	
	
}