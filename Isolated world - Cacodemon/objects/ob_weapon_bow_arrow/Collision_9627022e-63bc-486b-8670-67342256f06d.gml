/// @description describe
phy_speed_x = 0;

if(isFly){
	//碰到墙会卡在墙上
	var num = irandom_range(0,8);
	physics_joint_revolute_create(id,other,x + (image_xscale ? 12 : -12),y,
							phy_rotation - num,phy_rotation + num,1,0,0,0,0);
}
isFly = 0;