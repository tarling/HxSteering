package steering.behaviors;
import steering.core.SteeredVehicle;
import steering.core.Vector2D;

/**
 * ...
 * @author 
 */
class AvoidBehavior implements IBehavior
{
	public var obstacles:Array<Circle>;
	
	var vehicle:SteeredVehicle;
	var avoidDistance:Float = 300;
 	var avoidBuffer:Float = 20;

	public function new(vehicle:SteeredVehicle) 
	{
		this.vehicle = vehicle;
		obstacles = [];
	}
	
	public function update():Void 
	{
		for(obstacle in obstacles)
		{
			var heading:Vector2D=vehicle.velocity.clone().normalize();
			
			// vector between circle and vehicle:
			var difference:Vector2D=obstacle.position.subtract(vehicle.position);
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
				if(dist<obstacle.radius + avoidBuffer &&
				   projection.length<feeler.length)
				{
					// calculate a force +/- 90 degrees from vector to circle
					var force:Vector2D=heading.multiply(vehicle.maxSpeed);
					force.angle +=difference.sign(vehicle.velocity)* Math.PI / 2;
					
					// scale this force by distance to circle.
					// the further away, the smaller the force
					force=force.multiply(1.0 - projection.length /
												 feeler.length);
					
					// add to steering force
					vehicle.steeringForce=vehicle.steeringForce.add(force);
					
					// braking force
					vehicle.velocity=vehicle.velocity.multiply(projection.length / feeler.length);
				}
			}
		}
	}
	
}