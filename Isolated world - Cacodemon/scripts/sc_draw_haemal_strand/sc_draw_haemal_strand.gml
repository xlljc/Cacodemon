/// @arg maxHp
/// @arg hp
/// @arg x0
/// @arg y0
/// @arg width
/// @arg height
/// @arg color1
/// @arg color2
/// @arg color3
/// @arg showTimer

//绘制npc的血条
//以x为中心

var maxHp = argument0;
var hp = argument1;
var x0 = argument2;
var y0 = argument3;
var width = argument4;
var height = argument5;
var color1 = argument6;
var color2 = argument7;
var color3 = argument8;
var showTimer = argument9;

//如果超过展示时间，就隐藏
if(hp_yckc_timer >= -showTimer && hp < maxHp && hp > 0){
	//血量百分比
	hp = (hp / maxHp) > 0 ? hp / maxHp : 0;
	var hp_yckc_tmp = (hp_yckc / maxHp) > 0 ? hp_yckc / maxHp : 0;
	//绘制底板
	draw_rectangle_color(x0 - width / 2,y0,x0 + width / 2,y0 + height,color3,color3,color3,color3,0);
	//绘制血条
	if(hp > 0){
		draw_rectangle_color(x0 - width / 2,y0,x0 - width / 2 + width * hp,y0 + height,color1,color1,color1,color1,0);
	}
	if(hp_yckc > maxHp){
		hp_yckc = maxHp;
	}
	if(hp_yckc > argument1){
		if(hp_yckc > 0){
			draw_rectangle_color(x0 - width / 2 + width * hp,
								y0,
								x0 - width / 2 + (width * hp_yckc_tmp),
								y0 + height,
								color2,color2,color2,color2,0);
		}
		if(!hp_yckc_timer){
			hp_yckc -= maxHp * (100 / 90 / 100);
		}
	}else {
		hp_yckc = argument1;
	}
}
hp_yckc_timer --;