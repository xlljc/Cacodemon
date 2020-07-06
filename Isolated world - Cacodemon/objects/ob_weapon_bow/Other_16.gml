/// @description 绘制ui事件

var num = 0;
//var numMax = 12;
if(weaponDrawUiIndex == 0){
	if(weaponBox1Var != undefined){
		num = weaponBox1Var[? "arrow"];
		//numMax = weaponBox1Var[? "arrowMax"];
	}
}else {
	if(weaponBox2Var != undefined){
		num = weaponBox2Var[? "arrow"];
		//numMax = weaponBox2Var[? "arrowMax"];
	}
}
sc_draw_number(1100,weaponDrawUiIndex ? 64 : 6,num,3,0);