using Godot;
using XiaoLi.Util;

/// <summary>
/// 
/// </summary>
public class RickKatana : Rick
{
	
	protected override void RickReady()
	{
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
				if (_dirX != 0) //如果移动了
					oldState = State.Run;
				else if (_atk) //如果按下攻击
					oldState = State.Attack;
				else if (_jmp) //如果按下跳跃
					oldState = State.JumpUp;
				else if (Velocity.y > 0) //如果下落
					oldState = State.JumpFall;
				else if (_dirY == 1) //如果按了下键,变成防御状态
					oldState = State.Defense;
				break;
			case State.Run:
				if (_dirX == 0) //如果静止
					oldState = State.Idle;
				else if (_atk) //如果按下攻击
					oldState = State.Attack;
				else if (_jmp) //如果按下跳跃
					oldState = State.JumpUp;
				else if (Velocity.y > 0) //如果下落
					oldState = State.JumpFall;
				else if (_dirY == 1) //如果按了下键,变成防御状态
					oldState = State.Defense;
				break;
			case State.Attack:
				if (CanChangeState) //直到可以改变状态
					if (_dirX != 0) //如果移动
						oldState = State.Run;
					else if (_atk) //如果按下攻击
						oldState = State.Attack;
					else if (AnimFinished) //如果动画结束
						oldState = State.Idle;
				break;
			case State.JumpUp:
				if (Velocity.y > 0) //如果上升的速度小于0
					oldState = State.JumpFall;
				break;
			case State.JumpFall:
				if (IsOnFloor()) //如果落地
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
			case State.Defense:
				if (_dirY != 1) //如果停止按了下键,取消防御状态
					if (_dirX != 0) //如果移动了
						oldState = State.Run;
					else if (_jmp) //如果按下跳跃
						oldState = State.JumpUp;
					else if (_atk) //如果按下攻击
						oldState = State.Attack;
					else
						oldState = State.UnDefense; //默认播放取消防御动画
				break;
			case State.UnDefense:
				if (AnimFinished) //如果动画结束了
					oldState = State.Idle;
				else if (_dirX != 0) //如果移动了
					oldState = State.Run;
				else if (_jmp) //如果按下跳跃
					oldState = State.JumpUp;
				else if (_atk) //如果按下攻击
					oldState = State.Attack;
				break;
		}

		return oldState;
	}

	protected override string RickPlayAnimation(State oldState, State newState)
	{
		switch (newState)
		{
			case State.Idle:
				return "Idle2";
			case State.Run:
				return "Run";
			case State.Attack:
				//根据不同的键位触发的攻击动作不一样
				if (_dirY == -1) //如果按下向上键
					return "Attack" + MyMath.RandRange(2, 3);
				else
					return "Attack1";
			case State.JumpUp:
				return "JumpUp";
			case State.JumpFall:
				return "JumpFall";
			case State.Ground:
				return "Ground";
			case State.Defense:
				return "Defense";
			case State.UnDefense:
				return "UnDefense";
		}

		return null;
	}

	public override Vector2 Operation(float delta)
	{
		Vector2 velocity = Vector2.Zero;
		//根据不同的状态进行运动
		switch (State)
		{
			case State.Idle:
				FaceTo(_dirX);
				break;
			case State.Run:
				velocity = Vector2.Right * _dirX;
				FaceTo(_dirX);
				break;
			case State.Attack:

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
			case State.Defense:
				FaceTo(_dirX);
				break;
			case State.UnDefense:

				break;
		}

		return velocity;
	}
}
