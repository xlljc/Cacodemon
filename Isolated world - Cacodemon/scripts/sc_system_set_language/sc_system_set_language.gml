/// @param languageIndex

//设置系统语言，根据语言索引
//重新加载文本

//如果之前存在保存的语言，就删除
if(JsonSystemText != undefined){
	ds_map_destroy(JsonSystemText);
}
if(JsonWeaponIntroduc != undefined){
	ds_map_destroy(JsonWeaponIntroduc);
}

LanguageName = Languages[argument0 - 1,0];
LanguagePath = Languages[argument0 - 1,1];

//系统文字提示
JsonSystemText = sc_json_load(LanguagePath + "/system/systemText.json");
//获取json文件的武器介绍
JsonWeaponIntroduc = sc_json_load(LanguagePath + "/introduce/WeaponIntroduc.json");

//对话文件
//JsonDialogue = sc_json_load(working_directory + "\translations\\" + "rpg_chapter_" + string(Chapters) + ".json");

