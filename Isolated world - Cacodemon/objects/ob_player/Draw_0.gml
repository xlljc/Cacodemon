/// @description 运动代码

#region 变量区
	//Debug
	var deBugStr = "";
	
	//是否按下的某个按钮
	ckA = keyboard_check(key[? "left"]); //左移
	ckD = keyboard_check(key[? "right"]); //右移
	ckW = keyboard_check_pressed(key[? "up"]); //跳跃
	ckS = keyboard_check(key[? "down"]); //下跳/防御
	ckJ = keyboard_check(key[? "attack"]); //攻击
	ckQ = keyboard_check_pressed(key[? "change"]); //切换武器
	ckG = keyboard_check_pressed(key[? "lost"]); //扔掉武器
	ckH = keyboard_check_pressed(key[? "throw"]); //仍出武器
	ckE = keyboard_check_pressed(key[? "picUp"]); //拾取武器
	ckK = keyboard_check_pressed(key[? "rolling"]); //向前翻滚
	
	
	
	//移动的距离变量
	po = 0;
	//是否落地
	if(image_xscale){
		isLd = collision_rectangle(x - 12,y + 2,x + 10,y,ob_floor_collision,0,0);
	}else {
		isLd = collision_rectangle(x - 12,y + 2,x + 10,y,ob_floor_collision,0,0);
	}
	//isLd = phy_speed_y == phy_speed_yprevious;
	//isLd = place_meeting(x,y + 3,ob_floor_collision);
	deBugStr += "\nisld =" + string(isLd);
	
	//debug每次移动一格
	if(keyboard_check_pressed(ord("N"))){
		po = -1;
	}
	if(keyboard_check_pressed(ord("M"))){
		po = 1;
	}
	//规范血量
	if(presentHp > maxHp){
		presentHp = maxHp;
	}else if(presentHp < 0){
		presentHp = 0;
	}
	//玩家动画名称
	animationName = skeleton_animation_get_ext(0);
	//动画当前帧
	animationIndex = skeleton_animation_get_frame(0);
	//动画总帧
	animationFrames = skeleton_animation_get_frames(animationName) - 0.5;
	//更新武器sprite
	if(weapon == weaponBox1){
		weaponOb = sc_get_weaponObject(weapon);
		weaponBox1Ob = weaponOb;
		weaponBox2Ob = sc_get_weaponObject(weaponBox2);
	}else {
		weaponOb = sc_get_weaponObject(weapon);
		weaponBox1Ob = sc_get_weaponObject(weaponBox1);
		weaponBox2Ob = weaponOb;
	}
#endregion

#region 计时器变化
	//落地计时器
	jumpGroundTimer --;
	//攻击计时器
	atkCoolingTimer1 --;
	atkCoolingTimer2 --;
	atkCoolingTimer3 --;
	atkCoolingTimer4 --;
#endregion

