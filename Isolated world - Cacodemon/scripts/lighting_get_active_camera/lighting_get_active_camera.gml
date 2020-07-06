/// @desc Gets the active camera
/// @returns The active camera port [X, Y, Width, Height]

if(global.worldCustomCamera == undefined) {
	// Get active view camera
	var camera_X = camera_get_view_x(view_camera[0]);
	var camera_Y = camera_get_view_y(view_camera[0]);
	return [camera_X, camera_Y, cameraWidth, cameraHeight];
}

return global.worldCustomCamera;