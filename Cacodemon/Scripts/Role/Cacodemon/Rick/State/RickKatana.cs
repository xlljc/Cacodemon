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

	protected override Sta RickListeningState(Sta oldState)
	{
		switch (oldState)
		{
			case Sta.Idle:
				if (_dirX != 0) //如果移动了
					oldState = Sta.Run;
				else if (_atk) //如果按下攻击
					oldState = Sta.Attack;
				else if (_jmp) //如果按下跳跃
					oldState = Sta.JumpUp;
				else if (Velocity.y > 0) //如果下落
					oldState = Sta.JumpFall;
				else if (_dirY == 1) //如果按了下键,变成防御状态
					oldState = Sta.Defense;
				break;
			case Sta.Run:
				if (_dirX == 0) //如果静止
					oldState = Sta.Idle;
				else if (_atk) //如果按下攻击
					oldState = Sta.Attack;
				else if (_jmp) //如果按下跳跃
					oldState = Sta.JumpUp;
				else if (Velocity.y > 0) //如果下落
					oldState = Sta.JumpFall;
				else if (_dirY == 1) //如果按了下键,变成防御状态
					oldState = Sta.Defense;
				break;
			case Sta.Attack:
				if (CanChangeState) //直到可以改变状态
					if (_dirX != 0) //如果移动
						oldState = Sta.Run;
					else if (_atk) //如果按下攻击
						oldState = Sta.Attack;
					else if (AnimFinished) //如果动画结束
						oldState = Sta.Idle;
				break;
			case Sta.JumpUp:
				if (Velocity.y > 0) //如果上升的速度小于0
					oldState = Sta.JumpFall;
				break;
			case Sta.JumpFall:
				if (IsOnFloor()) //如果落地
					if (_dirX != 0)
						oldState = Sta.Run;
					else
						oldState = Sta.Ground;
				break;
			case Sta.Ground:
				if (AnimFinished) //如果动画结束
					oldState = Sta.Idle;
				else if (_dirX != 0) //如果移动
					oldState = Sta.Run;
				break;
			case Sta.Defense:
				if (_dirY != 1) //如果停止按了下键,取消防御状态
					if (_dirX != 0) //如果移动了
						oldState = Sta.Run;
					else if (_jmp) //如果按下跳跃
						oldState = Sta.JumpUp;
					else if (_atk) //如果按下攻击
						oldState = Sta.Attack;
					else
						oldState = Sta.UnDefense; //默认播放取消防御动画
				break;
			case Sta.UnDefense:
				if (AnimFinished) //如果动画结束了
					oldState = Sta.Idle;
				else if (_dirX != 0) //如果移动了
					oldState = Sta.Run;
				else if (_jmp) //如果按下跳跃
					oldState = Sta.JumpUp;
				else if (_atk) //如果按下攻击
					oldState = Sta.Attack;
				break;
		}

		return oldState;
	}

	protected override string RickPlayAnimation(Sta oldState, Sta newState)
	{
		switch (newState)
		{
			case Sta.Idle:
				return "Idle2";
			case Sta.Run:
				return "Run";
			case Sta.Attack:
				//根据不同的键位触发的攻击动作不一样
				if (_dirY == -1) //如果按下向上键
					return "Attack" + MyMath.RandRange(2, 3);
				else
					return "Attack1";
			case Sta.JumpUp:
				return "JumpUp";
			case Sta.JumpFall:
				return "JumpFall";
			case Sta.Ground:
				return "Ground";
			case Sta.Defense:
				return "Defense";
			case Sta.UnDefense:
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
			case Sta.Idle:
				FaceTo(_dirX);
				break;
			case Sta.Run:
				velocity = Vector2.Right * _dirX;
				FaceTo(_dirX);
				break;
			case Sta.Attack:

				break;
			case Sta.JumpUp:
				FaceTo(_dirX);
				velocity = Vector2.Right * _dirX;
				if (_jmp) //如果触发跳跃
					velocity.y = -1;
				break;
			case Sta.JumpFall:
				FaceTo(_dirX);
				velocity = Vector2.Right * _dirX;
				break;
			case Sta.Ground:

				break;
			case Sta.Defense:
				FaceTo(_dirX);
				break;
			case Sta.UnDefense:

				break;
		}

		return velocity;
	}
}