#region 动作代码逻辑,事件触发
	//st != plSt.atk && st != plSt.defense && st != plSt.roll
	if(sc_compare(scCompare.allNotEquals,st,plSt.atk,plSt.defense,plSt.roll) || (st == plSt.atk && phy_speed_y != 0)){ // 奔跑
		if(ckA){
			po -= 4;
		}
		if(ckD){
			po += 4;
		}
	}
	if(st == plSt.run || st == plSt.idle){ //跳跃
		if(ckW && isLd){
			st = plSt.jumpUp;
			image_xscale = image_xscale ? 0.5 : -0.5;
			image_yscale = 1.3;
			eventBox[? "jump"] = 1;
		}
	}
	//st != plSt.jumpGround && st != plSt.atk && st != plSt.roll
	if(sc_compare(scCompare.allNotEquals,st,plSt.jumpGround,plSt.atk,plSt.roll)){ //攻击
		//调用触发攻击事件
		event_perform_object(weaponOb,ev_other,ev_user0);
	}
	if((st == plSt.idle || st == plSt.run) && po == 0){ //防御
		if(ckS){
			st = plSt.defense;
		}
	}
	if(st == plSt.run || st == plSt.idle || st == plSt.defense){ //向前翻滚
		if(ckK){
			st = plSt.roll;
		}
	}
	if(st == plSt.roll){
		po += image_xscale ? 5 : -5;
	}

	//运动状态转变
	if((st == plSt.idle || st == plSt.jumpGround) && po != 0 && phy_position_x + po != phy_position_xprevious){
		st = plSt.run;
	}else if(st == plSt.run && phy_position_x + po == phy_position_xprevious){
		st = plSt.idle;
	}else if((st == plSt.jumpUp || st == plSt.idle || st == plSt.run || st == plSt.defense) && phy_speed_y > 0){
		st = plSt.jumpFall;
	}else if(st == plSt.jumpFall && isLd){
		//如果在高处落下，则设置抖动
		if(phy_speed_yprevious > 17){
			sc_vibra_set_force(0,3);
		}else if(phy_speed_yprevious > 11){
			sc_vibra_set_force(0,1);
		}
		if(po != 0){
			st = plSt.run;
		}else {
			st = plSt.jumpGround;
			jumpGroundTimer = 6;
		}
	}else if(st == plSt.jumpGround && !jumpGroundTimer){
		st = plSt.idle;
	}else if(st == plSt.atk){ //攻击事件（特殊）
		
	}else if(st == plSt.hurt){
		if(animationIndex >= animationFrames - image_speed && animationName == spHurt){
			if(phy_speed_y > 0){
				st = plSt.jumpFall;
			}else if(phy_speed_y < 0){
				st = plSt.jumpUp;
			}else {
				st = plSt.idle;
			}
		}
	}else if(st == plSt.defense){
		if(!ckS){
			if(po != 0){
				st = plSt.run;
			}else {
				st = plSt.idle;
			}
		}else {
			if(!(ckA && ckD))
			if((ckD && image_xscale < 0) || (ckA && image_xscale > 0)){
				image_xscale = -image_xscale;
			}
		}
	}else if(st == plSt.roll){
		if(animationIndex >= animationFrames - image_speed && animationName == spRoll){
			if(phy_speed_y > 0){
				st = plSt.jumpFall;
			}else if(phy_speed_y < 0){
				st = plSt.jumpUp;
			}else {
				st = plSt.idle;
			}
		}
	}
	//翻滚碰撞盒改变
	if(st == plSt.roll && !isUseRollFixture){
		isUseRollFixture = physics_fixture_bind_ext(rollFixture,id,30,74);
	}else if(st != plSt.roll && isUseRollFixture){
		physics_remove_fixture(id,isUseRollFixture);
		isUseRollFixture = 0;
	}
	//扔掉武器
	if((ckG || ckH) && weapon != "none" && st != plSt.atk && st != plSt.roll){
		eventBox[? "throwWeapon"] = 1;
	}
	//切换武器
	if(st != plSt.atk  && st != plSt.roll && ckQ){
		eventBox[? "switchWeapon"] = 1;
	}
	//靠近武器可以拾取
	var tmpWeapon = instance_place(x,y,ob_weapon_f);
	if(tmpWeapon && tmpWeapon.life_time > 60 && st != plSt.atk  && st != plSt.roll){
		eventBox[? "pickUpWeapon"] = 1;
	}else {
		drawTime = 0;
	}
#endregion

