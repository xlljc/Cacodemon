if(isCheck && image_index >= 20){
	//创建主菜单按钮
	instance_create_depth(608,384,depth,ob_start_new_game);
	instance_create_depth(608,448,depth,ob_start_load_game);
	instance_create_depth(608,512,depth,ob_option_game);
	instance_create_depth(608,576,depth,ob_exit_game);
	//删除选项
	instance_destroy(ob_game_archive);
}
if(destroyStart && image_index >= 20){
	instance_destroy();
}
