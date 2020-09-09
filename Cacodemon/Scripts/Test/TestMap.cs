using Godot;
using XiaoLi.Base;
using XiaoLi.Util;

public class TestMap : RoomBase
{

	protected override void Ready()
	{
		RoomDate.SetCamera(Vector2.Zero, new Vector2(800,225));
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
