//判断鼠标是否按下，如果按下就替换鼠标贴图

if(isPause){
	if(mouse_check_button(mb_left)){
		cursor_sprite = sp_mouse_image_check;
	}else {
		//设置游戏鼠标指针
		cursor_sprite = sp_mouse_image;
	}
}else {//在非暂停状态下
	
	//相机抖动
	sc_vibra_program();
	//相机移动
	if(cameraObj){
		sc_camera_move(cameraObj.x,cameraObj.y,0,1);
	}
}