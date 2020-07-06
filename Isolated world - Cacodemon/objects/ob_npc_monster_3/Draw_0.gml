/// @description describe

//如果在相机视野以外
if(!sc_instance_in_camera(id,200,100))exit;
#region 变量区
	//debug
	var deBugStr = "";
	//范围内是否有玩家
	var hasPlayer = collision_rectangle(x + (image_xscale ? viewForwardLen : -viewForwardLen),y - 10,x - (image_xscale ? viewRearLen : -viewRearLen),y - 40,ob_biology_teammate_f,0,0);
	//判断下一步脚下是否有陆地
	var nextHasRoad = position_meeting(x + (image_xscale ? 30 : -30),y + 5,ob_floor_collision);
	//判断下一步前方是否有墙体遮挡
	var nextHasWall = position_meeting(x + (image_xscale ? 50 : -50),y - 5,ob_floor_collision);
	//运动变量
	po = 0;
	//判断玩家是否在视野里
	var instanceInView = sc_object_in_view(x + (image_xscale ? viewForwardLen : -viewForwardLen),y - 10,x - (image_xscale ? viewRearLen : -viewRearLen),y - 55,hasPlayer,ob_floor_collision);
	//玩家是否处于攻击范围内
	var isInstanceInAtkLen = hasPlayer ? abs(hasPlayer.x - x) < atkLen : 0;
	//前方是否可以前进
	var canMove = nextHasRoad && !nextHasWall;
	//事件执行
	var event = "";
#endregion

#region 计时器变化
	turnTimer --;
	atkTimer --;
	if(!instanceInView){
		surprisedTimer --;
	}
#endregion

#region 动作判定代码区
	
	if(st == monsterSt.idle){ //静止
		if(turnTimer){ //如果准备转向
			if(instanceInView != 0){ //发现玩家
				turnTimer = -1;
			}
		}else if(surprisedTimer >= 61){ //如果处于惊讶状态
			surprisedTimer --;
			draw_sprite(sp_icon_npc_surprised,0,x,y - 72);
		}else if(surprisedTimer <= 0){
			surprisedTimer = 90;
		}else if(surprisedTimer <= 60 && surprisedTimer > 0){ //非惊讶状态（运动）
			if(instanceInView != 0){ //玩家在视野内
				if(isInstanceInAtkLen){ //发起攻击
					if(!atkTimer){ //如果攻击计时器处于非冷却状态
						st = monsterSt.atk;
					}
				}else if(!isInstanceInAtkLen && canMove){ //如果玩家在攻击范围外，且下一步可移动
					st = monsterSt.run;
				}else if(!isInstanceInAtkLen && !canMove){ //如果玩家在攻击范围外，且下一步不可移动
					//转向
					turnTimer = 60;
				}
			}else {
				if(canMove){
					st = monsterSt.run;
				}else {
					//转向
					turnTimer = 60;
				}
			}
		}
	}else if(st == monsterSt.run){ //移动
		po += image_xscale ? 1 : -1;
		if(instanceInView != 0){ //玩家在可视野内
			if(surprisedTimer <= 0){ //刚发现敌人，处于惊讶状态，st变为idle
				surprisedTimer = 90;
				st = monsterSt.idle;
			}else if(!isInstanceInAtkLen && !canMove){ //如果玩家在攻击范围外，且下一步不可移动
				st = monsterSt.idle;
			}else if(!isInstanceInAtkLen && canMove){ //如果玩家在攻击范围外，且下一步可移动
				//状态不变
				po += image_xscale ? 0.5 : -0.5;
			}else if(isInstanceInAtkLen){ //玩家在攻击范围内
				if(atkTimer){ //如果攻击计时器处于冷却状态
					st = monsterSt.idle;
				}else {
					st = monsterSt.atk;
				}
			}
		}else { //玩家不在视野内
			if(!canMove){ //如果下一步不能移动了
				//准备转向
				st = monsterSt.idle;
				turnTimer = 60;
			}
		}
	}
	if(st == monsterSt.atk){ //攻击
		if(spAtk == undefined){
			//动作执行判断
			//如果箭，且玩家距离大于近战距离，那么就使用远程攻击
			if(arrowNum > 0 && (!hasPlayer || (hasPlayer && abs(hasPlayer.x - x) > 40))){
				spAtk = sp_npc_monster_3_atk;
				//攻击冷却的时间
				atkCoolingFrame1 = 120;
			}else {
				spAtk = sp_npc_monster_3_atk_noarrow;
				atkCoolingFrame1 = 66;
			}
		}
		//触发攻击效果
		if(spAtk == sp_npc_monster_3_atk){
			//射箭
			event = "atk1";
		}else if(spAtk == sp_npc_monster_3_atk_noarrow){
			//近战
			event = "atk2";
		}
	}else if(st == monsterSt.hurt){ //受伤
		if(presentHp <= 0 && spHurt != sp_npc_monster_3_hurt_none){ //将死时扔出武器，关闭物理计算
			spHurt = sp_npc_monster_3_hurt_none;
			phy_active = 0;
			event = "throwBow";
		}
		if(sc_image_index_is_last(image_index,imageSpeed,spHurt)){
			//判断是否死亡
			if(presentHp <= 0){
				st = plSt.dead;
			}else {
				st = monsterSt.idle;
			}
		}
	}else if(st == plSt.dead){ //死亡
		if(sc_image_index_is_last(image_index,imageSpeed,spDead)){
			instance_destroy();
			exit;
		}
	}
