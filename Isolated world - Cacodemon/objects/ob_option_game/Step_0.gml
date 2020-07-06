if(isCheck && image_index >= 20){
	//创建返回按钮
	instance_create_depth(608,576,depth,ob_back_menu);
}
if(destroyStart && image_index >= 20){
	instance_destroy();
}