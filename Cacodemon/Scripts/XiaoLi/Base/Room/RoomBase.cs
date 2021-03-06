﻿using Godot;
using XiaoLi.Util;

namespace XiaoLi.Base
{
    
    /// <summary>
    /// 房间基类,继承自Node2D类
    /// </summary>
    public abstract class RoomBase : Node2D
    {
        
        /// 地图数据
        public RoomDate RoomDate { get; set; }
        
        
        
        public override void _Ready()
        {
            //初始化键位映射
            ButtonMapping.Instance.Upload();
            RoomDate = GetNode<RoomDate>("RoomDate");
            
            Ready();
        }

        public override void _Process(float delta)
        {
            Process(delta);
        }

        public override void _PhysicsProcess(float delta)
        {
            PhysicsProcess(delta);
        }

        
        protected abstract void Ready();

        protected abstract void Process(float delta);

        protected abstract void PhysicsProcess(float delta);
    }
}