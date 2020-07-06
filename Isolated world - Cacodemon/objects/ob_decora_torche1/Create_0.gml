/// @description describe

depth = 5;

//是否发亮
enable = 1;
//是否启用特效
enableSpecialEffects = 1;

//发光器创建
lightId = instance_create_depth(x,y - 15,-100,obj_light);
alarm[0] = 6;
with(lightId){
	light[| eLight.Color] = $FF00A1FF;
	light[| eLight.Range] = 200;
	light[| eLight.Intensity] = 2;
	light[| eLight.Width] = 1;
}

partType = part_type_create();
part_type_shape(partType,pt_shape_pixel);
part_type_color1(partType,$1ABDFC);
part_type_size(partType,3,5,-0.1,0);
part_type_life(partType,15,25);
part_type_speed(partType,0.5,0.9,0.01,0);
part_type_direction(partType,50,130,0,0);