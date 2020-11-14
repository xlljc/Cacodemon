namespace XiaoLi.Util
{
    /// <summary>
    /// 状态类型枚举
    /// </summary>
    public enum State
    {
        /// <summary>
        /// 空闲
        /// </summary>
        Idle,
        /// <summary>
        /// 行走
        /// </summary>
        Walk,
        /// <summary>
        /// 奔跑
        /// </summary>
        Run,
        /// <summary>
        /// 攻击
        /// </summary>
        Attack,
        /// <summary>
        /// 跳跃,向上阶段
        /// </summary>
        JumpUp,
        /// <summary>
        /// 跳跃,下落阶段
        /// </summary>
        JumpFall,
        /// <summary>
        /// 跳跃落地
        /// </summary>
        Ground,
        /// <summary>
        /// 防御
        /// </summary>
        Defense,
        /// <summary>
        /// 解除防御状态
        /// </summary>
        UnDefense,
        /// <summary>
        /// 爬墙状态
        /// </summary>
        Climb,
        /// <summary>
        /// 死亡
        /// </summary>
        Dead
    }
}