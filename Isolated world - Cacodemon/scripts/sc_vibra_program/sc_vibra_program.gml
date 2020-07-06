
//相机抖动执行

//获取相机坐标和宽高
var cx = camera_get_view_x(view_camera[0]);
var cy = camera_get_view_y(view_camera[0]);
	

if(vibraFlag){
	if(cx == vibraX && cy == vibraY){	//准备刷新移动长度，并重新计算目标移动位置
		vibraFlag = false;
	}else {
		//如果与目标坐标不同，就移动
		if(cx > vibraX){
			cx -= ceil(abs(vibraX - cx) / 4);
		}else if(cx < vibraX){
			cx += ceil(abs(vibraX - cx) / 4);
		}
		if(cy > vibraY){
			cy -= ceil(abs(vibraY - cy) / 4);
		}else if(cy < vibraY){
			cy += ceil(abs(vibraY - cy) / 4);
		}
		//设置相机坐标
		camera_set_view_pos(view_camera[0],cx,cy);
	}
}
if(!vibraFlag){	//刷新移动长度，并计算目标移动位置
	var tempNumX = cx - cameraX;
	var tempNumY = cy - cameraY;
	if(tempNumX != 0 || tempNumY != 0){
		//计算新的坐标
		vibraX = cameraX - (tempNumX > 0 ? floor(tempNumX / 2) : ceil(tempNumX / 2));
		vibraY = cameraY - (tempNumY > 0 ? floor(tempNumY / 2) : ceil(tempNumY / 2));
		if(abs(vibraX - cameraX) <= 1){
			vibraX = cameraX;
		}
		if(abs(vibraY - cameraY) <= 1){
			vibraY = cameraY;
		}
		vibraFlag = true;
	}
}