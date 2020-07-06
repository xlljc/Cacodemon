/// @param keyTyep
/// @param key

//设置按键映射
ini_open("userConfig.ini");

key[? argument0] = argument1;
ini_write_string("keyMap",argument0,argument1);

ini_close();