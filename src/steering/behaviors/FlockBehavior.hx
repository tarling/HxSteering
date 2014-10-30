package steering.behaviors;
import steering.core.SteeredVehicle;
import steering.core.Vector2D;
import steering.core.Vehicle;

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
		for(other in vehicles)
		{
			if (other != vehicle)
			{
				var pos:Vector2D = other.position;
				if (vehicle.inSight(pos))
				{
					averageVelocity=averageVelocity.add(other.velocity);
					averagePosition=averagePosition.add(pos);
					if(vehicle.tooClose(pos))vehicle.flee(pos);
					inSightCount++;
				}
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