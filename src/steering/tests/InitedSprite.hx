package steering.tests;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
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
		if(stage != null) setupStage();
		else addEventListener(Event.ADDED_TO_STAGE, stageReady);
	}
	
	function setupStage() 
	{
		stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		init();
	}
	
	private function stageReady(e:Event=null):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, stageReady);
		setupStage();
	}
	
	private function init():Void {
		
	}
	
	
	
}