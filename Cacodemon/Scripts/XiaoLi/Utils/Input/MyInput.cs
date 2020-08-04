using Godot;

namespace XiaoLi.Util
{
    
    

    /// <summary>
    /// 自定义Input类
    /// 根据"Config/config.ini"配置文件中的"[windowsKey]"键位映射检测按键状态
    /// 调用Key(str)方法检测是否按下某个按键
    /// </summary>
    public static class MyInput
    {
        /// <summary>
        /// 
        /// </summary>
        static MyInput()
        {
            
        }
        
        /// <summary>
        /// 根据按键名称检测这个按键是否被按下
        /// </summary>
        /// <param name="keyName">需要检测按键的名称</param>
        /// <returns>0 or 1</returns>
        public static float Key(string keyName)
        {
            return Input.GetActionStrength(keyName);
        }

        /// <summary>
        /// 当用户开始按下动作事件时返回true
        /// </summary>
        /// <param name="keyName">需要检测按键的名称</param>
        /// <returns>true or false</returns>
        public static bool KeyPressed(string keyName)
        {
            return Input.IsActionJustPressed(keyName);
        }

        //public delegate void EachOperation<T,TE>(System.Collections.Generic.KeyValuePair<T, TE> i);
        /*
        public static void Each<T,TE>(Dictionary<T, TE> dictionary,EachOperation<T,TE> method)
        {
            foreach (var i in dictionary)
            {
                method(i);
            }
        }
        */

    }
}