package com.foed;

/**
 * ...
 * @author 
 */
class FlockBehavior implements IBehavior
{
	public var vehicles:Array<Vehicle>;
	
	var vehicle:SteeredVehicle;

	public function new(vehicle:SteeredVehicle) 
	{
		this.vehicle = vehicle;
		vehicles = [];
	}
	
	public function update():Void 
	{
		var averageVelocity:Vector2D=vehicle.velocity.clone();
		var averagePosition:Vector2D=new Vector2D();
		var inSightCount:Int=0;
		for(i in 0...vehicles.length)
		{
			var other:Vehicle=vehicles[i];
			if(other !=vehicle && vehicle.inSight(other))
			{
				averageVelocity=averageVelocity.add(other.velocity);
				averagePosition=averagePosition.add(other.position);
				if(vehicle.tooClose(other))vehicle.flee(other.position);
				inSightCount++;
			}
		}
		if(inSightCount>0)
		{
			averageVelocity=averageVelocity.divide(inSightCount);
			averagePosition=averagePosition.divide(inSightCount);
			vehicle.seek(averagePosition);
			vehicle.steeringForce.add(averageVelocity.subtract(vehicle.velocity));
		}
	}
	
}