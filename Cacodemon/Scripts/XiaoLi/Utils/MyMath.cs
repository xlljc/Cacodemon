using System;
using Godot;

namespace XiaoLi.Util
{
    
    /// <summary>
    /// 自定义工具类
    /// 封装了Godot引擎游戏开发中常用方法
    /// </summary>
    public static class MyMath
    {
        
        private static Random Random { get; set; } = new Random();
        
        /// <summary>
        /// 重置随机数种子
        /// </summary>
        /// <param name="speed">随机数种子</param>
        public static void SetRandomSpeed(int speed)
        {
            Random = new Random(speed);
        }

        /// <summary>
        /// 返回一个参数范围内的随机整数
        /// 改方法与GD.RandRange()方法类似,但改方法返回的是一个int整形数
        /// </summary>
        /// <param name="min">最小值</param>
        /// <param name="max">最大值</param>
        /// <returns>范围内的随机整数</returns>
        public static int RandRange(int min, int max)
        {
            if (min > max)
            {
                int temp = min;
                min = max;
                max = temp;
            }

            if (min >= 0)
                return Random.Next(max + 1) % (max - min + 1) + min;
            return Random.Next(1 - min) % (1 - min) + min;
        }

        /// <summary>
        /// 随机返回参数中的一个
        /// </summary>
        /// <param name="args">参数组</param>
        /// <returns>随机参数</returns>
        public static object Choose(params object[] args)
        {
            return args[RandRange(0, args.Length - 1)];
        }
        
        /// <summary>
        /// 角度制转弧度制
        /// </summary>
        /// <param name="degrees">角度</param>
        /// <returns>弧度</returns>
        public static float ToRadians(float degrees)
        {
            return (Mathf.Pi/180) * degrees;
        }

        /// <summary>
        /// 弧度制转角度制
        /// </summary>
        /// <param name="radians">弧度</param>
        /// <returns>角度</returns>
        public static float ToDegrees(float radians)
        {
            return (180 / Mathf.Pi) * radians;
        }
    }
}