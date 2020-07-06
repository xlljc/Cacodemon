/// @description describe

image_speed = 0;
image_index = irandom_range(0,sprite_get_number(sprite_index));

phy_fixed_rotation = 1;

#region 基本属性
	//最大生命值和当前生命值
	maxHp = 30;
	presentHp = maxHp;
	
	//前方视野距离
	viewForwardLen = 400;
	//后方视野距离
	viewRearLen = 100;
	//攻击距离
	atkLen = 40;
	//攻击冷却的时间
	atkCoolingFrame1 = 45;
	//自定义动画速度
	imageSpeed = 0;
#endregion

#region 计时器
	//转向计时器
	turnTimer = 0;
	//惊叹计时器
	surprisedTimer = 0;
	//攻击计时器
	atkTimer = 0;
	//延迟扣除的血量
	hp_yckc = presentHp;
	//延迟扣除血量计时器
	hp_yckc_timer = 0;
#endregion

#region 动画sprite
	//状态
	st = monsterSt.run;
	//动画储存变量
	spIdle = sp_npc_monster_1_idle;
	spRun = sp_npc_monster_1_idle;
	spAtk = sp_npc_monster_1_atk;
	spHurt = sp_npc_monster_1_hurt;
	spDead = sp_npc_monster_1_dead;
#endregion