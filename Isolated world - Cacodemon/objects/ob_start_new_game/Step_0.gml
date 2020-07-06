if(isCheck && image_index >= 20){
	//创建返回按钮
	instance_create_depth(608,576,depth,ob_back_menu);
	//创建3个存档槽
	instance_create_depth(x - 200,400,depth,ob_game_archive);
	instance_create_depth(x,400,depth,ob_game_archive);
	instance_create_depth(x + 200,400,depth,ob_game_archive);
}
if(destroyStart && image_index >= 20){
	instance_destroy();
}