#region 动画代码逻辑,事件触发
	//sprite转向
	if((po > 0 && image_xscale < 0) || (po < 0 && image_xscale > 0)){
		image_xscale = -image_xscale;
	}
	if(st == plSt.atk){ //攻击事件（特殊）
		//调用攻击效果事件
		event_perform_object(weaponOb,ev_other,ev_user1);
	}

	#region 如果状态与精灵不同，则变换精灵（攻击状态除外）,然后刷新动画数据
		switch(st){
			case plSt.idle:
				if(animationName != spIdle){
					skeleton_animation_set_ext(spIdle,0);
				}
			break;
			case plSt.run:
				if(animationName != spRun){
					skeleton_animation_set_ext(spRun,0);
				}
			break;
			case plSt.jumpUp:
				if(animationName != spJumpUp){
					skeleton_animation_set_ext(spJumpUp,0);
				}
			break;
			case plSt.jumpFall:
				if(animationName != spJumpFall){
					skeleton_animation_set_ext(spJumpFall,0);
				}
			break;
			case plSt.jumpGround:
				if(animationName != spJumpGround){
					skeleton_animation_set_ext(spJumpGround,0);
				}
			break;
			case plSt.atk:
				
			break;
			case plSt.hurt:
				if(animationName != spHurt){
					skeleton_animation_set_ext(spHurt,0);
				}
			break;
			case plSt.defense:
				if(animationName != spDefense){
					skeleton_animation_set_ext(spDefense,0);
				}
			break;
			case plSt.roll:
				if(animationName != spRoll){
					skeleton_animation_set_ext(spRoll,0);
				}
			break;
		}
	#endregion

	//动画帧数递进
	if(st == plSt.run){
		image_speed = 1.5;
	}else if(st == plSt.idle){
		image_speed = 0.3;
	}else if(st == plSt.jumpUp){
		if(image_xscale < 0 && image_xscale > -1){
			image_xscale -= 0.05;
		}else if(image_xscale > 0 && image_xscale < 1){
			image_xscale += 0.05;
		}
		if(image_yscale > 1){
			image_yscale -= 0.02;
		}
	}else if(st == plSt.jumpFall){
		
	}else if(st == plSt.jumpGround){
		image_speed = 1;
	}else if(st == plSt.hurt){
		image_speed = 1;
	}else if(st == plSt.defense){
		if(animationIndex >= animationFrames - 2){
			image_speed = 0;
		}else {
			image_speed = 1;
		}
	}else if(st == plSt.roll){
		image_speed = 2;
	}
	//跳跃的image缩放还原
	if(st != plSt.jumpUp && (image_yscale != 1 || (image_xscale != -1 && image_xscale != 1))) {
		image_xscale = image_xscale ? 1 : -1;
		image_yscale = 1;
		image_blend = c_white;
	}else if(st == plSt.jumpUp || st == plSt.jumpFall){ //在空中的image_blend还原
		image_blend = c_white;
	}
	
#endregion

draw_self();

#region 其他事件
	
	//调用武器被动事件
	if(weaponBox1 == weaponBox2){
		event_perform_object(weaponBox1Ob,ev_other,ev_user3);
	}else {
		event_perform_object(weaponBox1Ob,ev_other,ev_user3);
		event_perform_object(weaponBox2Ob,ev_other,ev_user3);
	}
	
	
#endregion

