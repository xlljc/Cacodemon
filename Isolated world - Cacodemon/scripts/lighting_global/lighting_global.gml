//
//	全局，枚举和宏为这个照明引擎
//	必须调用这个脚本来初始化引擎
//

// 避免多次调用此脚本
if(__LIGHTING_ERROR_CHECKS) {
	if(variable_global_exists("lighting_global_initialised")) {
		show_debug_message("lighting_global(): lighting already initialised");
		return;
	}
	global.lighting_global_initialised = true;
}

//	#####################################
//
//	系统配置-调整以适应你的游戏
//	在调用lighting_global()后将它们分配到其他地方
//	这就保证了照明系统只需更换文件就可以升级
//
//	#####################################

// 周围的影子级别
global.ambientShadowIntensity = 0.85;

//阴影施法者的碰撞蒙版是否被用来剔除光照(真)或不(假)
//无论如何，一个多边形必须被分配给阴影施法者，这只是为了有效的剔除
//如果是这样，culling将使用R-tree算法
global.shadowCastersCullByCollisionMask = true;

//允许唯一的光影映射表面的最大尺寸
//如果超过这个范围，灯光将使用全球灯光阴影地图
//不投射阴影的灯光将特别受益于此
//这不适用于区域灯
global.lightMaxUniqueShadowMapSize = 1024;

//灯光更新之间帧的延迟
//你可以用lighting_set_dirty(true)来强制照明系统更新
global.lightUpdateFrameDelay = 1;

//将此设置为true以调试影子脚轮
//这将绘制所有的多边形
global.debugShadowCasters = false;

//默认扩展模块在创建时给灯光
//可以在创建任何灯光(或在其他任何时间)之前进行修改
global.lightDefaultExtensions = [
	light_create_extension(ext_light_attenuation_apply, ext_light_attenuation_reset)
];

// 初始化默认扩展模块
// 这些在着色器中被支持，所以即使扩展没有被使用，它们也必须被执行
ext_light_attenuation_init();

//	#####################################
//
//		端系统配置
//
//	#####################################

//
//	只读数据
//

//每帧重建的灯光数量
global.worldRebuiltLights = 0;

//被灯光影响的阴影施法者的数量
//这将计算每一个影响它的光的阴影施法者一次
//这还不包括经过优化的阴影脚轮，
//即使它们在全球阴影地图上明显受到影响
global.worldActiveShadowCasters = 0;

//
//	宏
//

//宏执行各种错误检查，可以通过改变值(真/假)来打开/关闭
#macro __LIGHTING_ERROR_CHECKS false

//从光源到阴影施法者沿跟踪线移动的步长
#macro __LIGHT_LINE_SHADOW_CASTER_STEP 0.01

//阴影的默认顶点，这是灯光和阴影脚轮的默认顶点
//实际阴影投射为min(光阴影长度，阴影投射者阴影长度)
#macro __WORLD_DEFAULT_SHADOW_FAR_VERTEX 32000

//着色器用来将每个光混合到世界阴影地图上
#macro __LIGHT_SHADER sh_blend_light

//用于绘制世界阴影地图的着色器
#macro __WORLD_SHADOW_MAP_SHADER sh_shadow_map

//负责渲染照明系统的物体
#macro __LIGHT_RENDERER obj_light_renderer

//
//	枚举
//

//灯光的种类
enum eLightType {
	Point,			//这种光有一个全方位的点发射器
	Spot,			//这种灯有一个锥形的点发射器
	Area,			//这种灯有一个单向的直线发射器
	Directional,	//这是一个没有发射源的无限光
	Line,			//这个灯有一个双向的线发射器(一个“双面区域灯”)
}

//一片光明
enum eLight {
	// Public
	X,				//灯光的X位置
	Y,				//灯光的Y位置
	//Z,				// The Z position of the light (see feature wishlist)
						// 灯光的Z位置(见功能愿望列表)
	Color,			//光的阴影的颜色
	Intensity,		//光的强度
	Range,			//光线的范围
	Type,			//此灯的类型(默认为eLightType.Point)
	Flags,			//这盏灯的旗
	
