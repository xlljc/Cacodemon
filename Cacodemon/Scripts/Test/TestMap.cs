using Godot;
using XiaoLi.Base;
using XiaoLi.Util;

public class TestMap : RoomBase
{

	[Export]
	public Vector2 CameraStartPos { get; set; }
	
	[Export]
	public Vector2 CameraEndPos { get; set; }
	
	protected override void Ready()
	{
		new Color("");
		RoomDate.SetCamera(CameraStartPos,CameraEndPos);
	}

	protected override void Process(float delta)
	{
		if (MyInput.KeyPressed("restart"))
		{
			GetTree().ChangeScene("res://Scenes/Test/Test01Map.tscn");
		}
	}

	protected override void PhysicsProcess(float delta)
	{
		
	}
}
