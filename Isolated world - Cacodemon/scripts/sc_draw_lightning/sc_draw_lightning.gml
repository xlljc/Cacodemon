//调用此函数将绘制一条从x0，y0到x1，y1的闪电
//请在draw事件里面调用

//初始x坐标
var x0 = argument0;
//初始y坐标
var y0 = argument1;
//目标x坐标
var x1 = argument2;
//目标y坐标
var y1 = argument3;

//储存循环中的上一次描点坐标
var x2 = x0,y2 = y0;
//储存两点距离
var tmplen = round(point_distance(x0,y0,x1,y1));
while(x0 != x1 || y0 != y1){
	var dir = round(point_direction(x2,y2,x1,y1));
	dir = irandom_range(dir - 45,dir + 45);
	var len = irandom_range(1,tmplen > 60 ? 50 : (round(tmplen / 3)));
	x0 += lengthdir_x(len,dir);
	y0 += lengthdir_y(len,dir);
	if(abs(x0 - x1) <= (tmplen > 60 ? 30 : (round(tmplen / 3))) && abs(y0 - y1) <= (tmplen > 60 ? 30 : (round(tmplen / 3)))){
		x0 = x1;
		y0 = y1;
	}
	draw_line_color(x0,y0,x2,y2,c_white,c_white);
	x2 = x0;
	y2 = y0;
}

