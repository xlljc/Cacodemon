/// @arg x1
/// @arg y1
/// @arg x2
/// @arg y2
/// @arg inst
/// @arg wall_obj

var x1 = argument0;
var y1 = argument1;
var x2 = argument2;
var y2 = argument3;
var inst = argument4;
var wall_obj = argument5;

//该脚本返回指定对象的实例是否在自己视野内，视野无法透过墙体
//该函数只比较x轴值
//返回值为方向
//0表示不在视野内

//如果不存在inst
if(!inst){
	return 0;
}

var list = ds_list_create();
var num = collision_rectangle_list(x1,y1,x2,y2,wall_obj,0,0,list,0);

//如果没碰到墙
if(!num){
	ds_list_destroy(list);
	return sc_instance_in_view(inst,id,0);
}

for (var i = 0; i < num; ++i) {
	var temp = list[| i];
    //墙必须在自己和inst之间
	if((inst.x < temp.x && temp.x < x) || (x < temp.x && temp.x < inst.x)){
		ds_list_destroy(list);
		return 0;
	}
}

ds_list_destroy(list);
return sc_instance_in_view(inst,id,0);