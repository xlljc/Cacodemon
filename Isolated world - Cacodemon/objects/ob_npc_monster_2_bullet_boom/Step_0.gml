/// @description describe

//创建爆炸效果
if(flag == 0){
	flag = 1;
	//爆炸碎片
	var num = irandom_range(0,3);
	repeat(num){
		with(instance_create_depth(x,y,-90,ob_npc_monster_2_bullet_splash)){
			phy_speed_y = irandom_range(-15,-5);
			phy_speed_x = irandom_range(-15,15);
			partBoomDebris = other.partBoomDebris;
		}
	}
	//烟
	part_particles_create(partSystem_prospect,x,y,partBoomSmoke,irandom_range(2,3));
	//爆炸光
	part_particles_create(partSystem_prospect,x,y,partBoomLight,1);
}

lightId.light[| eLight.Intensity] -= lightIntensityReduc;

if(!lightId.light[| eLight.Intensity]){
	instance_destroy(lightId);
	instance_destroy();
}