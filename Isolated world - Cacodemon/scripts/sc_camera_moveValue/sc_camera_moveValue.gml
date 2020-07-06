/// @arg X_offset
/// @arg Y_offset

var X_offset = argument0;
var Y_offset = argument1;

//相机运动代码（参数为相机运动的量，并非位置）

vibraX += X_offset;
vibraY += Y_offset;
cameraX += X_offset;
cameraY += Y_offset;
//视野坐标
var cx = camera_get_view_x(view_camera[0]) + X_offset;
var cy = camera_get_view_y(view_camera[0]) + Y_offset;

camera_set_view_pos(view_camera[0],cx,cy);