/// @description 

var monsterNum = instance_number(ob_biology_monster_f);
if(monsterNum){
	useTimer = (current_time - timeFlag) / 1000;
}

var str = "";
str += "fps_real= " + string(fps_real);
str += "\nfps= " + string(fps);
str += "\n敌人数量= " + string(monsterNum);
str += "\n火把数量= " + string(torche1Num);
str += "\n用时(秒)= " + string(useTimer);
//str += "\ncameraX= " + string(cameraX);
//str += "\ncameraY= " + string(cameraY);
//str += "\nplayerX= " + string(ob_player.x);
//str += "\nplayerY= " + string(ob_player.y);
//str += "\nmoveFlag= " + string(moveFlag);
draw_text(5,40,str);