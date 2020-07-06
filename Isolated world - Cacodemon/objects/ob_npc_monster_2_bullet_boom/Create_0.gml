/// @description describe

flag = 0;

//光的强度自减量
lightIntensityReduc = 0;

//粒子
//光粒子
partBoomLight = undefined;
//碎片粒子
partBoomDebris = undefined;
//烟粒子
partBoomSmoke = undefined;

//创建灯光效果
lightId = instance_create_depth(x,y,-100,obj_light);