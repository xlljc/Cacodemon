/// @description 触发攻击
if(ckJ){
	//转变sprite（注意要刷新动画数据）
	if(st == plSt.jumpFall && ckS){
		if(!atkCoolingTimer1){
			skeleton_animation_set_ext("fallAtkFall",0);
			animationName = "fallAtkFall";
			animationIndex = 0;
			animationFrames = skeleton_animation_get_frames("fallAtkFall");
			image_speed = 1.5;
			phy_speed_y += 10;
			st = plSt.atk;
			atkCoolingFrame1 = 60;
			atkCoolingTimer1 = atkCoolingFrame1;
		}
	}else if((st == plSt.jumpUp || st == plSt.jumpFall) && po != 0){
		if(!atkCoolingTimer2){
			skeleton_animation_set_ext("jumpAtk",0);
			animationName = "jumpAtk";
			animationIndex = 0;
			animationFrames = skeleton_animation_get_frames("jumpAtk");
			image_speed = 2;
			st = plSt.atk;
			atkCoolingFrame2 = 60;
			atkCoolingTimer2 = atkCoolingFrame2;
		}
	}else if(st == plSt.run){
		if(!atkCoolingTimer3){
			skeleton_animation_set_ext("runAtk",0);
			animationName = "runAtk";
			animationIndex = 0;
			animationFrames = skeleton_animation_get_frames("runAtk");
			image_speed = 1.5;
			st = plSt.atk;
			atkCoolingFrame3 = 48;
			atkCoolingTimer3 = atkCoolingFrame3;
		}
	}else if(animationName != spAtk){
		if(!atkCoolingTimer4){
			skeleton_animation_set_ext(spAtk,0);
			animationName = spAtk;
			animationIndex = 0;
			animationFrames = skeleton_animation_get_frames(animationName);
			image_speed = 1.5;
			st = plSt.atk;
			atkCoolingFrame4 = 30;
			atkCoolingTimer4 = atkCoolingFrame4;
		}else if(!atkCoolingTimer3){
			skeleton_animation_set_ext("runAtk",0);
			animationName = "runAtk";
			animationIndex = 0;
			animationFrames = skeleton_animation_get_frames("runAtk");
			image_speed = 1.5;
			st = plSt.atk;
			atkCoolingFrame3 = 48;
			atkCoolingTimer3 = atkCoolingFrame3;
		}
	}
}