/// @arg x
/// @arg y
/// @arg str
/// @arg drawSpeed
/// @arg lineHeight
/// @arg width
/// @arg scale
/// @arg color

//调用此函数会在x0，y0处开始绘制文本str
//速度为drawSpeed，drawSpeed越大绘制速度越慢，一般为3(参数越大绘制越慢)
//h为绘制行高，w为绘制行宽(像素)
//scale为绘制缩放比例
//color为绘制颜色
//函数返回值为是否绘制完成
//请在draw事件里面调用
//必须在create事件添加drawTime

var x0 = argument0;
var y0 = argument1;
var str = argument2 + " ";
var drawSpeed = argument3;
var h = argument4;
var w = argument5;
var scale = argument6;
var color = argument7;

drawTime++;
var bol = 0;
//绘制字符串的长度
var tmp = floor(drawTime/drawSpeed);
//如果超出范围就返回绘制完成
if(tmp > string_length(str)){
	tmp = string_length(str);
	bol = 1;
}
//123456
//绘制文字，超出范围就换行
var index = 1,lin = 0;
for(var i = 1; i <= tmp; ++i) {
	if(string_width(string_copy(str,index,i - index + 1)) * scale > w || i == tmp){
		var str_temp = string_copy(str,index,i - index);
		draw_text_transformed_color(x0,y0 + lin * h,str_temp,scale,scale,0,color,color,color,color,1);
		index = i;
		lin ++;
	}
}
return bol;