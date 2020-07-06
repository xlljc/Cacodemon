/// @description describe

//window_set_fullscreen(true);
var str = "";
str += "AD移动 , W跳跃 , S防御 , J攻击 , K翻滚";
str += "\nQ切换武器 , E拾起武器 , G扔下武器 , H抛出武器(会造成伤害)";
str += "\n按5回血 , 虽然玩家不会死亡2333";
str += "\n按P重启游戏"
show_message(str);


#region 相机变量
	//屏幕抖动位置记录
	globalvar vibraX,vibraY,vibraFlag,cameraX,cameraY,cameraWidth,cameraHeight,cameraObj;
	//相机绑定的物体
	cameraObj = ob_player;
	//相机宽高
	cameraWidth = camera_get_view_width(view_camera[0]);
	cameraHeight = camera_get_view_height(view_camera[0]);
	//相机实际坐标
	cameraX = 0;
	cameraY = 0;
	//到某个位置（抖动时目标位置）
	vibraX = cameraX;
	vibraY = cameraY;
	vibraFlag = false;	//是否执行
	//是否需要移动
	moveFlag = 0;
	//初始化相机坐标
	sc_camera_move(cameraObj.x,cameraObj.y,2,0);
#endregion

//游戏是否暂停
globalvar isPause;
isPause = 0;

#region 初始化光照对象
	//初始化Init照明
	instance_create_depth(-100,-100,0,obj_lighting_init);
	//创建渲染层
	var layId = layer_create(-100,"lay_light_renderer");
	//初始化渲染器
	instance_create_layer(-100,-100,layId,obj_light_renderer);
	//房间光照强度(0.5)
	global.ambientShadowIntensity = 0.6;
	//instance_deactivate_object(obj_light_renderer);
#endregion

#region 粒子系统
	//创建粒子层
	globalvar partSystem_prospect,partSystem_background;
	partSystem_prospect = part_system_create();
	partSystem_background = part_system_create();
	part_system_depth(partSystem_prospect,-90);
	part_system_depth(partSystem_background,10);
#endregion