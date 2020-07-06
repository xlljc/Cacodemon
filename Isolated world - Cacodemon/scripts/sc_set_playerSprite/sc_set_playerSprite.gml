/// @arg weaponName

//根据武器名设置玩家动画名称
with(ob_player){
	sprite_index = asset_get_index("sp_player_" + argument0);
	skeleton_animation_set_ext(spIdle,0);
}