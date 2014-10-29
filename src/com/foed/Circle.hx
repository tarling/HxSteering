package com.foed;

import flash.display.Sprite;

class Circle extends Sprite
{
	public var radius(default, null):Float;
 	public var position(get_position, null):Vector2D;
 	
	private var _color:Int;
	
	public function new(radius:Float, color:Int=0x000000)
	{
		super();
		this.radius=radius;
		//graphics.lineStyle(0, color);
		graphics.beginFill(color);
		graphics.drawCircle(0, 0, radius);
		graphics.endFill();
	}
	
	private function get_position():Vector2D
	{
		return new Vector2D(x, y);
	}
}