	//临时修改，因为没有Z轴
	ShadowLength,	//从这道光投射出的阴影的长度
	
	// LUTs
	LutIntensity,	//查找纹理(LUT)用于光的强度梯度(纹理;而不是sprite或surface)
	
	//聚光灯
	Angle,			//聚光灯的圆锥角度
	
	//聚光灯，区域灯，方向灯
	Direction,
	
	//区域照明
	Width,			//区域灯的宽度
	
	//扩展模块
	//光不知道这意味着什么，所以这是一个很好的和安全的方法来扩展光的能力，以确保这个资产仍然可以
	//简单地替换文件即可升级(大部分;你可能会为你的扩展添加着色器支持)
	//例如，默认的光衰减是一个扩展模块
	ExtensionModules,
	
	//游戏功能
	IgnoreSet,		//一组应该被忽略的阴影脚轮
	
	//内部
	VertexBuffer,
	ShadowMap,					//这个光的阴影映射表面，如果它有一个唯一的阴影映射
	StaticStorage,				//静态存储来保存静态阴影脚轮的信息，以避免重建它们
	ShadowCastersOutOfRange,	//一组静态的阴影脚轮，已知是超出这个范围的光;只适用于静态阴影脚轮
	CulledShadowCasters,		//一组阴影施法者因为不影响全球阴影地图而被从这束光中剔除;对着镜头，而不是灯光
	ActiveCamera,				//相机此灯最后更新为，这是相机阵列[X, Y，宽度，高度]
	
	//光字段的数量(这必须是最后一个enum字段)
	//这使得处理包含此信息的数组更加容易
	Count
}

//光旗帜
enum eLightFlags {
	//没有设置标志
	None = 0,
	
	//这盏灯脏了;这使得它更新所有的静态阴影脚轮
	//应该在光的位置或范围发生变化时进行设置
	Dirty = 1 << 0,
	
	//这盏灯的影子投射在阴影脚轮上
	//这是默认设置，但可以取消
	//注意:如果没有阴影，使用uniqueshadowmap，灯光可能会优化
	//		如果不脏就不要重画。这意味着改变光的租户属性(如强度或颜色)
	//		那不投射的影子也应该会弄脏光。您需要手动清除它，以确保它可以重新绘制。
	//DR:如果您删除了这个标记，那么当您更改一个仅限租用者的属性时，总是会弄脏灯光
	CastsShadows = 1 << 1,
	
	//内部
	//这盏灯有独特的阴影地图吗?这个不能设置-它是由系统决定的
	UsesUniqueShadowMap = 1 << 2,
}

//暗影施法者旗帜
enum eShadowCasterFlags {
	//没有设置标志
	None = 0,
	
	//这个阴影施法者是静态的;如果这个标志没有设置，阴影施法者是可移动的
	//一个静态的阴影施法者可以被光源缓存，因此比一个移动的阴影施法者更快
	//如果你的阴影施法者从来没有改变过他的多边形，那么把它标记为静态
	Static = 1 << 0,
	
	//这个影子施法者很脏;这适用于静态标志，并将使灯光重建这个阴影施法者
	Dirty = 1 << 1,
	
	//内部;不要使用
	//这将把一个阴影施法者标记为在闪电通过后等待“清理”(未清除)
	MarkedForCleanup = 1 << 2,
}

// Enum，它描述了一个光扩展模块
//所有脚本都接受当前的参数0
enum eLightExtension {
	Apply,		//将扩展应用到灯光的脚本
	Reset,		//在将扩展应用到一个灯光后被调用来清理的脚本
	
	//扩展模块字段的数量(这必须是最后一个enum字段)
	//这使得处理包含此信息的数组更加容易
	Count
}

//保留光扩展模块名的枚举
//我保留了8个扩展名，以备将来使用……不要使用这些数字中的任何一个作为自定义扩展名!
enum eLightReservedExtensionNames {
	Attenuation = 0,
	Reserved2, Reserved3,
	Reserved4, Reserved5,
	Reserved6, Reserved7,
	Reserved8
}