#endregion

#region 动画执行区

	#region 如果状态与sprite不符就变化sprite
		//如果没有弓箭了，就要改变贴图和攻击方式
		if(st == monsterSt.idle || st == monsterSt.run){
			if(arrowNum <= 0 && spIdle == sp_npc_monster_3_idle){
				spIdle = sp_npc_monster_3_idle_noarrow;
				spRun = sp_npc_monster_3_move_noarrow;
				spHurt = sp_npc_monster_3_hurt_noarrow;
				atkLen = 43;
			}else if(arrowNum > 0 && spIdle == sp_npc_monster_3_idle_noarrow){
				spIdle = sp_npc_monster_3_idle;
				spRun = sp_npc_monster_3_move;
				spHurt = sp_npc_monster_3_hurt;
				//攻击距离
				atkLen = 400;
			}
		}
		switch(st){
			case monsterSt.run:
				if(sprite_index != spRun){
					sprite_index = spRun;
					image_index = 0;
				}
			break;
			case monsterSt.atk:
				if(sprite_index != spAtk){
					sprite_index = spAtk;
					image_index = 0;
				}
			break;
			case monsterSt.idle:
				if(sprite_index != spIdle){
					sprite_index = spIdle;
					image_index = 0;
				}
			break;
			case monsterSt.hurt:
				if(sprite_index != spHurt){
					sprite_index = spHurt;
					image_index = 0;
				}
			break;
			case monsterSt.dead:
				if(sprite_index != spDead){
					sprite_index = spDead;
					image_index = 0;
				}
			break;
		}
	#endregion
	//如果玩家在身后
	if(instanceInView == -1 && st != monsterSt.dead && st != monsterSt.hurt){
		image_xscale = -image_xscale;
		turnTimer = -1;
	}
	//变化方向
	if(turnTimer == 1 && st == monsterSt.idle){
		st = plSt.run;
		image_xscale = -image_xscale;
	}
	//动画
	if(st == monsterSt.run){
		if(abs(po) <= 1){
			imageSpeed = 0.15;
		}else {
			imageSpeed = 0.25;
		}
	}else if(st == monsterSt.idle){
		imageSpeed = 0.12;
	}else if(st == monsterSt.atk){ //攻击
		if(sprite_index == sp_npc_monster_3_atk){
			imageSpeed = 0.2;
		}else {
			imageSpeed = 0.3;
		}
	}else if(st == monsterSt.hurt){
		imageSpeed = 0.2;
	}else if(st == plSt.dead){
		imageSpeed = 1;
	}else {
		imageSpeed = 0;
	}
	image_index += imageSpeed;
