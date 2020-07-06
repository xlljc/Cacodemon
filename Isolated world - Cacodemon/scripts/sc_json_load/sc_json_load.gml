/// @args fileName

//读取一个json文件，并返回json对象
var file = argument0;

var json = undefined;

if(!file_exists(file)){
	show_message("游戏重要文件丢失！\n" + file);
	game_end();
	return;
}

var fileId = file_text_open_read(file);
var jsonStr = "";

while (!file_text_eof(fileId)){
	jsonStr += file_text_readln(fileId);
}
file_text_close(fileId);

json = json_decode(jsonStr);

return json;