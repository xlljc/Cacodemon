/// @arg type
/// @arg variable
/// @arg value1.value2....

var type = argument[0];
var variable = argument[1];

//比较函数
if(type == scCompare.allEquals){ //全部相同
	for (var i = 2; i < argument_count; ++i) {
	    if(variable != argument[i]){
			return 0;
		}
	}
}else if(type == scCompare.allNotEquals){ //全部不相同
	for (var i = 2; i < argument_count; ++i) {
	    if(variable == argument[i]){
			return 0;
		}
	}
}else if(type == scCompare.equals){ //只要有一个相同
	for (var i = 2; i < argument_count; ++i) {
	    if(variable == argument[i]){
			return 1;
		}
	}
	return 0;
}else if(type == scCompare.notEquals){ //只要有一个不同
	for (var i = 2; i < argument_count; ++i) {
	    if(variable != argument[i]){
			return 1;
		}
	}
	return 0;
}else if(type == scCompare.maxOther){ //比其他都大
	for (var i = 2; i < argument_count; ++i) {
	    if(variable <= argument[i]){
			return 0;
		}
	}
}else if(type == scCompare.maxOther){ //比其他都小
	for (var i = 2; i < argument_count; ++i) {
	    if(variable >= argument[i]){
			return 0;
		}
	}
}

return 1;