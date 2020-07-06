/// @param x1
/// @param y1
/// @param r
/// @param obj
/// @param hurt
/// @param hurtType
/// @param type
/// @param vibraX
/// @param vibraY

var x1 = argument0;
var y1 = argument1;
var r = argument2;
var hurtType = argument5; //伤害类型（0：单向伤害，1：从中间向两边发散）
var type = argument6; //格挡类型

//攻击函数，用户必须手动清理"attack_list_box"
//调用者必须拥有"attack_list_box"
//返回值为攻击到敌人的个数

var list = ds_list_create();
collision_circle_list(x1,y1,r,argument3,0,0,list,0);
var atk_num = sc_attack_perform(list,argument4,hurtType,type,argument7,argument8);
ds_list_destroy(list);

return atk_num;