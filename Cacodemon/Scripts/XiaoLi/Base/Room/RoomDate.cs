using Godot;
using Godot.Collections;
using XiaoLi.Util;

/// <summary>
/// 地图的基本数据
/// </summary>
public class RoomDate : Node2D
{
    
    /// <summary>
    /// 房间主相机
    /// </summary>
    public Camera2D Camera { get; set; }
    
    /// <summary>
    /// 获取所有背景精灵
    /// </summary>
    public Dictionary<string, Sprite> Sprites => _sprites;

    /// <summary>
    /// 获取所有视差背景
    /// </summary>
    public Dictionary<string, ParallaxBackground> ParallaxBackgrounds => _parallaxBackgrounds;
    
    
    /// 所有在SpriteNode节点下的背景精灵,但是不包含在ParallaxBackground节点内的
    private Dictionary<string,Sprite> _sprites = new Dictionary<string, Sprite>();
    
    /// 所有在SpriteNode节点下的视差背景
    private readonly Dictionary<string,ParallaxBackground> _parallaxBackgrounds = new Dictionary<string, ParallaxBackground>();

    
    

    public override void _Ready()
    {
        Camera = GetNode<Camera2D>("Camera");
        //初始化Sprites与ParallaxBackgrounds
        InitSpriteNodeDate();
    }


    public override void _Process(float delta)
    {
        //移动视差背景,根据相机的坐标
        MoveParallaxBackgrounds(new Vector2(-Camera.GetCameraScreenCenter().x, 0));
    }


    /// <summary>
    /// 设置相机的限制范围
    /// </summary>
    /// <param name="position">顶点位置</param>
    /// <param name="extents">宽高</param>
    public void SetCamera(Vector2 position,Vector2 extents)
    {
        Camera.LimitLeft = (int) position.x;
        Camera.LimitTop = (int) position.y;
        Camera.LimitRight = (int) position.x + (int) extents.x;
        Camera.LimitBottom = (int) position.y + (int) extents.y;
    }


    /// <summary>
    /// 初始化SpriteNode节点
    /// 遍历节点下的Sprites与ParallaxBackgrounds并赋值给Dictionary
    /// </summary>
    public void InitSpriteNodeDate()
    {
        ParallaxBackground pbTemp = null;
        EachUtil.Each(GetNode("SpriteNode"), (i) =>
        {
            switch (i)
            {
                case Sprite sprite:
                    //判断是否是ParallaxBackground下的子节点
                    if(pbTemp == null || !pbTemp.IsAParentOf(sprite))
                        _sprites.Add(sprite.Name, sprite);
                    break;
                case ParallaxBackground parallaxBackground:
                    pbTemp = parallaxBackground;
                    _parallaxBackgrounds.Add(parallaxBackground.Name, parallaxBackground);
                    break;
            }
        });
    }


    public void MoveParallaxBackgrounds(Vector2 offset)
    {
        EachUtil.Each(_parallaxBackgrounds, (i) => { i.Value.ScrollOffset = offset; });
    }




    //***************************************************************
    
}