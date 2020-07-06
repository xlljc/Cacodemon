//游戏打开时读取游戏存档槽
//如果没有，就创建
var file;
file = file_text_open_write("game_save/save1/");
file_text_close(file);
file = file_text_open_write("game_save/save2/");
file_text_close(file);
file = file_text_open_write("game_save/save3/");
file_text_close(file);

if(file_exists("game_save/save1/index.data")){
	game_save1 = 1;
}
if(file_exists("game_save/save2/index.data")){
	game_save2 = 1;
}
if(file_exists("game_save/save3/index.data")){
	game_save3 = 1;
}