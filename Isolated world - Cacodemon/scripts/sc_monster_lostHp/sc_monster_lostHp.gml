/// @arg inst
/// @arg value

// monster受到伤害时调用此函数
// 正负号表伤害的方向

var inst = argument0;
var value = argument1;


with(inst){
	if(presentHp <= 0){
		exit;
	}
	if(((st != monsterSt.defense) 
	|| (value > 0 && image_xscale > 0) 
	|| (value < 0 && image_xscale < 0)) && st != monsterSt.roll){
		presentHp -= abs(value);
		if(presentHp < 0){
			presentHp = 0;
		}
		st = monsterSt.hurt;
		image_index = 0;
		hp_yckc_timer = 30;
		if((value > 0 && image_xscale > 0) || (value < 0 && image_xscale < 0)){
			image_xscale = -image_xscale;
		}
	}
	var hurtValue = 0;
	if(value > 15){
		hurtValue = 3;
	}else if(value < -15){
		hurtValue = -3;
	}else {
		hurtValue = value / 5;
	}
	phy_speed_x = hurtValue;
}