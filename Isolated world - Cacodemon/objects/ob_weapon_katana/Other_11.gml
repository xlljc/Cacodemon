/// @description 攻击效果

//武士刀
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

#region 逻辑代码（攻击效果）
	if(animationName == "runAtk"){ //奔跑攻击状态
		po = image_xscale ? 2 : -2;
		if(animationIndex == 0){
			ds_list_clear(attack_list_box);
		}else if(animationIndex >= 15 && animationIndex < 15 + image_speed){
			sc_attack_rectangle(x + (image_xscale ? 65 : -65),y-10,x,y - 20,
						ob_biology_monster_f,14,0,0,
						image_xscale ? 5 : -5,0);
			sc_object_touch_rectangle(x + (image_xscale ? 65 : -65),y-10,x,y - 20,attack_list_box,0);
		}
	}else if(animationName == spAtk){ //普通攻击状态
		if(animationIndex == 0){
			ds_list_clear(attack_list_box);
		}else if(animationIndex >= 12.5 && animationIndex < 12.5 + image_speed){
			sc_attack_rectangle(x + (image_xscale ? 60 : -60),y,x,y - 80,
						ob_biology_monster_f,12,0,0,
						0,5);
			sc_object_touch_rectangle(x + (image_xscale ? 60 : -60),y,x,y - 80,attack_list_box,0);
		}
	}else if(animationName == "fallAtkGround"){ //下坠攻击
		if(animationIndex == 0){
			ds_list_clear(attack_list_box);
			sc_attack_rectangle(x + 40,y,x - 40,y - 50,
						ob_biology_monster_f,12,1,0,
						0,0);
			sc_object_touch_rectangle(x + 40,y,x - 40,y - 50,attack_list_box,0);
			sc_vibra_set_force(0,15);
		}
	}else if(animationName == "jumpAtk"){
		po = 0;
		phy_speed_y = 0;
		if(animationIndex == 0){
			ds_list_clear(attack_list_box);
		}else if(animationIndex >= 7.5 && animationIndex < 22.5 + image_speed){
			phy_speed_x = image_xscale ? 12 : -12;
			sc_attack_rectangle(x + (image_xscale ? 65 : -65),y-10,x,y - 20,ob_biology_monster_f,14,0,0,0,0);
			sc_object_touch_rectangle(x + (image_xscale ? 65 : -65),y-10,x,y - 20,attack_list_box,0);
		}else {
			phy_speed_x = 0;
		}
	}
#endregion