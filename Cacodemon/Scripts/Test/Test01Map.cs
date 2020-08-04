using Godot;
using XiaoLi.Base;
using XiaoLi.Util;

public class Test01Map : RoomBase
{

	protected override void Ready()
	{
		
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
