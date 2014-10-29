package com.foed;

/**
 * ...
 * @author 
 */
class WanderBehavior implements IBehavior
{
	var vehicle:SteeredVehicle;
	
	var angle:Float = 0;
 	var distance:Float = 10;
 	var radius:Float = 5;
 	var range:Float = 1;
 	
 	
	public function new(vehicle:SteeredVehicle) 
	{
		this.vehicle = vehicle;
	}
	
	public function update():Void 
	{
		var center:Vector2D=vehicle.velocity.clone().normalize().multiply(distance);
		var offset:Vector2D=new Vector2D(0);
		offset.length=radius;
		offset.angle=angle;
		angle +=Math.random()* range - range * .5;
		var force:Vector2D=center.add(offset);
		vehicle.steeringForce=vehicle.steeringForce.add(force);
	}
	
}