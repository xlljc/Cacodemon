//是否按下过
//isCheck = 0;
//是否开始销毁
//destroyStart = 0;


if(!destroyStart){
	with(ob_menu_button_f){
		destroyStart = 1;
		image_speed = 1;
		if(other.id == self.id){
			isCheck = 1;
		}
	}
}