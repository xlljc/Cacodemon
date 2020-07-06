/// @description 被攻击后冒火和爆炸

//燃烧状态
if(flag){
	var x0 = phy_position_x + lengthdir_x(15,image_angle + 90);
	var y0 = phy_position_y + lengthdir_y(15,image_angle + 90);
	//燃烧120帧然后爆炸
	if(++ timer >= 120){
		//爆炸效果创建
		if(timer == 120){
			sprite_index = noone;
			part_particles_create(partSystem_prospect,x0,y0,partBoomSe,1);
			lightId.light[| eLight.Intensity] = 10;
			lightId.light[| eLight.Range] = 300;
			alarm[0] = -1;
			//爆炸抖屏
			sc_vibra_set_force(irandom_range(-8,8),10);
			//伤害
			attack_list_box = ds_list_create();
			sc_attack_circle(x0,y0,100,ob_biology_f,15,1,2,0,0);
			sc_object_touch_circle(x0,y0,100,undefined,0);
			ds_list_destroy(attack_list_box);
		}else if(!lightId.light[| eLight.Intensity]){ //销毁自己
			instance_destroy(lightId);
			instance_destroy();
			exit;
		}else {
			lightId.light[| eLight.Intensity] -= lightIntensityReduc;
		}
		
	}else { //燃烧状态
		//产生火焰粒子
		part_particles_create(partSystem_prospect,x0,y0,partFire,1);
		//创建灯光
		if(lightId == undefined){
			lightId = instance_create_depth(x0,y0 - 15,-100,obj_light);
			alarm[0] = 6;
			with(lightId){
				light[| eLight.Color] = $FF00A1FF;
				light[| eLight.Range] = 200;
				light[| eLight.Intensity] = 2;
				light[| eLight.Width] = 1;
			}
		}
	}
	//灯光跟随物体
	lightId.light[| eLight.X] = x0;
	lightId.light[| eLight.Y] = y0;
}
