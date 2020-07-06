/// @arg id
/// @arg value
/// @arg type

// 友方角色受到伤害时调用此函数
// 正负号表伤害的方向
// type表示伤害类型
// 0表示可以被格挡，1表示不能被格挡（受到部分伤害），但是可以被翻滚躲过，2表示无论如何都无法躲避

var obId = argument0;
var value = argument1;
var type = argument2;

if(type == 0){
	if(((obId.st != plSt.defense) 
	|| (value > 0 && obId.image_xscale > 0) 
	|| (value < 0 && obId.image_xscale < 0)) && obId.st != plSt.roll){ //如果受攻击方向与格挡方向不同
		obId.presentHp -= abs(value);
		obId.st = plSt.hurt;
		obId.hp_yckc_timer = 60;
		//转向
		if((value > 0 && obId.image_xscale > 0) || (value < 0 && obId.image_xscale < 0)){
			obId.image_xscale = -obId.image_xscale;
		}
	}
}else if(type == 1){
	if(obId.st != plSt.roll){
		if(obId.st == plSt.defense){
			if((value > 0 && obId.image_xscale > 0) 
			|| (value < 0 && obId.image_xscale < 0)){ //如果受攻击方向与格挡方向不同
				obId.presentHp -= abs(value);
				obId.st = plSt.hurt;
				//转向
				if((value > 0 && obId.image_xscale > 0) || (value < 0 && obId.image_xscale < 0)){
					obId.image_xscale = -obId.image_xscale;
				}
			}else {
				obId.presentHp -= floor(abs(value) / 3);
			}
		}else {
			obId.presentHp -= abs(value);
			obId.st = plSt.hurt;
			//转向
			if((value > 0 && obId.image_xscale > 0) || (value < 0 && obId.image_xscale < 0)){
				obId.image_xscale = -obId.image_xscale;
			}
		}
	}
	obId.hp_yckc_timer = 60;
}else if(type == 2){
	if(obId.st == plSt.roll){
		obId.presentHp -= floor(abs(value) / 3);
	}else if(obId.st == plSt.defense){
		if((value > 0 && obId.image_xscale > 0) 
		|| (value < 0 && obId.image_xscale < 0)){ //如果受攻击方向与格挡方向不同
			obId.presentHp -= abs(value);
			obId.st = plSt.hurt;
			//转向
			if((value > 0 && obId.image_xscale > 0) || (value < 0 && obId.image_xscale < 0)){
				obId.image_xscale = -obId.image_xscale;
			}
		}else {
			obId.presentHp -= floor(abs(value) / 1.5);
			obId.st = plSt.hurt;
			//转向
			if((value > 0 && obId.image_xscale > 0) || (value < 0 && obId.image_xscale < 0)){
				obId.image_xscale = -obId.image_xscale;
			}
		}
	}else {
		obId.presentHp -= abs(value);
		obId.st = plSt.hurt;
		//转向
		if((value > 0 && obId.image_xscale > 0) || (value < 0 && obId.image_xscale < 0)){
			obId.image_xscale = -obId.image_xscale;
		}
	}
	obId.hp_yckc_timer = 60;
}

var hurtValue = 0;
if(value > 15){
	hurtValue = 3;
}else if(value < -15){
	hurtValue = -3;
}else {
	hurtValue = value / 5;
}
obId.phy_speed_x = hurtValue;