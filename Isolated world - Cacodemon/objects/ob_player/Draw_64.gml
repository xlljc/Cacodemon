/// @description 绘制部分ui

#region 绘制血条

	var x0 = 12;
	var y0 = 12;
	var hp = (presentHp / maxHp) > 0 ? presentHp / maxHp : 0;
	//绘制框
	draw_rectangle_color(x0,y0,x0 + 218,y0 + 16,$E5E5E5,$E5E5E5,$E5E5E5,$E5E5E5,0);
	//绘制底板
	draw_rectangle_color(3 + x0,3 + y0,215 + x0,13 + y0,c_maroon,c_maroon,c_maroon,c_maroon,0);
	//绘制血条
	draw_sprite_part(sp_haemal_strand_hp,0,0,0,hp * 213,12,3 + x0,3 + y0);
	if(hp_yckc > maxHp){
		hp_yckc = maxHp;
	}
	if(hp_yckc > presentHp){
		if(hp_yckc > 0){
			draw_rectangle_color(3 + x0 + hp * 213,3 + y0,3 + x0  + ((hp_yckc / maxHp) > 0 ? hp_yckc / maxHp : 0) * 213,13 + y0,
									$2f694b,$2f694b,$2f694b,$2f694b,0);
		}
		if(!hp_yckc_timer){
			hp_yckc -= maxHp * (100 / 180 / 100);
		}else {
			hp_yckc_timer --;
		}
	}else {
		hp_yckc = presentHp;
	}
	//绘制血量的数值
	sc_draw_fraction_numeral(x0 + 228,y0 + 3,presentHp,maxHp,3,1);

#endregion

#region 绘制武器框
	//绘制武器
	weaponBox1IconSprite = sc_get_weaponIconSprite(weaponBox1);
	if(weaponBox1IconSprite){
		draw_sprite(weaponBox1IconSprite,0,1150,30);
	}
	weaponBox2IconSprite = sc_get_weaponIconSprite(weaponBox2);
	if(weaponBox2IconSprite){
		draw_sprite(weaponBox2IconSprite,0,1150,88);
	}
	//绘制框
	draw_sprite(sp_weapons_box,weaponIndex == 0,1110,6);
	draw_sprite(sp_weapons_box,weaponIndex == 1,1110,64);
	//调用武器绘制ui事件
	//weaponDrawUiIndex是用来区分当前是调用的哪一个武器
	weaponDrawUiIndex = 0;
	event_perform_object(weaponBox1Ob,ev_other,ev_user6);
	weaponDrawUiIndex = 1;
	event_perform_object(weaponBox2Ob,ev_other,ev_user6);
#endregion