#region 事件执行代码
	//执行移动
	phy_position_x += po;
	
	//发光器位置
	with(lightId){
		light[| eLight.X] = other.phy_position_x;
		light[| eLight.Y] = other.phy_position_y - 45;
	}
	//跳跃
	if(eventBox[? "jump"]){ 
		physics_apply_impulse(x,y,0,-13);
	}
	//扔掉武器
	if(eventBox[? "throwWeapon"]){
		#region 扔掉武器逻辑代码
			var otherId = noone;
			if(ckH){ //按H就会用力扔出
				otherId = sc_create_weapon(x,y - 20,weapon,depth,image_xscale ? 0 : 180,image_xscale ? 0.5 : -0.5,-0.5,image_xscale ? 720 : -720);
			}else {
				otherId = sc_create_weapon(x,y - 20,weapon,depth,image_xscale ? 0 : 180,0,0,0);
			}
			//更新武器槽
			if(weaponIndex == 0){
				weaponBox1 = "none";
				weaponBox1Ob = ob_player;
				//将临时变量返还给武器
				otherId.weaponVar = weaponBox1Var;
				weaponBox1Var = undefined;
			}else {
				weaponBox2 = "none";
				weaponBox2Ob = ob_player;
				//将临时变量返还给武器
				otherId.weaponVar = weaponBox2Var;
				weaponBox2Var = undefined;
			}
			//调用扔出事件
			event_perform_object(weaponOb,ev_other,ev_user4);
			weapon = "none";
			weaponOb = ob_player;
			sc_set_playerSprite(weapon);
		#endregion
	}
	//切换武器
	if(eventBox[? "switchWeapon"]){
		#region 切换武器逻辑代码
			weaponIndex = !weaponIndex;
			if(weaponIndex == 0){
				weapon = weaponBox1;
				weaponOb = weaponBox1Ob;
			}else {
				weapon = weaponBox2;
				weaponOb = weaponBox2Ob;
			}
			//调用切换事件
			event_perform_object(weaponOb,ev_other,ev_user5);
			sc_set_playerSprite(weapon);
		#endregion
	}
	//拾起武器
	if(eventBox[? "pickUpWeapon"]){
		#region 拾起武器逻辑代码
			if(weapon == "none"){
				//显示的文字
				var strTemp = sc_json_read_value(JsonSystemText,"remind","onGame","pickUpWeapon");
				var strName = sc_get_weaponName(tmpWeapon.weapon);
				sc_draw_text_ext(tmpWeapon.x - 35,tmpWeapon.y + 3,strTemp + strName,2,SystemFontSize + 5,200,1,c_white);
				if(ckE){
					weapon = tmpWeapon.weapon;
					weaponOb = sc_get_weaponObject(weapon);
					sc_set_playerSprite(weapon);
				}
			}else {
				//显示的文字
				var strTemp = sc_json_read_value(JsonSystemText,"remind","onGame","replaceWeapon");
				var strName = sc_get_weaponName(tmpWeapon.weapon);
				sc_draw_text_ext(tmpWeapon.x - 35,tmpWeapon.y + 3,strTemp + strName,2,SystemFontSize + 5,200,1,c_white);
				if(ckE){
					//先把之前的武器扔出
					{
						var otherId = sc_create_weapon(x,y - 20,weapon,depth,image_xscale ? 0 : 180,0,0,0);
						//将临时变量返还给武器
						if(weaponIndex == 0){
							otherId.weaponVar = weaponBox1Var;
							weaponBox1Var = undefined;
						}else {
							otherId.weaponVar = weaponBox2Var;
							weaponBox2Var = undefined;
						}
						//调用扔出事件
						event_perform_object(weaponOb,ev_other,ev_user4);
					}
					//捡起
					weapon = tmpWeapon.weapon;
					weaponOb = sc_get_weaponObject(weapon);
					sc_set_playerSprite(weapon);
				}
			}
			if(ckE){
				//刷新武器槽的武器
				if(weaponIndex == 0){
					weaponBox1 = weapon;
					weaponBox1Ob = weaponOb;
					weaponBox1Var = tmpWeapon.weaponVar;
				}else {
					weaponBox2 = weapon;
					weaponBox2Ob = weaponOb;
					weaponBox2Var = tmpWeapon.weaponVar;
				}
				//调用拾起事件
				event_perform_object(weaponOb,ev_other,ev_user2);
				//删除地上的武器
				instance_destroy(tmpWeapon);
			}
		#endregion
	}
	
	//清空事件
	ds_map_clear(eventBox);
	
	//记录上一帧的y轴速度
	phy_speed_yprevious = phy_speed_y;

	
#endregion

#region debug

	if(keyboard_check_pressed(vk_numpad1)){
		//sc_monster_lostHp(,irandom_range(10,30));
	}else if(keyboard_check_pressed(vk_numpad3)){
		//sc_monster_lostHp(-irandom_range(10,30));
	}else if(keyboard_check_pressed(vk_numpad5)){
		presentHp += 30;
	}
	//draw_line(0,0,x,y);
	//draw_text(x,y,"speed_y = " + string(phy_speed_y));
	//deBugStr += "\nanimationName =" + string(animationName);
	//deBugStr += "\nanimationIndex =" + string(animationIndex);
	//deBugStr += "\nanimationFrames =" + string(animationFrames);
	//绘制物理碰撞盒
	//physics_world_draw_debug(phy_debug_render_shapes);
	//draw_rectangle_color(x + 10,y + 3,x - 13,y,c_red,c_red,c_red,c_red,0);
	//draw_text(5,10,deBugStr);
#endregion
