using System.Collections.Generic;
using Godot;
using Godot.Collections;

namespace XiaoLi.Util
{

    /// <summary>
    /// 对集合遍历的工具类,
    /// 也可以遍历场景节点
    /// </summary>
    public class EachUtil
    {

        /// <summary>
        /// 对遍历键值对的操作
        /// </summary>
        /// <param name="pair">键值对</param>
        public delegate void EachDictionaryOperation<TK, TV>(System.Collections.Generic.KeyValuePair<TK, TV> pair);

        /// <summary>
        /// 对遍历集合内数据的操作
        /// </summary>
        /// <param name="obj">对象</param>
        public delegate void EachArrayOperation<in T>(T obj);

        /// <summary>
        /// 对遍历节点的操作
        /// </summary>
        /// <param name="node">节点对象</param>
        public delegate void EachNodeOperation(Node node);


        
        
        /// <summary>
        /// 遍历Dictionary字典,并执行相应的操作
        /// </summary>
        /// <param name="dictionary">字典集合</param>
        /// <param name="method">委托操作的方法</param>
        public static void Each<TK, TV>(Godot.Collections.Dictionary<TK, TV> dictionary,
            EachDictionaryOperation<TK, TV> method)
        {
            foreach (var i in dictionary) method(i);
        }

        
        /// <summary>
        /// 遍历集合,并执行相应的操作
        /// </summary>
        /// <param name="array">集合对象</param>
        /// <param name="method">委托操作的方法</param>
        public static void Each<T>(IEnumerable<T> array, EachArrayOperation<T> method)
        {
            foreach (var i in array) method(i);
        }

        
        /// <summary>
        /// 遍历Godot的节点对象,,并执行相应的操作
        /// </summary>
        /// <param name="node">需要遍历的节点</param>
        /// <param name="method">委托操作的方法</param>
        public static void Each(Node node,EachNodeOperation method)
        {
            if (node == null) return;
            Array childrenArray = node.GetChildren();
            foreach (var i in childrenArray)
            {
                Node nodeTemp = (Node)i;
                method(nodeTemp);
                if (nodeTemp.GetChildCount() != 0)
                    Each(nodeTemp,method);
            }
        }
    }
}