/// @description 着火后灯光闪烁

alarm[0] = irandom_range(5,12);

with(lightId){
	if(light[| eLight.Intensity] == 2){
		light[| eLight.Intensity] = 2.3;
	}else {
		light[| eLight.Intensity] = 2;
	}
}