/// @param arr

//将一个二维数组的所有元素拼接成一个字符串

var str,len1d,len2d;
str = "";
len1d = array_length_1d(argument0);
len2d = array_length_2d(argument0,0);

for (var i = 0; i < len1d; ++i) {
    for (var j = 0; j < len2d; ++j) {
	    str += string(argument0[i,j]) + "\t";
	}
	str += "\n";
}
return str;