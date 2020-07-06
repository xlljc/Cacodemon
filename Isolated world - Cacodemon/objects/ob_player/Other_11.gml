/// @description 攻击效果

//拳击
#region 状态与sprite

	//变化状态
	if(animationName != "fallAtkFall" && animationIndex >= animationFrames - image_speed){
		if(phy_speed_y > 0){
			st = plSt.jumpFall;
		}else if(phy_speed_y < 0){
			st = plSt.jumpUp;
		}else {
			st = plSt.idle;
		}
	}else if(animationName == "fallAtkFall"){ //下坠落地触发
		if(isLd){
			skeleton_animation_set_ext("fallAtkGround",0);
			animationName = "fallAtkGround";
			animationIndex = 0;
			animationFrames = skeleton_animation_get_frames("fallAtkGround");
			image_speed = 1.5;
		}
	}
	
#endregion

#region 逻辑代码
	if(animationName == "runAtk"){
		po = image_xscale ? 1 : -1;
		if(animationIndex == 0){
			ds_list_clear(attack_list_box);
		}else if(animationIndex >= 8 && animationIndex < 8 + image_speed){
			sc_attack_rectangle(x + (image_xscale ? 30 : -30),y - 25,x,y - 36,
						ob_biology_monster_f,5,0,0,
						image_xscale ? 2 : -2,0);
			sc_object_touch_rectangle(x + (image_xscale ? 30 : -30),y - 25,x,y - 36,attack_list_box,0);
		}
	}else if(animationName == spAtk){
		if(animationIndex == 0){
			ds_list_clear(attack_list_box);
		}else if(animationIndex >= 10 && animationIndex < 10 + image_speed){
			sc_attack_rectangle(x + (image_xscale ? 30 : -30),y - 25,x,y - 40,
						ob_biology_monster_f,4,0,0,
						image_xscale ? 1 : -1,0);
			sc_object_touch_rectangle(x + (image_xscale ? 30 : -30),y - 25,x,y - 40,attack_list_box,0);
		}
	}else if(animationName == "jumpAtk"){
		po = 0;
		phy_speed_y = 0;
		if(animationIndex == 0){
			ds_list_clear(attack_list_box);
		}else if(animationIndex >= 7.5 && animationIndex < 22.5 + image_speed){
			phy_speed_x = image_xscale ? 12 : -12;
			sc_attack_rectangle(x + (image_xscale ? 22 : -22),y,x,y - 36,ob_biology_monster_f,5,0,0,0,0);
			sc_object_touch_rectangle(x + (image_xscale ? 22 : -22),y,x,y - 36,attack_list_box,0);
		}else {
			phy_speed_x = 0;
		}
	}else if(animationName == "fallAtkGround"){ //下坠攻击
		if(animationIndex == 0){ //触发攻击效果
			ds_list_clear(attack_list_box);
			sc_attack_rectangle(x + (image_xscale ? 20 : -20),y,x - (image_xscale ? 10 : -10),y - 40,
						ob_biology_monster_f,7,1,0,
						0,0);
			sc_object_touch_rectangle(x + (image_xscale ? 20 : -20),y,x - (image_xscale ? 10 : -10),y - 40,attack_list_box,0);
			sc_vibra_set_force(0,12);
		}
	}
#endregion