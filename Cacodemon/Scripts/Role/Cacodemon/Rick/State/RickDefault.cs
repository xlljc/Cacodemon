using Godot;
using XiaoLi.Util;
using static Godot.GD;

/// <summary>
/// 
/// </summary>
public class RickDefault : Rick
{
	
	protected override void RickReady()
	{
		Print("加载完成!");
	}
	
	protected override void Process(float delta)
	{
		
	}

	protected override void PhysicsProcess(float delta)
	{
		
	}

	
	protected override State RickListeningState(State oldState)
	{
		switch (oldState)
		{
			case State.Idle:
				if (_dirX != 0) //如果移动
					oldState = MyInput.KeyPressed("shift") ? State.Run : State.Walk;
				else if (_jmp) //如果按下跳跃
					oldState = State.JumpUp;
				else if (Velocity.y > 0) //如果下落
					oldState = State.JumpFall;
				break;
			case State.Walk:
				if (_dirX == 0) //如果静止
					oldState = State.Idle;
				else if (MyInput.Key("shift") == 1)
					oldState = State.Run;
				else if (_jmp) //如果按下跳跃
					oldState = State.JumpUp;
				else if (Velocity.y > 0) //如果下落
					oldState = State.JumpFall;
				break;
			case State.Run:
				if (_dirX == 0) //如果静止
					oldState = State.Idle;
				else if (MyInput.Key("shift") == 0)
					oldState = State.Walk;
				else if (_jmp) //如果按下跳跃
					oldState = State.JumpUp;
				else if (Velocity.y > 0) //如果下落
					oldState = State.JumpFall;
				break;
			case State.JumpUp:
				if (Velocity.y > 0) //如果上升的速度小于0
					oldState = State.JumpFall;
				break;
			case State.JumpFall:
				if (CanClimb) //如果下落可以抓到墙
					oldState = State.Climb;
				else if (IsOnFloor()) //如果落地
					if (_dirX != 0)
						oldState = State.Run;
					else
						oldState = State.Ground;
				break;
			case State.Ground:
				if (AnimFinished) //如果动画结束
					oldState = State.Idle;
				else if (_dirX != 0) //如果移动
					oldState = State.Run;
				break;
			case State.Climb:
				if (AnimFinished) //如果动画结束
					oldState = State.Idle;
				break;
		}
		return oldState;
	}

	protected override string RickPlayAnimation(State oldState, State newState)
	{
		return newState.ToString();
	}
	
	public override Vector2 Operation(float delta)
	{
		Vector2 velocity = Vector2.Zero;
		switch (State)
		{
			case State.Idle:
				FaceTo(_dirX);
				break;
			case State.Walk:
				MoveSpeed = 45;
				velocity = Vector2.Right * _dirX;
				FaceTo(_dirX);
				break;
			case State.Run:
				MoveSpeed = 120;
				velocity = Vector2.Right * _dirX;
				FaceTo(_dirX);
				break;
			case State.JumpUp:
				FaceTo(_dirX);
				velocity = Vector2.Right * _dirX;
				if (_jmp) //如果触发跳跃
					velocity.y = -1;
				break;
			case State.JumpFall:
				FaceTo(_dirX);
				velocity = Vector2.Right * _dirX;
				break;
			case State.Ground:
				
				break;
			case State.Climb:

				break;
		}
		return velocity;
	}


	
}
