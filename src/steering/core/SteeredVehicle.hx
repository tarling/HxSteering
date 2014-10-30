package steering.core;

import steering.behaviors.IBehavior;

class SteeredVehicle extends Vehicle
{
	public var steeringForce:Vector2D;
	
	public var maxForce:Float = 1;
 	public var arriveThreshold:Float = 100;
 	public var inSightDist:Float = 200;
 	public var tooCloseDist:Float = 60;
	
	var behaviors:Array<IBehavior>;
	
	public function new()
	{
		steeringForce = new Vector2D();
		behaviors = [];
		super();
	}
	
	public function addBehavior(behavior:IBehavior):Void {
		behaviors.push(behavior);
	}
	
	override public function update():Void
	{
		for (behavior in behaviors)
		{
			behavior.update();
		}
		
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
	
	public function inSight(other:Vector2D):Bool		
	{
		if(position.dist(other)>inSightDist)return false;
		var heading:Vector2D=velocity.clone().normalize();
		var difference:Vector2D=other.subtract(position);
		var dotProd:Float=difference.dotProd(heading);
		
		if(dotProd<0)return false;
		return true;
	}
	
	public function tooClose(other:Vector2D):Bool
	{
		return position.dist(other)<tooCloseDist;
	}
}