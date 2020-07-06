/// @description 

//是否点燃
flag = 0;
//点燃后存在时间
timer = 0;

//光照id
lightId = undefined;
//光照强度
lightIntensityReduc = 0.25;

//爆炸特效粒子
partBoomSe = part_type_create();
part_type_sprite(partBoomSe,sp_se_boom2,1,1,0);
part_type_size(partBoomSe,3,3,0,0);
part_type_life(partBoomSe,40,40);

//火焰粒子
partFire = part_type_create();
part_type_shape(partFire,ps_shape_rectangle);
part_type_life(partFire,20,30);
part_type_size(partFire,3,6,-0.02,0);
part_type_direction(partFire,65,115,0,0);
part_type_color3(partFire,$00C1CC,$120DCC,$333333);
part_type_speed(partFire,0.6,1.2,0.01,0);