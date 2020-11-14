using Godot;
using Godot.Collections;

namespace XiaoLi.Util
{
    /// <summary>
    /// 键位映射类
    /// 负责储存"Config/config.ini"里配置键位的映射
    /// </summary>
    public class ButtonMapping
    {
        
        /// <summary>
        /// 单例类,实例对象
        /// </summary>
        public static ButtonMapping Instance { get; } = new ButtonMapping();

        /// <summary>
        /// 储存键位映射的值
        /// </summary>
        public Dictionary<string, uint> Mapping { get; } = new Dictionary<string, uint>();


        /// <summary>
        /// 重新加载键位映射
        /// </summary>
        public void Upload()
        {
            Mapping.Clear();
            //读取ini配置文件
            ConfigFile file = new ConfigFile();
            file.Load("res://Config/config.ini");
            //获取所有映射的键
            string[] keys = file.GetSectionKeys("KeyMap");
            //储存键位
            foreach (var i in keys)
            {
                uint key = uint.Parse(file.GetValue("KeyMap", i).ToString());
                Mapping.Add(i, key);
                //如果存在就删除然后重新映射
                if (InputMap.HasAction(i))
                    InputMap.EraseAction(i);
                //创建一个键位映射
                InputMap.AddAction(i);
                InputMap.ActionAddEvent(i,new InputEventKey {Scancode = key});
            }
        }

        private ButtonMapping()
        {
        }

    }
}