#endregion

#region 事件执行
	phy_position_x += po;
	
	if(event == "atk1"){ //攻击事件1
		if(!atkTimer && image_index >= 4 && image_index < 4 + imageSpeed){
			//发射弓箭
			var temp = instance_create_depth(x + (image_xscale ? 24 : -24),y - 30,depth,ob_weapon_bow_arrow);
			with(temp){
				phy_speed_x = other.image_xscale ? 50 : -50;
				image_xscale = other.image_xscale;
				partType = other.partType;
				isTeammate = 0;
			}
			atkTimer = atkCoolingFrame1;
			arrowNum --;
		}else if(sc_image_index_is_last(image_index,imageSpeed,spAtk)){ //动画结束，状态改变
			st = monsterSt.idle;
			spAtk = undefined;
		}
	}else if(event == "atk2"){ //攻击事件2
		if(!atkTimer && image_index >= 5 && image_index < 5 + imageSpeed){
			//近战攻击
			var list = ds_list_create();
			var num = collision_rectangle_list(x + (image_xscale ? 43 : -43),y - 5,x,y - 40,ob_biology_teammate_f,0,0,list,0);
			for(var i = 0;i < num;i ++){
				sc_teammate_lostHp(list[| i],image_xscale ? 9 : -9,0);
			}
			if(num){
				sc_vibra_set_force(0,4);
			}
			ds_list_destroy(list);
			sc_object_touch_rectangle(x + (image_xscale ? 43 : -43),y - 5,x,y - 40,undefined,0);
			atkTimer = atkCoolingFrame1;
		}else if(sc_image_index_is_last(image_index,imageSpeed,spAtk)){ //动画结束，状态改变
			st = monsterSt.idle;
			spAtk = undefined;
		}
	}else if(event == "throwBow"){ //扔出弓箭
		//扔出弓
		var otherId = sc_create_weapon(x,y - 20,"bow",depth,image_xscale ? 0 : 180,image_xscale ? -0.3 : 0.3,-0.3,image_xscale ? 180 : -180);
		//无法造成伤害
		otherId.canHit = 0;
		//将剩余弓箭数量储存到弓中
		var jd = ds_map_create();
		otherId.weaponVar = jd;
		jd[? "arrow"] = arrowNum;
		jd[? "arrowMax"] = arrowMaxNum;
	}
	
#endregion

draw_self();
//绘制血条
sc_draw_haemal_strand(maxHp,presentHp,x,y,42,3,$30BE6A,$2f694b,c_maroon,120);

#region debug
	//draw_rectangle(x + (image_xscale ? viewForwardLen : -viewForwardLen),y - 10,x - (image_xscale ? viewRearLen : -viewRearLen),y - 40,1);
	//draw_rectangle(x + (image_xscale ? viewForwardLen : -viewForwardLen),y - 10,x - (image_xscale ? viewRearLen : -viewRearLen),y - 40,1);
	//deBugStr += "nextHasWall= " + string(nextHasWall);
	//deBugStr += "\nnextHasRoad= " + string(nextHasRoad);
	//deBugStr += "\nsprite = " + sprite_get_name(sprite_index);
	//deBugStr += "\nview= " + string(instanceInView);
	//deBugStr += "\nnum= " + string(num);
	//deBugStr += "\nwall = " + string(hasWall);
	//if(hasPlayer){
	//	draw_line(x,y,hasPlayer.x,hasPlayer.y);
	//}
	//deBugStr += "\nimageIndex= " + string(image_index);
	//deBugStr += "\nst= " + string(sc_get_enumName(st));
	//deBugStr += "\natkTimer= " + string(atkTimer);
	//draw_text(x - 20,y,deBugStr);
	
#endregion