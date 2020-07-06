/// @description describe

#region 基本属性
	//武器标签
	weapon = "hammer";
	//武器使用图标（sprite）
	weapon_icon = sp_weapon_hammer_icon;
	//存在时间
	life_time = 0;
	//是否可以造成伤害
	canHit = 1;
	image_speed = 0;
	alarm[0] = 90;
	//武器数据
	weaponVar = undefined;
#endregion

#region 物理碰撞
	var fix = physics_fixture_create();
	physics_fixture_set_polygon_shape(fix);
	physics_fixture_add_point(fix,0,-4);
	physics_fixture_add_point(fix,5,-4);
	physics_fixture_add_point(fix,5,4);
	physics_fixture_add_point(fix,0,4);
	physics_fixture_set_collision_group(fix,0);
	physics_fixture_set_density(fix,0.5);
	physics_fixture_set_restitution(fix,0.1);
	physics_fixture_set_friction(fix,0.5);
	physics_fixture_bind(fix,id);
	physics_fixture_delete(fix);
#endregion