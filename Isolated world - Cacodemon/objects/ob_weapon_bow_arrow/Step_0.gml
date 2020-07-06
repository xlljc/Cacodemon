/// @description describe


//与玩家发生碰撞（如果玩家装备弓，则会自动拾取箭）
if(!isFly){
	life_time ++;
	//如果在相机视野以外
	if(!sc_instance_in_camera(id,100,50))exit;
	
	if(life_time >= 60){
		#region 玩家碰到
			var temp = instance_place(x,y,ob_player);
			if(temp){ //如果碰到
				with(temp){
					if(weaponBox1 == "bow" || weaponBox2 == "bow"){ //如果玩家装备弓
						if(weaponBox1 == "bow" && (weaponIndex == 0 || weaponBox2 != "bow")){
							//如果弓的数量小于最大数量，就添加
							if(weaponBox1Var[? "arrow"] < weaponBox1Var[? "arrowMax"]){
								weaponBox1Var[? "arrow"] ++;
								instance_destroy(other);
							}
						}else {
							//如果弓的数量小于最大数量，就添加
							if(weaponBox2Var[? "arrow"] < weaponBox2Var[? "arrowMax"]){
								weaponBox2Var[? "arrow"] ++;
								instance_destroy(other);
							}
						}
					}
				}
			}
		#endregion
	
		#region monster_3碰到
			var temp = instance_place(x,y,ob_npc_monster_3);
			if(temp){ //如果碰到
				with(temp){
					if(arrowNum < arrowMaxNum && presentHp > 0){
						arrowNum ++;
						instance_destroy(other);
					}
				}
			}
		#endregion
	}
	
}else {
	//与敌人发生碰撞
	//这里用多重碰撞是怕敌人凑成堆
	var obj = ob_biology_monster_f;
	if(!isTeammate){
		obj = ob_biology_teammate_f;
	}
	var list = ds_list_create();
	var num = instance_place_list(x,y,obj,list,0);
	for (var i = 0; i < num; ++i) {
	    var temp = list[| i];
		if(temp && temp.presentHp > 0 && temp.st != plSt.roll && temp.st != monsterSt.roll){
			phy_speed_x = -phy_speed_x * 0.05;
			phy_speed_y = -3;
			phy_angular_velocity = irandom_range(-720,720);
			isFly = 0;
			if(isTeammate){
				sc_monster_lostHp(temp,image_xscale ? damage : -damage);
			}else {
				sc_teammate_lostHp(temp,image_xscale ? damage : -damage,1);
			}
			break;
		}
	}
	ds_list_destroy(list);
	
	//如果处于飞行状态，则不能下坠
	phy_speed_y = 0;
	//粒子效果
	if(partType != undefined){
		part_particles_create(partSystem_prospect,x,y,partType,1);
	}else {
		isFly = 0;
	}
}