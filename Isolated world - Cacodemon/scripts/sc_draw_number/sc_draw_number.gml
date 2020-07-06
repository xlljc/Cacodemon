/// @arg x
/// @arg y
/// @arg number
/// @arg interval
/// @arg isForward

//返回值为绘制宽度
var x0 = argument0;
var y0 = argument1;
var number = argument2 >= 0 ? argument2 : 0;
var interval = argument3;
var isForward = argument4;

//字符串宽度（12是精灵宽度）
var xTemp = (12 + interval) * string_length(string(number));
//绘制的起始位置
if(isForward){
	x0 += (xTemp - 12 - interval);
}else {
	x0 -= 12;
}

do{
	var tmp = number % 10;
	draw_sprite(sp_number,tmp,x0,y0);
	number = floor(number / 10);
	x0 -= (12 + interval);
}until(number <= 0);

return xTemp;