using XiaoLi.Base;
using Godot;
using Godot.Collections;
using XiaoLi.Util;


/// <summary>
/// 玩家操作的主角Rick
/// </summary>
public abstract class Rick : RoleBase
{
	//***************子节点
	/// 缩放节点
	public Node2D ScaNode { get; set; }

	/// 动画播放器
	public AnimationPlayer AnimationPlayer { get; set; }
	
	/// 光照节点
	public Light2D Light { get; set; }
	
	/// 爬墙检测节点
	public Area2D ClimbArea { get; set; }

	//***************内置变量
	/// 动画是否结束过
	protected bool AnimFinished { get; set; } = false;

	/// 是满足否可以爬墙的条件
	protected bool CanClimb { get; set; } = false;

	/// 是否启用旋转缩放,如果禁用,调用FaceTo()方法将不会产生效果
	protected bool EnableScale = true;

	/// 是否可以切换动作了,用于提前跳过部分动画过程,不然动画执行完成即可强制改变状态
	protected bool CanChangeState { get; set; } = false;

	//********************************override方法

	//*******************操作键位
	//移动方向
	protected float _dirX;
	//y轴方向
	protected float _dirY;
	//是否按下攻击键
	protected bool _atk;
	//是否按下跳跃按键
	protected bool _jmp;
	
	
	//*************************************************

	/// <summary>
	/// 主角Rick的初始化方法
	/// </summary>
	protected abstract void RickReady();

	/// <summary>
	/// 主角Rick的监听状态方法
	/// </summary>
	/// <param name="oldState">原来的状态</param>
	/// <returns>新的状态</returns>
	protected abstract Sta RickListeningState(Sta oldState);

	/// <summary>
	/// 根据状态播放动画
	/// </summary>
	/// <param name="oldState">原来的状态</param>
	/// <param name="newState">新的状态</param>
	/// <returns>返回动画名称的字符串,如果返回为null,则不播放任何动画</returns>
	protected abstract string RickPlayAnimation(Sta oldState, Sta newState);

	
	//*************************************************
	
	protected override void Ready()
	{
		//获取节点
		ScaNode = GetNode<Node2D>("Scale");
		AnimationPlayer = GetNode<AnimationPlayer>("AnimationPlayer");
		Light = GetNode<Light2D>("Scale/Light2D");
		//Light.Enabled = true;
		ClimbArea = GetNode<Area2D>("Scale/Area/Climb");
		//连接信号
		AnimationPlayer.Connect("animation_finished", this, nameof(AnimationPlayerFinished));
		ClimbArea.Connect("body_entered", this, nameof(SetCanClimb),new Array {true});
		ClimbArea.Connect("body_exited", this, nameof(SetCanClimb),new Array {false});
		//更新键位状态
		UpdateKeyState();
		RickReady();
	}

	
	protected override Sta ListeningState(Sta oldState)
	{
		//刷新键位状态
		UpdateKeyState();
		//检测状态改变
		return RickListeningState(oldState);
	}

	public override void ChangeState(Sta oldState, Sta newState)
	{
		State = newState;
		//设置动画状态为未播放完成
		AnimFinished = false;
		//设置不可强制改变状态
		CanChangeState = false;
		//监视动画
		string animationName = RickPlayAnimation(oldState,newState);
		if (animationName != null)
		{
			AnimationPlayer.Play(animationName);
			//立即播放动画
			AnimationPlayer.Advance(0);
		}
	}

	//*********************************************

	/// <summary>
	/// 角色转向,根据dir正负值,如果EnableScale为false,调用此方法无效果
	/// </summary>
	/// <returns>是否改变方向</returns>
	public bool FaceTo(float dir)
	{
		if (EnableScale && Mathf.Abs(dir - ScaNode.Scale.x) > 1)
		{
			//ScaNode.SetDeferred("scale",ScaNode.Scale * new Vector2(-1, 1));
			ScaNode.Scale *= new Vector2(-1, 1);
			return true;
		}
		return false;
	}
	
	/// <summary>
	/// 更新键位状态
	/// </summary>
	protected void UpdateKeyState()
	{
		_dirX = MyInput.Key("right") - MyInput.Key("left");
		_dirY = MyInput.Key("down") - MyInput.Key("up");
		_atk = MyInput.KeyPressed("attack");
		_jmp = MyInput.KeyPressed("jump");
	}
	
	/// <summary>
	/// 设置是否可以改变动作了,该方法一般为AnimationPlayer调用
	/// </summary>
	/// <param name="flag">true or false</param>
	protected void SetCanChangeState(bool flag)
	{
		CanChangeState = flag;
	}
	
	/// <summary>
	/// 信号连接:animation_finished
	/// 动画结束
	/// </summary>
	/// <param name="animName">动画名称</param>
	protected void AnimationPlayerFinished(string animName)
	{
		AnimFinished = true;
	}

	/// <summary>
	/// 设置是否达成爬墙的条件,由Scale/Area/Climb节点调用
	/// </summary>
	/// <param name="body">接触的爬墙节点</param>
	/// <param name="flag">bool值</param>
	protected void SetCanClimb(RigidBody2D body, bool flag)
	{
		if (flag && State == Sta.JumpFall)
		{
			//只有在body含有碰撞形状时才能执行下面的代码
			CollisionShape2D shape2D = body.GetChildOrNull<CollisionShape2D>(0);
			if (shape2D != null && shape2D.Shape is RectangleShape2D bodyRectangle)
			{
				//设置可以抓取墙角
				CanClimb = true;
				//关闭下落
				EnableGravity = false;
				//计算坐标点,使角色紧贴墙壁
				Vector2 climbAreaRectangle = ((RectangleShape2D) ClimbArea.GetChild<CollisionShape2D>(0).Shape).Extents;
				GlobalPosition += shape2D.GlobalPosition - bodyRectangle.Extents - new Vector2(GlobalPosition.x + 3,
					ClimbArea.GlobalPosition.y + climbAreaRectangle.y);
			}
		}
		else
		{
			CanClimb = false;
			EnableGravity = true;
		}
	}

	
	
	/// <summary>
	/// 爬墙过后调用该函数,重置位置
	/// 由Animation自动调用
	/// </summary>
	protected void ClimbFinish()
	{
		Position += new Vector2(7 * ScaNode.Scale.x,-16);
	}
}
