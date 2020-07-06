/// @arg inst
/// @arg self
/// @arg wall_inst

var instX = argument0;
var selfX = argument1;
var wall_instX = argument2;

//该脚本返回实例是否在自己视野内，视野无法透过墙体
//该函数只比较x轴值
//返回值为方向

if(!instX || !selfX){
	return 0;
}

instX = instX.x;
selfX = selfX.x;

if(!wall_instX){
	if(instX >= selfX){
		return argument1.image_xscale ? 1 : -1;
	}else {
		return argument1.image_xscale ? -1 : 1;
	}
}

wall_instX = wall_instX.x;

if(instX >= selfX && (wall_instX > instX || wall_instX < selfX)){
	return argument1.image_xscale ? 1 : -1;
}else if(instX <= selfX && (wall_instX < instX || wall_instX > selfX)){
	return argument1.image_xscale ? -1 : 1;
}else {
	return 0;
}