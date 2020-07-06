/// @description describe


//如果对象在视野指定范围外，就关闭特效
if(enable && sc_instance_in_camera(id,50,50)){
	if(!enableSpecialEffects){
		enableSpecialEffects = 1;
		//启用光照
		light_add_to_world(lightId.light);
	}
	part_particles_create(partSystem_background,x + 3,y - 10,partType,1);
}else if(!enable){
	if(enableSpecialEffects){
		enableSpecialEffects = 0;
		//禁用光照
		light_remove_from_world(lightId.light);
	}
}