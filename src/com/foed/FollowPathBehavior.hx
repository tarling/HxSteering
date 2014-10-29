package com.foed;

/**
 * ...
 * @author 
 */
class FollowPathBehavior implements IBehavior
{
	public var path:Array<Vector2D>;
	public var loop:Bool = false;
	public var pathThreshold:Float = 20;
 	
	var vehicle:SteeredVehicle;
	var pathIndex:Int = 0;
 	
	public function new(vehicle:SteeredVehicle) 
	{
		this.vehicle = vehicle;
		path = [];
	}
	
	public function update():Void 
	{
		var wayPoint:Vector2D=path[pathIndex];
		if(wayPoint==null)return;
		if(vehicle.position.dist(wayPoint)<pathThreshold)
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
			vehicle.arrive(wayPoint);
		}
		else
		{
			vehicle.seek(wayPoint);
		}
	}
	
}