/// @arg x
/// @arg y
/// @arg speed

var x0 = ceil(argument0);
var y0 = ceil(argument1);
var moveSpeed = argument2;

//该脚本将视野0项x0，y0移动，移动的速度为moveSpeed
//适合在过场动画时调用此脚本

if(cameraX == x0 && cameraY == y0){
	return;
}
//相隔距离
var tempNum1 = x0 - cameraX;
var tempNum2 = y0 - cameraY;

//计算移动距离
var mx = 0;
var my = 0;
if(abs(tempNum1) <= moveSpeed){
	mx = tempNum1;
}else {
	mx = tempNum1 ? moveSpeed : -moveSpeed;
}
if(abs(tempNum2) <= moveSpeed){
	my = tempNum2;
}else {
	my = tempNum2 ? moveSpeed : -moveSpeed;
}

//视野不能超出屏幕
if(cameraX + mx < 0){
	mx = -cameraX;
}else if(cameraX + mx + cameraWidth > room_width){
	mx = room_width - cameraWidth - cameraX;
}
if(cameraY + my < 0){
	my = -cameraY;
}else if(cameraY + my + cameraHeight > room_height){
	my = room_height - cameraHeight - cameraY;
}

//调用视野移动
sc_camera_moveValue(mx,my);