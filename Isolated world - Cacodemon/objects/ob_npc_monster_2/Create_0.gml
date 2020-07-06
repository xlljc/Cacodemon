/// @description describe

image_speed = 0;
image_index = irandom_range(0,sprite_get_number(sprite_index));

phy_fixed_rotation = 1;

#region 基本属性
	//最大生命值和当前生命值
	maxHp = 40;
	presentHp = maxHp;
	
	//前方视野距离
	viewForwardLen = 450;
	//后方视野距离
	viewRearLen = 100;
	//攻击距离
	atkLen = 350;
	//攻击冷却的时间
	atkCoolingFrame1 = 180;
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
	spIdle = sp_npc_monster_2_idle;
	spRun = sp_npc_monster_2_move;
	spAtk = sp_npc_monster_2_atk;
	spHurt = sp_npc_monster_2_hurt;
	spDead = sp_npc_monster_2_dead;
#endregion

#region 粒子
	//炮弹飞出时的粒子
	partType = part_type_create();
	part_type_shape(partType,pt_shape_pixel);
	part_type_color1(partType,c_white);
	part_type_size(partType,5,7,-0.15,0);
	part_type_life(partType,20,30);
	part_type_speed(partType,0.1,0.2,0.01,0);
	part_type_direction(partType,0,360,0,0);
	
	#region 爆炸粒子
		//粒子光
		partBoomLight = part_type_create();
		part_type_color1(partBoomLight,$E5AB4B);
		part_type_life(partBoomLight,20,20);
		part_type_sprite(partBoomLight,sp_se_boom_light1,1,1,0);
		part_type_size(partBoomLight,3.5,3.5,0,0);

		//碎片
		partBoomDebris = part_type_create();
		part_type_color3(partBoomDebris,$E5AB4B,$66666,$191919);
		part_type_direction(partBoomDebris,0,360,0,0);
		part_type_orientation(partBoomDebris,0,360,0,0,0);
		part_type_speed(partBoomDebris,0.1,0.2,-0.02,0);
		part_type_size(partBoomDebris,1,1,0.03,0);
		part_type_life(partBoomDebris,10,20);
		part_type_sprite(partBoomDebris,sp_se_boom_splash_part1,1,1,0);

		//爆炸云朵
		partBoomSmoke = part_type_create();
		part_type_color2(partBoomSmoke,c_white,$191919);
		part_type_life(partBoomSmoke,30,40);
		part_type_sprite(partBoomSmoke,sp_se_boom_smoke1,1,1,0);
		part_type_size(partBoomSmoke,1.5,2.2,-0.02,0);
		part_type_direction(partBoomSmoke,45,135,0,0);
		part_type_speed(partBoomSmoke,0.5,0.8,0.04,0);
	#endregion
#endregion