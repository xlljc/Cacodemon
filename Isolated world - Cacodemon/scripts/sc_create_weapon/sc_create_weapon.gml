/// @arg x
/// @arg y
/// @arg weaponType
/// @arg depth
/// @arg rotation
/// @arg ximpulse
/// @arg yimpulse
/// @arg angular_v

//创建一个武器

var x0 = argument0;
var y0 = argument1;
var weaponType = argument2;
var depth_tmp = argument3;
var rotation = argument4;
var ximpulse = argument5;
var yimpulse = argument6;
var angular_v = argument7;

var ob_tmp = instance_create_depth(x0,y0,depth_tmp,sc_get_weaponObject(weaponType));

with(ob_tmp){
	phy_rotation = rotation;
	physics_apply_impulse(x,y,ximpulse,yimpulse);
	phy_angular_velocity = angular_v;
}

return ob_tmp;