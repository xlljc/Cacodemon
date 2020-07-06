/// @arg enumType

//根据枚举类型获取字符串

var st = argument0;

if(st == plSt.atk || st == monsterSt.atk){
	return "atk";
}else if(st == plSt.hurt || st == monsterSt.hurt){
	return "hurt";
}else if(st == plSt.idle || st == monsterSt.idle){
	return "idle";
}else if(st == plSt.jumpFall || st == monsterSt.jumpFall){
	return "jumpFall";
}else if(st == plSt.jumpGround || st == monsterSt.jumpGround){
	return "jumpGround";
}else if(st == plSt.jumpUp || st == monsterSt.jumpUp){
	return "jumpUp";
}else if(st == plSt.run || st == monsterSt.run){
	return "run";
}else if(st == plSt.defense || st == monsterSt.defense){
	return "defense";
}else if(st == plSt.dead || st == monsterSt.dead){
	return "dead";
}

return "";