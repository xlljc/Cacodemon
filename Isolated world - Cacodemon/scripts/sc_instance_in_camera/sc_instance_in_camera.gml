/// @arg inst
/// @arg margin_R_L
/// @arg margin_T_B


var inst = argument0;
var rl = argument1;
var tb = argument2;
//返回对象本身是否在指定视野内（可用于离开视野的物体禁用）

if(inst.x >= cameraX - rl && inst.x <= cameraX + cameraWidth + rl
&& inst.y >= cameraY - tb && inst.y <= cameraY + cameraHeight + tb){
	return 1;
}
return 0;