/// @arg weaponType

//根据武器类型获取武器对象
if(argument0 == "none"){
	return ob_player;
}else {
	return asset_get_index("ob_weapon_" + argument0);
}