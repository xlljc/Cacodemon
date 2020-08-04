using Godot;
using XiaoLi.Util;

/// <summary>
/// 
/// </summary>
public class RickDefault : Rick
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
                if (_dirX != 0) //如果静止
                    oldState = Sta.Run;
                else if (_jmp) //如果按下跳跃
                    oldState = Sta.JumpUp;
                else if (Velocity.y > 0) //如果下落
                    oldState = Sta.JumpFall;
                break;
            case Sta.Run:
                if (_dirX == 0) //如果静止
                    oldState = Sta.Idle;
                else if (_jmp) //如果按下跳跃
                    oldState = Sta.JumpUp;
                else if (Velocity.y > 0) //如果下落
                    oldState = Sta.JumpFall;
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
        }
        return oldState;
    }

    protected override string RickPlayAnimation(Sta state)
    {
        return state.ToString();
    }
    
    public override Vector2 Operation(float delta)
    {
        Vector2 velocity = Vector2.Zero;
        switch (State)
        {
            case Sta.Idle:
                FaceTo(_dirX);
                break;
            case Sta.Run:
                velocity = Vector2.Right * _dirX;
                FaceTo(_dirX);
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
        }
        return velocity;
    }
}