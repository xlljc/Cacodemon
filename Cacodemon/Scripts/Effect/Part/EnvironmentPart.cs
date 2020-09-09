using  Godot;

/// <summary>
/// 环境粒子节点
/// 跟随相机移动的
/// </summary>
public class EnvironmentPart : CPUParticles2D
{
    /// <summary>
    /// 房间主相机
    /// </summary>
    private Camera2D _camera2D;

    public override void _Ready()
    {
        _camera2D = GetTree().CurrentScene.GetNodeOrNull<Camera2D>("RoomDate/Camera");
        
        Emitting = true;
    }

    public override void _Process(float delta)
    {
        //跟随房间主相机移动
        if (_camera2D != null)
        {
            Position = _camera2D.GetCameraScreenCenter();
        }
    }
}