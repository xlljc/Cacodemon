/// @description describe

//创建轨道粒子
part_particles_create(partSystem_prospect,x,y,partType,1);

var temp_floor = instance_place(x,y,ob_floor_collision);
var temp_teammate = instance_place(x,y,ob_biology_teammate_f);
//爆炸(会误伤)
if((temp_teammate && temp_teammate.st != plSt.roll) || temp_floor){
	
	//爆炸检测
	var list = ds_list_create();
	var num = collision_circle_list(x,y,30,ob_biology_f,0,0,list,0);
	
	for(var i = 0; i < num; ++i) {
		var temp = list[| i];
		var ob_f = object_get_parent(temp.object_index);
		if(ob_f == ob_biology_teammate_f){
			sc_teammate_lostHp(temp,x > temp.x ? -8 : 8,1);
		}else if(ob_f == ob_biology_monster_f){
			sc_monster_lostHp(temp,x > temp.x ? -8 : 8);
		}
	}
	//物体互动
	sc_object_touch_rectangle(x - 30,y - 30,x + 30,y + 30,undefined,0);
	//创建爆炸特效
	with(instance_create_depth(x,y,depth,ob_npc_monster_2_bullet_boom)){
		lightIntensityReduc = 0.4;
		with(lightId){
			light[| eLight.Color] = $FFE5AB4B;
			light[| eLight.Range] = 200;
			light[| eLight.Intensity] = 10;
			light[| eLight.Width] = 1;
		}
		partBoomLight = other.partBoomLight;
		partBoomDebris = other.partBoomDebris;
		partBoomSmoke = other.partBoomSmoke;
	}
	sc_vibra_set_force(irandom_range(-5,5),8);
	instance_destroy();
	ds_list_destroy(list);
}