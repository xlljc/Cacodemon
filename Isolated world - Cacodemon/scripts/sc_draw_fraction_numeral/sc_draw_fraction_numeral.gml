/// @arg x
/// @arg y
/// @arg num1
/// @arg num2
/// @arg interval
/// @arg isForward

//绘制分数（小数）
//返回值为绘制的宽度
var x0 = argument0;
var y0 = argument1;
var number1 = argument2 >= 0 ? argument2 : 0;
var number2 = argument3 >= 0 ? argument3 : 0;
var interval = argument4;
var isForward = argument5;

if(isForward){
	var w = sc_draw_number(x0,y0,number1,interval,isForward);
	draw_sprite(sp_slash,0,x0 + w,y0);
	var w2 = sc_draw_number(x0 + w + 12 + interval,y0,number2,interval,isForward);
}else {
	var w = sc_draw_number(x0,y0,number2,interval,isForward);
	draw_sprite(sp_slash,0,x0 - w - 12,y0);
	var w2 = sc_draw_number(x0 - w - 12 - interval,y0,number1,interval,isForward);
}

return w + w2 + 12;