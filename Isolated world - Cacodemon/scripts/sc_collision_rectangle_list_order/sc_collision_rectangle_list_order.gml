/// @arg x1
/// @arg y1
/// @arg x2
/// @arg y2
/// @arg centerX
/// @arg centerY
/// @arg obj
/// @arg list
/// @arg isAsc
/// @arg onlyFirst

var x1 = argument0;
var y1 = argument1;
var x2 = argument2;
var y2 = argument3;
var centerX = argument4; //中心点坐标，物体将根据该坐标进行排序
var centerY = argument5;
var obj = argument6;
var list = argument7;
var isAsc = argument8; //是否为根据距离进行升序排序
var onlyFirst = argument9; //是否只有拿第一个值（如果你只需要拿结果的第一个值，那么就选true，这样效率会更高）


//YOYO官方自带的collision_rectangle_list函数排序功能有问题，在此重写


var num = collision_rectangle_list(x1,y1,x2,y2,obj,0,0,list,0);

var len = ds_list_size(list);
if(!onlyFirst){
	//冒泡排序法
	for(var i = 0;i < len - 1;i ++){
		for(var j = 0;j < len - i - 1;j ++){
			var tempJ1 = list[| j];
			var tempJ2 = list[| j + 1];
			if(isAsc){ //升序
				if(point_distance(centerX,centerY,tempJ1.x,tempJ1.y) > point_distance(centerX,centerY,tempJ2.x,tempJ2.y)){
					var temp = tempJ1;
					list[| j] = list[| j + 1];
					list[| j + 1] = temp;
				}
			}else {
				if(point_distance(centerX,centerY,tempJ1.x,tempJ1.y) < point_distance(centerX,centerY,tempJ2.x,tempJ2.y)){
					var temp = tempJ1;
					list[| j] = list[| j + 1];
					list[| j + 1] = temp;
				}
			}
		}
	}
}else {
	for(var j = 0;j < len - 1;j ++){
		var tempJ1 = list[| j];
		var tempJ2 = list[| j + 1];
		if(isAsc){ //升序
			if(point_distance(centerX,centerY,tempJ1.x,tempJ1.y) > point_distance(centerX,centerY,tempJ2.x,tempJ2.y)){
				var temp = tempJ1;
				list[| j] = list[| j + 1];
				list[| j + 1] = temp;
			}
		}else {
			if(point_distance(centerX,centerY,tempJ1.x,tempJ1.y) < point_distance(centerX,centerY,tempJ2.x,tempJ2.y)){
				var temp = tempJ1;
				list[| j] = list[| j + 1];
				list[| j + 1] = temp;
			}
		}
	}
}

return num;