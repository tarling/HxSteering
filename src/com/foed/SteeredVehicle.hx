package com.foed;

import flash.display.Sprite;

class SteeredVehicle extends Vehicle
{
	private var steeringForce:Vector2D;
	
	public var maxForce:Float = 1;
 	public var arriveThreshold:Float = 100;
 	public var wanderAngle:Float = 0;
 	public var wanderDistance:Float = 10;
 	public var wanderRadius:Float = 5;
 	public var wanderRange:Float = 1;
 	public var pathIndex:Int = 0;
 	public var pathThreshold:Float = 20;
 	public var avoidDistance:Float = 300;
 	public var avoidBuffer:Float = 20;
 	public var inSightDist:Float = 200;
 	public var tooCloseDist:Float = 60;
	
	public function new()
	{
		steeringForce=new Vector2D();
		super();
	}
	
	
	override public function update():Void
	{
		steeringForce.truncate(maxForce);
		steeringForce=steeringForce.divide(mass);
		velocity=velocity.add(steeringForce);
		steeringForce=new Vector2D();
		super.update();
	}
	
	public function seek(target:Vector2D):Void
	{
		var desiredVelocity:Vector2D = target.subtract(position);
		desiredVelocity.normalize();
		desiredVelocity=desiredVelocity.multiply(maxSpeed);
		var force:Vector2D=desiredVelocity.subtract(velocity);
		steeringForce = steeringForce.add(force);
	}
	
	public function flee(target:Vector2D):Void
	{
		var desiredVelocity:Vector2D=target.subtract(position);
		desiredVelocity.normalize();
		desiredVelocity=desiredVelocity.multiply(maxSpeed);
		var force:Vector2D=desiredVelocity.subtract(velocity);
		steeringForce=steeringForce.subtract(force);
	}
	
	public function arrive(target:Vector2D):Void
	{
		var desiredVelocity:Vector2D=target.subtract(position);
		desiredVelocity.normalize();
		
		var dist:Float=position.dist(target);
		if(dist>arriveThreshold)
		{
			desiredVelocity=desiredVelocity.multiply(maxSpeed);
		}
		else
		{
			desiredVelocity=desiredVelocity.multiply(maxSpeed * dist / arriveThreshold);
		}
		
		var force:Vector2D=desiredVelocity.subtract(velocity);
		steeringForce=steeringForce.add(force);
	}
	
	public function pursue(target:Vehicle):Void
	{
		var lookAheadTime:Float=position.dist(target.position)/ maxSpeed;
		var predictedTarget:Vector2D=target.position.add(target.velocity.multiply(lookAheadTime));
		seek(predictedTarget);
	}
	
	public function evade(target:Vehicle):Void
	{
		var lookAheadTime:Float=position.dist(target.position)/ maxSpeed;
		var predictedTarget:Vector2D=target.position.subtract(target.velocity.multiply(lookAheadTime));
		flee(predictedTarget);
	}
	
	public function wander():Void
	{
		var center:Vector2D=velocity.clone().normalize().multiply(wanderDistance);
		var offset:Vector2D=new Vector2D(0);
		offset.length=wanderRadius;
		offset.angle=wanderAngle;
		wanderAngle +=Math.random()* wanderRange - wanderRange * .5;
		var force:Vector2D=center.add(offset);
		steeringForce=steeringForce.add(force);
	}
	
	public function avoid(circles:Array<Circle>):Void
	{
		for(i in 0...circles.length)
		{
			var circle:Circle=circles[i];
			var heading:Vector2D=velocity.clone().normalize();
			
			// vector between circle and vehicle:
			var difference:Vector2D=circle.position.subtract(position);
			var dotProd:Float=difference.dotProd(heading);
			
			// if circle is in front of vehicle...
			if(dotProd>0)
			{
				// vector to represent "feeler" arm
				var feeler:Vector2D=heading.multiply(avoidDistance);
				// project difference vector onto feeler
				var projection:Vector2D=heading.multiply(dotProd);
				// distance from circle to feeler
				var dist:Float=projection.subtract(difference).length;
				
				// if feeler Intersects circle(plus buffer),
				//and projection is less than feeler length,
				// we will collide, so need to steer
				if(dist<circle.radius + avoidBuffer &&
				   projection.length<feeler.length)
				{
					// calculate a force +/- 90 degrees from vector to circle
					var force:Vector2D=heading.multiply(maxSpeed);
					force.angle +=difference.sign(velocity)* Math.PI / 2;
					
					// scale this force by distance to circle.
					// the further away, the smaller the force
					force=force.multiply(1.0 - projection.length /
												 feeler.length);
					
					// add to steering force
					steeringForce=steeringForce.add(force);
					
					// braking force
					velocity=velocity.multiply(projection.length / feeler.length);
				}
			}
		}
	}
	
	public function followPath(path:Array<Vector2D>, loop:Bool=false):Void
	{
		var wayPoint:Vector2D=path[pathIndex];
		if(wayPoint==null)return;
		if(position.dist(wayPoint)<pathThreshold)
		{
			if(pathIndex>=path.length - 1)
			{
				if(loop)
				{
					pathIndex=0;
				}
			}
			else
			{
				pathIndex++;
			}
		}
		if(pathIndex>=path.length - 1 && !loop)
		{
			arrive(wayPoint);
		}
		else
		{
			seek(wayPoint);
		}
	}
	
	public function flock(vehicles:Array<Vehicle>):Void
	{
		var averageVelocity:Vector2D=velocity.clone();
		var averagePosition:Vector2D=new Vector2D();
		var inSightCount:Int=0;
		for(i in 0...vehicles.length)
		{
			var vehicle:Vehicle=vehicles[i];
			if(vehicle !=this && inSight(vehicle))
			{
				averageVelocity=averageVelocity.add(vehicle.velocity);
				averagePosition=averagePosition.add(vehicle.position);
				if(tooClose(vehicle))flee(vehicle.position);
				inSightCount++;
			}
		}
		if(inSightCount>0)
		{
			averageVelocity=averageVelocity.divide(inSightCount);
			averagePosition=averagePosition.divide(inSightCount);
			seek(averagePosition);
			steeringForce.add(averageVelocity.subtract(velocity));
		}
	}
	
	public function inSight(vehicle:Vehicle):Bool		
	{
		if(position.dist(vehicle.position)>inSightDist)return false;
		var heading:Vector2D=velocity.clone().normalize();
		var difference:Vector2D=vehicle.position.subtract(position);
		var dotProd:Float=difference.dotProd(heading);
		
		if(dotProd<0)return false;
		return true;
	}
	
	public function tooClose(vehicle:Vehicle):Bool
	{
		return position.dist(vehicle.position)<tooCloseDist;
	}
}