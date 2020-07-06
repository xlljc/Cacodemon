/// @description 初始化粒子数据

life = 0;

//粒子特效创建

//粒子光
partBoomLight = part_type_create();
part_type_color1(partBoomLight,$E5AB4B);
part_type_life(partBoomLight,20,20);
part_type_sprite(partBoomLight,sp_se_boom_light1,1,1,0);
part_type_size(partBoomLight,3.5,3.5,0,0);


//碎片
part = part_type_create();
part_type_color3(part,$E5AB4B,$66666,$191919);
part_type_direction(part,0,360,0,0);
part_type_orientation(part,0,360,0,0,0);
part_type_speed(part,0.1,0.2,-0.02,0);
part_type_size(part,1,1,0.03,0);
part_type_life(part,10,20);
part_type_sprite(part,sp_se_boom_splash_part1,1,1,0);

//爆炸云朵
partSmoke = part_type_create();
part_type_color2(partSmoke,c_white,$191919);
part_type_life(partSmoke,30,40);
part_type_sprite(partSmoke,sp_se_boom_smoke1,1,1,0);
part_type_size(partSmoke,1.5,2.2,-0.02,0);
part_type_direction(partSmoke,45,135,0,0);
part_type_speed(partSmoke,0.5,0.8,0.04,0);

//碎片数量
var num = irandom_range(0,3);
repeat(num){
	with(instance_create_depth(x,y,-90,ob_npc_monster_2_bullet_splash)){
		phy_speed_y = irandom_range(-15,5);
		phy_speed_x = irandom_range(-15,15);
		part = other.part;
	}
}

part_particles_create(partSystem_prospect,x,y,partSmoke,irandom_range(2,3));
part_particles_create(partSystem_prospect,x,y,partBoomLight,1);

//part_particles_create(partSystem_prospect,x,y,partBoomCircle,1);