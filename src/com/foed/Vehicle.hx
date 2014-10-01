package com.foed;

import flash.display.Sprite;

/**
 * Base class for moving characters.
 */
class Vehicle extends Sprite
{
	//public var y(default, set_y):Float;
 	//public var x(default, set_x):Float;
 
	public var position(get_position, set_position):Vector2D;
 	public var edgeBehavior:EEdgeBehavior;
 	public var mass:Float=1.0;
	public var maxSpeed:Float=10;
	public var velocity:Vector2D;
	
	//private var _position:Vector2D;
	
	/**
	 * Constructor.
	 */
	public function new()
	{
		super();
		//_position=new Vector2D();
		velocity=new Vector2D();
		draw();
	}
	
	/**
	 * Default graphics for vehicle. Can be overridden in subclasses.
	 */
	private function draw():Void
	{
		graphics.clear();
		graphics.lineStyle(0);
		graphics.moveTo(10, 0);
		graphics.lineTo(-10, 5);
		graphics.lineTo(-10, -5);
		graphics.lineTo(10, 0);
	}
	
	/**
	 * Handles all basic motion. Should be called on each frame / timer Interval.
	 */
	public function update():Void
	{
		// make sure velocity stays within max speed.
		velocity.truncate(maxSpeed);
		
		// add velocity to position
		position=position.add(velocity);
		
		// handle any edge behavior
		if(edgeBehavior==EEdgeBehavior.WRAP)
		{
			wrap();
		}
		else if(edgeBehavior==EEdgeBehavior.BOUNCE)
		{
			bounce();
		}
		
		// update position of sprite
		//x=position.x;
		//y=position.y;
		
		// rotate heading to match velocity
		rotation=velocity.angle * 180 / Math.PI;
	}
	
	/**
	 * Causes character to bounce off edge if edge is hit.
	 */
	private function bounce():Void
	{
		if(stage !=null)
		{
			if(position.x>stage.stageWidth)
			{
				position.x=stage.stageWidth;
				velocity.x *=-1;
			}
			else if(position.x<0)
			{
				position.x=0;
				velocity.x *=-1;
			}
			
			if(position.y>stage.stageHeight)
			{
				position.y=stage.stageHeight;
				velocity.y *=-1;
			}
			else if(position.y<0)
			{
				position.y=0;
				velocity.y *=-1;
			}
		}
	}
	
	/**
	 * Causes character to wrap around to opposite edge if edge is hit.
	 */
	private function wrap():Void
	{
		if(stage !=null)
		{
			if(position.x>stage.stageWidth)position.x=0;
			if(position.x<0)position.x=stage.stageWidth;
			if(position.y>stage.stageHeight)position.y=0;
			if(position.y<0)position.y=stage.stageHeight;
		}
	}
	
	/**
	 * Sets / gets position of character as a Vector2D.
	 */
	private function set_position(value:Vector2D):Vector2D
	{
		//_position=value;
		x=value.x;
		y = value.y;
		return value;
	}
	private function get_position():Vector2D
	{
		return new Vector2D(x,y);
	}
	
	/**
	 * Sets x position of character. Overrides Sprite.x to set Internal Vector2D position as well.
	 */
	/*private function set_x(value:Float):Float
	{
		super.x=value;
		position.x = x;
		return value;
	}*/
	
	/**
	 * Sets y position of character. Overrides Sprite.y to set Internal Vector2D position as well.
	 */
	/*private function set_y(value:Float):Float
	{
		super.y=value;
		_position.y = y;
		return value;
	}*/
	
}