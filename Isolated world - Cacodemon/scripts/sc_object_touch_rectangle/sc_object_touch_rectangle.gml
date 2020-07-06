/// @arg x1
/// @arg y1
/// @arg x2
/// @arg y2
/// @arg list
/// @arg type

//范围
var x1 = argument0;
var y1 = argument1;
var x2 = argument2;
var y2 = argument3;
//集合
var list = argument4;
//触发的类型
var type = argument5;

//攻击时物体交互
//检查矩形范围

//装饰品交互
var instList = ds_list_create();
collision_rectangle_list(x1,y1,x2,y2,ob_physics_collision_group2,0,0,instList,0);
sc_decora_touch(instList,list);
ds_list_destroy(instList);