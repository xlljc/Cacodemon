/// @arg x1
/// @arg y1
/// @arg r
/// @arg list
/// @arg type

//范围
var x1 = argument0;
var y1 = argument1;
var r = argument2;
//集合
var list = argument3;
//触发的类型
var type = argument4;

//攻击时物体交互
//检查圆形范围

//装饰品交互
var instList = ds_list_create();
collision_circle_list(x1,y1,r,ob_physics_collision_group2,0,0,instList,0);
sc_decora_touch(instList,list);
ds_list_destroy(instList);