/// @arg x
/// @arg y
/// @arg moveType
/// @arg speed

//相机需要移动时调用该脚本
//该脚本会自动计算移动的位置
//参数为需要移动到的位置
//type为移动的类型：
//				0：距离越远移动速度越快
//				1：恒定速度移动，速度为speed
//				2：瞬移

var tempNum = floor(cameraY + cameraHeight / 2);
var x0 = floor(argument0);
var y0 = floor(argument1);
if(y0 > tempNum + 200 || y0 < tempNum || moveFlag){	//Y轴超出范围
	if(!moveFlag && (y0 > tempNum + 200)){
		moveFlag = 1;
	}else if(moveFlag && y0 == tempNum){
		moveFlag = 0;
	}
	if(argument2 == 0){
		sc_camera_move_position_proportion(x0 - cameraWidth / 2 ,y0 - cameraHeight / 2,argument3);
	}else if(argument2 == 1){
		sc_camera_move_position_equidistance(x0 - cameraWidth / 2 ,y0 - cameraHeight / 2,argument3);
	}else {
		sc_camera_move_position_instant(x0 - cameraWidth / 2 ,y0 - cameraHeight / 2);
	}
}else if(!moveFlag){	//未超出范围
	if(argument2 == 0){
		sc_camera_move_position_proportion(x0 - cameraWidth / 2 ,cameraY,argument3);
	}else if(argument2 == 1){
		sc_camera_move_position_equidistance(x0 - cameraWidth / 2 ,cameraY,argument3);
	}else {
		sc_camera_move_position_instant(x0 - cameraWidth / 2 ,cameraY);
	}
}else {
	moveFlag = 0;
}