/// @arg x
/// @arg y
/// @arg speed

//相机要移动到的位置
var x0 = ceil(argument0);
var y0 = ceil(argument1);
var moveSpeed = 10 / argument2;

//该脚本将视野0项x0，y0移动，距离越远移动速度越快
//适合在移动时调用此脚本

if(cameraX == x0 && cameraY == y0){
	return;
}
//相隔距离
var tempNum1 = x0 - cameraX;
var tempNum2 = y0 - cameraY;

//计算移动距离
var mx = tempNum1 > 0 ? ceil(tempNum1 / moveSpeed) : floor(tempNum1 / moveSpeed);
var my = tempNum2 > 0 ? ceil(tempNum2 / moveSpeed) : floor(tempNum2 / moveSpeed);

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