/// @param {real} obj1
/// @param {real} obj2

var obj1 = argument0;
var obj2 = argument1;

//返回对象1是否是对象2的子级或同级

if(obj1 == obj2){
	return 1;
}

var temp;

while(1){
	temp = object_get_parent(obj1);
	if(temp == obj2){
		return 1;
	}else if(!temp){
		return 0;
	}else {
		obj1 = temp;
	}
}