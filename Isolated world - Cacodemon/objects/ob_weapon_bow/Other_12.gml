/// @description 拾起事件

//判断箭袋是否存在,如果不存在，就创建
if(weaponIndex == 0){
	if(weaponBox1Var == undefined){
		weaponBox1Var = ds_map_create();
		weaponBox1Var[? "arrow"] = 0;
		weaponBox1Var[? "arrowMax"] = 12;
	}
}else {
	if(weaponBox2Var == undefined){
		weaponBox2Var = ds_map_create();
		weaponBox2Var[? "arrow"] = 0;
		weaponBox2Var[? "arrowMax"] = 12;
	}
}

//被拾起时存放partType
//如果存在之前的粒子类型，则销毁
if(weaponPartType1 != undefined){
	part_type_destroy(weaponPartType1);
}
//创建新的粒子
weaponPartType1 = part_type_create();
part_type_shape(weaponPartType1,pt_shape_pixel);
part_type_color1(weaponPartType1,c_white);
part_type_size(weaponPartType1,2,4,0,0);
part_type_life(weaponPartType1,20,30);
part_type_speed(weaponPartType1,0.1,0.2,0.01,0);
part_type_direction(weaponPartType1,0,360,0,0);