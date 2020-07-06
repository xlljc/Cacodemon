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
		po = image_xscale ? 1.5 : -1.5;
		if(animationIndex == 0){
			ds_list_clear(attack_list_box);
		}else if(animationIndex >= 7.5 && animationIndex < 7.5 + image_speed){
			sc_attack_rectangle(x + (image_xscale ? 32 : -32),y,x,y - 36,
						ob_biology_monster_f,5,0,0,
						image_xscale ? 2 : -2,0);
			sc_object_touch_rectangle(x + (image_xscale ? 32 : -32),y,x,y - 36,attack_list_box,0);
		}
	}else if(animationName == spAtk){ //普通攻击状态
		if(animationIndex >= 25 && animationIndex < 25 + image_speed){
			//发射弓箭
			var temp = instance_create_depth(x + (image_xscale ? 24 : -24),y - 34,depth,ob_weapon_bow_arrow);
			with(temp){
				phy_speed_x = other.image_xscale ? 50 : -50;
				image_xscale = other.image_xscale;
				partType = other.weaponPartType1;
			}
			if(weaponIndex == 0){
				weaponBox1Var[? "arrow"] --;
			}else {
				weaponBox2Var[? "arrow"] --;
			}
		}
	}else if(animationName == "atkNoneArrow"){ //普通攻击没有箭了
		if(animationIndex == 0){
			ds_list_clear(attack_list_box);
		}else if(animationIndex >= 9 * 2.5 && animationIndex < 9 * 2.5 + image_speed){
			sc_attack_rectangle(x + (image_xscale ? 40 : -40),y - 3,x,y - 51,
						ob_biology_monster_f,9,0,0,
						0,4);
			sc_object_touch_rectangle(x + (image_xscale ? 40 : -40),y - 3,x,y - 51,attack_list_box,0);
		}
	}else if(animationName == "fallAtkGround"){ //下坠攻击
		if(animationIndex == 0){
			ds_list_clear(attack_list_box);
			sc_attack_rectangle(x + (image_xscale ? 30 : -30),y,x - (image_xscale ? 15 : -15),y - 50,
						ob_biology_monster_f,10,1,0,
						0,0);
			sc_object_touch_rectangle(x + (image_xscale ? 30 : -30),y,x - (image_xscale ? 15 : -15),y - 50,attack_list_box,0);
			sc_vibra_set_force(0,12);
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
	}
#endregion