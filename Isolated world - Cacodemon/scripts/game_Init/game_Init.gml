
gml_pragma("global", "game_Init()");

#region 全局变量

	//***************语言****************
	
	//游戏语言
	globalvar LanguageIndex;
	//游戏语言名称
	globalvar LanguageName;
	//文本储存路径
	globalvar LanguagePath;
	//游戏可供的语言（二维数组）
	globalvar Languages;
	
	//***************文本***************
	
	//系统文字提示
	globalvar JsonSystemText;
	//获取json文件的武器介绍
	globalvar JsonWeaponIntroduc;
	//设置游戏绘制字体
	globalvar SystemFont,SystemFontSize;

	//***************对话***************
	
	//游戏章节
	globalvar Chapters;
	//json对话内容
	globalvar JsonDialogue;
	//游戏对话场景
	globalvar Scenario;
	//对话id
	globalvar Dialogue;
	
	//*************按键映射*************
	
	globalvar key;
	
#endregion


#region 枚举
	
	//玩家状态
	//空闲，跑，攻击，跳（上），跳（下），跳（落地），受伤，防御，翻滚，死亡
	enum plSt{
		idle,run,atk,jumpUp,jumpFall,jumpGround,hurt,defense,roll,dead
	}
	//npc状态
	enum monsterSt{
		idle,run,atk,jumpUp,jumpFall,jumpGround,hurt,defense,roll,dead
	}
	//sc_compare函数枚举
	enum scCompare{
		//所有类型数据
		allEquals, //全部相等
		equals, //只要有一个相等
		allNotEquals, //全部不相等
		notEquals, //只要有一个不相等
		//仅限实数
		maxOther, //比其他都大
		minOther, //比其他都小
	}
#endregion



#region 读取用户设置

	//语言索引
	LanguageIndex= 1;
	//按键映射初始化
	key = ds_map_create();

	//如果不存在用户配置，就创建默认配置
	if(file_exists("userConfig.ini")){
		ini_open("userConfig.ini");
		//语言
		LanguageIndex = ini_read_real("language","language",LanguageIndex);
		//读取映射
		key[? "up"] = ini_read_real("keyMap","up",87);
		key[? "down"] = ini_read_real("keyMap","down",83);
		key[? "left"] = ini_read_real("keyMap","left",65);
		key[? "right"] = ini_read_real("keyMap","right",68);
		key[? "change"] = ini_read_real("keyMap","change",81);
		key[? "picUp"] = ini_read_real("keyMap","picUp",69);
		key[? "lost"] = ini_read_real("keyMap","lost",71);
		key[? "throw"] = ini_read_real("keyMap","throw",72);
		key[? "attack"] = ini_read_real("keyMap","attack",74);
		key[? "rolling"] = ini_read_real("keyMap","rolling",75);
	}else {
		ini_open("userConfig.ini");
		//默认中文
		ini_write_string("language","language",LanguageIndex);
		//按键映射
		key[? "up"] = 87;
		key[? "down"] = 83;
		key[? "left"] = 65;
		key[? "right"] = 68;
		key[? "change"] = 81;
		key[? "picUp"] = 69;
		key[? "lost"] = 71;
		key[? "throw"] = 72;
		key[? "attack"] = 74;
		key[? "rolling"] = 75;
		//写入映射
		ini_write_string("keyMap","up",key[? "up"]);
		ini_write_string("keyMap","down",key[? "down"]);
		ini_write_string("keyMap","left",key[? "left"]);
		ini_write_string("keyMap","right",key[? "right"]);
		ini_write_string("keyMap","change",key[? "change"]);
		ini_write_string("keyMap","picUp",key[? "picUp"]);
		ini_write_string("keyMap","lost",key[? "lost"]);
		ini_write_string("keyMap","throw",key[? "throw"]);
		ini_write_string("keyMap","attack",key[? "attack"]);
		ini_write_string("keyMap","rolling",key[? "rolling"]);
	}
	ini_close();

#endregion

//读取系统ini配置文件
ini_open("config.ini");

#region 游戏基本设置
	//设置窗体位置
	window_set_position(window_get_x(),40);
	//随机种子
	randomize();
	
#endregion

#region 游戏存档与对话

	//设置绘制字体
	var path = ini_read_string("font","path","fonts/simhei.ttf");
	SystemFontSize = ini_read_real("font","size",10);
	SystemFont = font_add(path,SystemFontSize,0,0,32,128);
	draw_set_font(SystemFont);

	//对话变量
	//章节
	Chapters = 1;
	//对话场景
	Scenario = "";
	//对话id
	Dialogue = "";
	
	
	//读取游戏存档

	//设置游戏章节（根据游戏存档）
	
	drawTime = 0;

	//读取游戏存档信息
	game_save1 = noone;		//存档1
	game_save2 = noone;		//存档2
	game_save3 = noone;		//存档3
	//sc_load_game_saves();
	
	
	//加载所有语言
	var index = 1;
	while(ini_key_exists("language","language" + string(index))){
		//加载名称
		Languages[index - 1,0] = ini_read_string("language","name" + string(index),"");
		//加载路径
		Languages[index - 1,1] = ini_read_string("language","path" + string(index),"");
		index ++;
	}
	//设置语言，并读取文本文件
	JsonDialogue = undefined;
	JsonSystemText = undefined;
	JsonWeaponIntroduc = undefined;
	sc_system_set_language(LanguageIndex);


#endregion


//关闭读取ini文件
ini_close();