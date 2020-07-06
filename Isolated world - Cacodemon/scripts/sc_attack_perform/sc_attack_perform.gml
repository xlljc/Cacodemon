/// @param instList
/// @param hurt
/// @param hurtType
/// @param type
/// @param vibraX
/// @param vibraY

var list = argument0;
var hurt = argument1;
var hurtType = argument2; //伤害类型（0：单向伤害，1：从中间向两边发散）
var type = argument3; //可以格挡的类型
var vibra_X = argument4;
var vibra_Y = argument5;

//攻击函数，用户必须手动清理"attack_list_box"
//调用者必须拥有"attack_list_box"
//返回值为攻击到敌人的个数

var sc;

var atk_num = 0;

var attack_list_box_len = ds_list_size(attack_list_box);
var num = ds_list_size(list);
for(var i = 0; i < num; i ++) {
	var temp = list[| i];
	if(attack_list_box_len == 0	//如果是此次攻击的第一次检测，那么无需判断attack_list_box是否有相同id
	|| ds_list_find_index(attack_list_box,temp) < 0){	//或者如果不在attack_list_box里面
		if(attack_list_box_len != 0){
			attack_list_box_len ++;
		}
		atk_num ++;
		ds_list_add(attack_list_box,temp);
		//伤害函数
		if(sc_isChild(temp.object_index,ob_biology_monster_f)){
			sc = sc_monster_lostHp;
		}else if(sc_isChild(temp.object_index,ob_biology_teammate_f)){
			sc = sc_teammate_lostHp;
		}
		//执行伤害
		if(hurtType == 0){
			script_execute(sc,temp,image_xscale ? hurt : -hurt,type);
		}else if(hurtType == 1){
			script_execute(sc,temp,temp.x > x ? hurt : -hurt,type);
		}
	}
}

if(num){
	if(vibra_X != 0 || vibra_Y != 0){
		sc_vibra_set_force(vibra_X,vibra_Y);
	}
}

return atk_num;