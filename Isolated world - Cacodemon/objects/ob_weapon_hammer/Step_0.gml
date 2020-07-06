/// @description 被扔出后

life_time ++;
//被扔出后可以造成伤害
if(canHit){
	var temp = instance_place(x, y, ob_biology_monster_f);
	if(temp){
		var num = phy_speed_x ? 1 : -1;
		if(life_time < 10){
			num *= 8;
		}else if(life_time < 60){
			num *= 15;
		}else {
			num *= 32;
		}
		phy_speed_y = -phy_speed_y;
		sc_monster_lostHp(temp,num);
		sc_vibra_set_force(phy_speed_x ? 1 : -1,1);
		canHit = 0;
	}
}