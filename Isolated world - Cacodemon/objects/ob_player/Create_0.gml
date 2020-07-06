/// @description describe


#region 物理
	//物理碰撞盒不旋转
	phy_fixed_rotation = 1;
	//上一帧y轴运动速度
	phy_speed_yprevious = 0;
	//翻转的碰撞盒
	rollFixture = physics_fixture_create();
	physics_fixture_set_polygon_shape(rollFixture);
	physics_fixture_add_point(rollFixture,-30,-37);
	physics_fixture_add_point(rollFixture,30,-37);
	physics_fixture_add_point(rollFixture,30,0);
	physics_fixture_add_point(rollFixture,-30,0);
	physics_fixture_set_collision_group(rollFixture,0);
	physics_fixture_set_density(rollFixture,0.0001);
	physics_fixture_set_restitution(rollFixture,0.1);
	physics_fixture_set_friction(rollFixture,0.5);
	//是否绑定翻转碰撞盒
	isUseRollFixture = 0;
	//是否落地
	isLd = 0;
#endregion

//玩家状态
st = plSt.idle;
image_speed = 0;
//最大生命值和当前生命值
maxHp = 100;
presentHp = maxHp;


//发光器创建
lightId = instance_create_depth(phy_position_x,phy_position_y - 45,-100,obj_light);
with(lightId){
	light[| eLight.Color] = $FFFFFFFF;
	light[| eLight.Range] = 800;
	light[| eLight.Intensity] = 1.2;
	light[| eLight.Width] = 1;
}

//背包
globalvar package;
package = ds_map_create();

//事件执行
eventBox = ds_map_create();

#region 计时器
	//绘制文字计时器
	drawTime = 0;
	//跳跃落地计时器
	jumpGroundTimer = 0;
	//攻击冷却计时器
	atkCoolingTimer1 = 0;
	atkCoolingTimer2 = 0;
	atkCoolingTimer3 = 0;
	atkCoolingTimer4 = 0;
	//攻击冷却帧数
	atkCoolingFrame1 = 50;
	atkCoolingFrame2 = 50;
	atkCoolingFrame3 = 50;
	atkCoolingFrame4 = 50;
#endregion

#region 攻击属性
	//玩家武器槽
	weaponBox1 = "none";
	weaponBox2 = "none";
	//玩家当前手持武器（根据武器获取玩家sprite_index）
	weapon = weaponBox1;
	weaponIndex = 0;
	//单次碰撞储存list
	attack_list_box = ds_list_create();
	//武器变量的（比如弓箭自带的箭袋）
	weaponBox1Var = undefined;
	weaponBox2Var = undefined;
	//武器粒子
	weaponPartType1 = undefined;
	weaponPartType2 = undefined;
	weaponPartType3 = undefined;
#endregion

#region 精灵
	//玩家精灵（临时储存精灵index）
	spIdle = "idle";
	spJumpUp = "jumpUp";
	spJumpFall = "jumpFall";
	spJumpGround = "jumpGround";
	spRun = "run";
	spAtk = "atk";
	spHurt = "hurt";
	spDefense = "defense";
	spRoll = "roll";
	//设置默认动画
	skeleton_animation_set_ext(spIdle,0);
	//设置动画过渡
	skeleton_animation_mix(spAtk,spIdle,0.05);
	skeleton_animation_mix(spJumpFall,spJumpGround,0.02);
	skeleton_animation_mix(spIdle,spRun,0.05);
	skeleton_animation_mix(spIdle,spHurt,0.02);
	skeleton_animation_mix(spHurt,spIdle,0.05);
	skeleton_animation_mix(spDefense,spIdle,0.05);
	//玩家动画名称
	animationName = skeleton_animation_get_ext(0);
	//动画当前帧
	animationIndex = skeleton_animation_get_frame(0);
	//动画总帧
	animationFrames = skeleton_animation_get_frames(animationName);
	
#endregion

#region 绘制血条和蓝条变量
	//延迟扣除的血量
	hp_yckc = presentHp;
	//延迟扣除血量计时器
	hp_yckc_timer = 0;
	
#endregion