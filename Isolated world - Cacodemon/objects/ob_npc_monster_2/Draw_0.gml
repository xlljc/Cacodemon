/// @description describe

//如果在相机视野以外
if(!sc_instance_in_camera(id,200,100))exit;
#region 变量区
	//debug
	var deBugStr = "";
	//范围内是否有玩家
	var hasPlayer = collision_rectangle(x + (image_xscale ? viewForwardLen : -viewForwardLen),y + 30,x - (image_xscale ? viewRearLen : -viewRearLen),y - 40,ob_biology_teammate_f,0,0);
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
		po += image_xscale ? 0.5 : -0.5;
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
	}else if(st == monsterSt.atk){ //攻击
		if(sprite_index == spAtk){
			//触发攻击效果
			event = "atk";
		}
	}else if(st == monsterSt.hurt){ //受伤
		if(presentHp <= 0){ //将死时关闭物理计算
			phy_active = 0;
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
		if(abs(po) <= 0.5){
			imageSpeed = 0.2;
		}else {
			imageSpeed = 0.3;
		}
	}else if(st == monsterSt.idle){
		imageSpeed = 0.12;
	}else if(st == monsterSt.atk){ //攻击
		imageSpeed = 0.2;
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
	
	if(event == "atk"){
		if(!atkTimer && image_index >= 9 && image_index < 9 + 0.2){
			//计算炮弹发射的力度
			var force = 0;
			if(hasPlayer && abs(hasPlayer.x - x) <= 350){
				force = image_xscale ? 2.7 / 350 * abs(hasPlayer.x - x) + 0.3 : -2.7 / 350 * abs(hasPlayer.x - x) - 0.3;
			}else {
				force = image_xscale ? 3 : -3;
			}
			//发射一枚炮弹
			with(instance_create_depth(x,y - 50,depth - 10,ob_npc_monster_2_bullet)){
				physics_apply_impulse(x,y,force,-0.5);
				partType = other.partType;
				//otherId = other.id;
				partBoomLight = other.partBoomLight;
				partBoomDebris = other.partBoomDebris;
				partBoomSmoke = other.partBoomSmoke;
			}
			atkTimer = atkCoolingFrame1;
			sc_vibra_set_force(image_xscale ? -2 : 2,2);
		}else if(sc_image_index_is_last(image_index,imageSpeed,spAtk)){ //动画结束，状态改变
			st = monsterSt.idle;
		}
	}
	
#endregion

draw_self();
//绘制血条
sc_draw_haemal_strand(maxHp,presentHp,x,y,42,3,$30BE6A,$2f694b,c_maroon,120);

#region debug

	
	//draw_rectangle(x + (image_xscale ? viewForwardLen : -viewForwardLen),y + 32,x,y - 40,1);
	//deBugStr += "nextHasWall= " + string(nextHasWall);
	//deBugStr += "\nnextHasRoad= " + string(nextHasRoad);
	//deBugStr += "\nsprite = " + sprite_get_name(sprite_index);
	//deBugStr += "\nview= " + string(sc_instance_in_view(hasPlayer,self,hasWall));
	//deBugStr += "\nwall = " + string(hasWall);
	//if(hasPlayer){
	//	draw_line(x,y,hasPlayer.x,hasPlayer.y);
	//}
	//deBugStr += "\nst= " + string(sc_get_enumName(st));
	//deBugStr += "\natkTimer= " + string(atkTimer);
	//draw_text(x - 20,y,deBugStr);
	
#endregion