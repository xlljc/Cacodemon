/// @description describe

image_speed = 0;
image_index = irandom_range(0,sprite_get_number(sprite_index));

phy_fixed_rotation = 1;

#region 基本属性
	//最大生命值和当前生命值
	maxHp = 40;
	presentHp = maxHp;

	//箭袋剩余弓箭数量
	arrowMaxNum = 12;
	//arrowNum = 1;
	arrowNum = irandom_range(2,5);
	
	//前方视野距离
	viewForwardLen = 500;
	//后方视野距离
	viewRearLen = 100;
	//攻击距离
	atkLen = 400;
	//攻击冷却的时间
	atkCoolingFrame1 = 120;
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
	spIdle = sp_npc_monster_3_idle;
	spRun = sp_npc_monster_3_move;
	spAtk = undefined;
	spHurt = sp_npc_monster_3_hurt;
	spDead = sp_npc_monster_3_dead;
#endregion

#region 粒子
	//创建新的粒子
	partType = part_type_create();
	part_type_shape(partType,pt_shape_pixel);
	part_type_color1(partType,c_white);
	part_type_size(partType,2,4,0,0);
	part_type_life(partType,20,30);
	part_type_speed(partType,0.1,0.2,0.01,0);
	part_type_direction(partType,0,360,0,0);
#endregion