//所有shadow_map_ensure_exists的阴影映射的枚举
enum eShadowMap {
	Light,		//一张光影地图
	Global,		//全球阴影地图
	Snapshot	//快照阴影地图
}

//从lighting_get_active_camera获取相机属性[X, Y，宽度，高度]的枚举
enum eLightingCamera {
	X,
	Y,
	Width,
	Height
}

//多边形数组中的字段
//在一个多边形数组中访问它们:polygon[epolygone . length]
enum ePolygon {
	Length,			//多边形的长度（以点数计）
	
	//多边形字段的数量(必须是最后一个enum字段)
	//这使得处理包含此信息的数组更加容易
	Count
}

//顶点上的字段
enum eVertex {
	X,				//这个顶点的X坐标
	Y,				//这个顶点的Y坐标
	
	//多边形字段的数量(必须是最后一个enum字段)
	//这使得处理包含此信息的数组更加容易
	Count
}

//三角形方向enum
enum eTriDirection {
	Clockwise,
	CounterClockwise
}

//
//	系统变量
//

//光照顶点格式
						   vertex_format_begin();
						   vertex_format_add_position(); //首先我们写一个位置(X,Y)
						   vertex_format_add_color();	 //然后我们写一个颜色
global.lightVertexFormat = vertex_format_end();

//表面是合成的阴影贴图
//游戏世界的所有灯光都融合在这张地图上
global.worldShadowMap = undefined;
//表面是用来绘制光的阴影映射到，如果它没有自己的
global.lightShadowMap = undefined;

//将被合成到全球阴影地图的灯光阵列
global.worldLights = ds_list_create();

//一份肮脏的阴影脚轮清单，应该在灯光通过后“清洗”
global.worldDirtyShadowCasters = ds_list_create();

// R-tree算法剔除阴影脚轮时使用的重用列表
global.worldCulledShadowCastersRTree = ds_list_create();

//如果有的话，可以使用自定义相机[X, Y，宽度，高度]
//如果未定义，则使用活动视图摄像机
//用lighting_update_camera设置它
global.worldCustomCamera = undefined;

//重用顶点数组
global.lightVertexArrayMap = ds_map_create();

//重用4分量浮点数组来描述一种颜色
global.tmp_ColorArray = array_create(4);

//
//	材质的制服
//

//环境阴影的颜色和强度;
//设置为global.ambientShadowIntensity
global.u_AmbientShadow = shader_get_uniform(__WORLD_SHADOW_MAP_SHADER, "u_AmbientShadow");

//光强LUT
global.u_LutIntensity = shader_get_sampler_index(__LIGHT_SHADER, "u_LutIntensity");

// Texel尺寸统一
global.u_TexelSize = shader_get_uniform(__LIGHT_SHADER, "u_TexelSize");
global.u_TexelSize_ShadowMap = shader_get_uniform(__WORLD_SHADOW_MAP_SHADER, "u_TexelSize");

//光属性的制服
global.u_LightPosition = shader_get_uniform(__LIGHT_SHADER, "u_LightPosition");
global.u_LightColor = shader_get_uniform(__LIGHT_SHADER, "u_LightColor");
global.u_LightRange = shader_get_uniform(__LIGHT_SHADER, "u_LightRange");
global.u_LightIntensity = shader_get_uniform(__LIGHT_SHADER, "u_LightIntensity");
global.u_LightAngle = shader_get_uniform(__LIGHT_SHADER, "u_LightAngle");
global.u_LightDirection = shader_get_uniform(__LIGHT_SHADER, "u_LightDirection");
global.u_LightWidth = shader_get_uniform(__LIGHT_SHADER, "u_LightWidth");
global.u_LightType = shader_get_uniform(__LIGHT_SHADER, "u_LightType");

//特定区域灯光
global.u_LineEmitterPoint1 = shader_get_uniform(__LIGHT_SHADER, "u_LineEmitterPoint1");
global.u_LineEmitterPoint2 = shader_get_uniform(__LIGHT_SHADER, "u_LineEmitterPoint2");