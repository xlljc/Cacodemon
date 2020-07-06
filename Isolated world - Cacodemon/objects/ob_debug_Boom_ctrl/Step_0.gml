/// @description 鼠标点击创建爆炸

//创建爆炸效果
if(mouse_check_button_pressed(mb_left)){
	instance_create_depth(mouse_x,mouse_y,depth,ob_debug_boom);
}