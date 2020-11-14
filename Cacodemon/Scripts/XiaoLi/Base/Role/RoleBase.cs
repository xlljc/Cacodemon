using Godot;
using XiaoLi.Util;

namespace XiaoLi.Base
{
    /// <summary>
    /// 角色基类,继承自KinematicBody2D
    /// </summary>
    public abstract class RoleBase : KinematicBody2D
    {
        //***************导出变量

        ///是否使用物理帧
        [Export] public bool UsePhysicsProcess = false;

        /// 最大血量
        [Export]
        public int MaxHp { get; set; } = 10;

        /// 当前血量,如果初始值设置为-1则取用最大血量的值
        [Export]
        public int Hp { get; set; } = -1;

        /// 最大移动速度
        [Export]
        public float MoveSpeed { get; set; } = 130;

        /// 跳跃的力度
        [Export]
        public float JumpSpeed { get; set; } = 300;
        
        /// 移动加速度/减速度
        [Export]
        public float MoveAcceleration { get; set; } = 800;

        /// 重力加速度
        [Export]
        public float Gravity { get; set; } = 20;

        /// 当前状态
        [Export]
        public State State { get; set; } = State.Idle;

        /// 当前移动速率
        public Vector2 Velocity { get; set; } = Vector2.Zero;

        /// 是否启用物理下落
        public bool EnableGravity { get; set; } = true;
        
        //****************************方法

        /// <summary>
        /// 初始化调用
        /// </summary>
        protected abstract void Ready();

        /// <summary>
        /// 每一帧调用
        /// </summary>
        /// <param name="delta"></param>
        protected abstract void Process(float delta);

        /// <summary>
        /// 物理帧每一帧调用一次
        /// </summary>
        /// <param name="delta"></param>
        protected abstract void PhysicsProcess(float delta);

        /// <summary>
        /// 监听状态,判断是否需要改变状态
        /// </summary>
        /// <param name="oldState">原来的状态</param>
        /// <returns>改变后的状态</returns>
        protected abstract State ListeningState(State oldState);

        /// <summary>
        /// 改变状态,并触发动画更新,调用事件
        /// 在ListeningState()方法改变过状态后,会自动调用该函数
        /// </summary>
        /// <param name="oldState">原来的状态</param>
        /// <param name="newState">新的状态</param>
        public abstract void ChangeState(State oldState, State newState);

        /// <summary>
        /// 角色的操作,状态的改变
        /// </summary>
        /// <param name="delta"></param>
        /// <returns>运动方向</returns>
        public abstract Vector2 Operation(float delta);

        //***********************************


        /// <summary>
        /// 移动函数,该函数负责计算移动
        /// </summary>
        /// <param name="velocity">移动的方向</param>
        /// <param name="delta"></param>
        public void Move(Vector2 velocity, float delta)
        {
            //x轴方向移动
            velocity.x = Mathf.MoveToward(Velocity.x, velocity.x * MoveSpeed, MoveAcceleration * delta);
            //y轴方向移动(重力下落)
            if (EnableGravity) velocity.y = velocity.y == -1f ? -JumpSpeed : Velocity.y + Gravity;
            Velocity = MoveAndSlide(velocity, Vector2.Up);
        }


        /// <summary>
        /// 每一帧执行操作
        /// </summary>
        /// <param name="delta"></param>
        private void Update(float delta)
        {
            //监视状态
            State oldState = State;
            State newState = ListeningState(oldState);
            if(oldState != newState)
            {
                ChangeState(oldState,newState);
            }
            //用户操作
            Vector2 dir = Operation(delta);
            //计算移动
            Move(dir,delta);
        }


        public override void _Ready()
        {
            //初始化部分属性
            Hp = Hp == -1 ? MaxHp : Hp;
            Ready();
            ChangeState(State,State);
        }

        public override void _Process(float delta)
        {
            Process(delta);
            if (UsePhysicsProcess)
                return;
            Update(delta);
        }

        public override void _PhysicsProcess(float delta)
        {
            PhysicsProcess(delta);
            if (!UsePhysicsProcess)
                return;
            Update(delta);
        }
    }
}