package;

import com.foed.SteeredVehicle;
import com.foed.Vector2D;
import flash.events.Event;
import flash.events.MouseEvent;


class PathTest extends InitedSprite
{
	private var _vehicle:SteeredVehicle;
	private var _path:Array<Vector2D>;
	
	public function new()
	{
		super();
	}
	
	override function init():Void { 
		_vehicle=new SteeredVehicle();
		addChild(_vehicle);
		
		_path=new Array();
		
		stage.addEventListener(MouseEvent.CLICK, onClick);
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	private function onEnterFrame(event:Event):Void
	{
		_vehicle.followPath(_path, true);
		_vehicle.update();
	}
	
	private function onClick(event:MouseEvent):Void
	{
		graphics.lineStyle(0, 0, .25);
		if(_path.length==0)
		{
			graphics.moveTo(mouseX, mouseY);
		}
		graphics.lineTo(mouseX, mouseY);
		
		graphics.drawCircle(mouseX, mouseY, 10);
		graphics.moveTo(mouseX, mouseY);
		_path.push(new Vector2D(mouseX, mouseY));
	}
}