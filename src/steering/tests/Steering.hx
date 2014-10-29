package steering.tests;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.MouseEvent;
import flash.text.TextField;
import steering.core.Vector2D;

//[SWF(backgroundColor=0xffffff)]
class Steering extends Sprite
{
	private var sA:Sprite;
	private var sB:Sprite;
	private var sC:Sprite;
	private var tf:TextField;
	
	public function new()
	{
		super();
		sA=makeHandle(100, 100, "A");
		sB=makeHandle(200, 100, "B");
		sC=makeHandle(200, 200, "C");
		draw();
		
		tf=new TextField();
		tf.selectable=false;
		addChild(tf);
	}
	
	
	private function makeHandle(xpos:Float, ypos:Float, label:String):Sprite
	{
		var s:Sprite=new Sprite();
		s.graphics.beginFill(0x999999);
		s.graphics.drawCircle(0, 0, 10);
		s.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		s.x=xpos;
		s.y=ypos;
		var lab:TextField=new TextField();
		lab.selectable=false;
		lab.text=label;
		lab.x=-6;
		lab.y=-7;
		lab.width=12;
		lab.height=14;
		lab.mouseEnabled=false;
		s.addChild(lab);
		
		addChild(s);
		return s;
	}
	
	private function onMouseDown(event:MouseEvent):Void
	{
		event.target.startDrag();
		stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
	}
	
	private function onMouseUp(event:MouseEvent):Void
	{
		stopDrag();
		stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
	}
	
	private function onMouseMove(event:MouseEvent):Void
	{
		draw();
		calculate();
	}
	
	private function draw():Void
	{
		graphics.clear();
		graphics.lineStyle(0);
		graphics.moveTo(sB.x, sB.y);
		graphics.lineTo(sA.x, sA.y);
		graphics.lineTo(sC.x, sC.y);
	}
	
	private function calculate():Void
	{
		var v1:Vector2D=new Vector2D(sB.x - sA.x, sB.y - sA.y);
		var v2:Vector2D=new Vector2D(sC.x - sA.x, sC.y - sA.y);
		var degrees:Float=Vector2D.angleBetween(v1, v2)* 180 / Math.PI;
		tf.text=Std.string(degrees * v1.sign(v2));
	}
}