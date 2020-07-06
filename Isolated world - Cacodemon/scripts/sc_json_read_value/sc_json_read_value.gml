/// @param jsonFile
/// @param str1....str2....

//从json对象中读取值

var json = argument[0];

for(var i = 1;i < argument_count;i ++){
	var temp = argument[i];
	if(is_real(temp)){
		json = json[| argument[i]];
	}else {
		json = json[? argument[i]];
	}
}

return json;