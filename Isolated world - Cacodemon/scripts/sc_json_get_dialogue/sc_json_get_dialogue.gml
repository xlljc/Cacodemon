/// @arg content
/// @arg flag

var argContent = argument0;
var flag = argument1;

//设置对的到达的位置，然后给，global.name[drawIndex]，global.str[drawIndex]，设置属性
//flag表示是否返回单一的值

var scenarioTemp = JsonDialogue[? Scenario];
var dialogueTemp = scenarioTemp[? Dialogue];
var contentTemp = dialogueTemp[? argContent];

if(!flag){
	var roleList = contentTemp[? "role"];
	var textList = contentTemp[? "text"];
	var roleListSize = ds_list_size(roleList);
	var textListSize = ds_list_size(textList);
	if(roleListSize != textListSize){
		show_message("游戏数据文件损坏！");
		game_end();
		return;
	}
	//替换指定名称
	/*for (var i = 0; i < roleListSize; ++i) {
	    if(roleList[| i] == "playerName"){
			roleList[| i] = ob_player.name;
		}
	}*/
	
	//global.name = roleList;
	//global.str = textList;
}else {
	return contentTemp;
}