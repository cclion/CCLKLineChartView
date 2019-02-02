### 介绍：
- 这是以`雪球APP`为原型，基于 `Objective-C`的K线开源项目。
- 该项目整体设计思路已经经过某成熟证券APP的商业认证。
- 本项目将K线业务代码尽可能缩减，保留核心功能，可流畅、高效实现手势交互。
- K线难点在于手势交互和数据动态刷新上，功能并不复杂，关键在于设计思路。


### 建议：

- 如果搭建K线为公司业务，不建议采用集成度高的开源代码。庞大臃肿，纵然短期匆忙上线，难以应付后期灵活需求变更。


`Swift`版请移步 https://github.com/cclion/KLineView 。

### 设计思路&&难点：
 K线难点在于手势的处理上，`捏合、长按、拖拽`都需要展示不同效果。以下是Z君当时做K线时遇到的问题的解决方案；
 
####  1.  捏合手势需要动态改变K线柱的宽度，对应的增加或减少当前界面K线柱的展示数量,并且根据当前展示的数据计算出当前展示数据的极值。

采用`UITableView`类实现，将K线柱封装在`cell`中，在`tableview`中监听捏合手势，对应改变`cell`的高度，同时刷新`cell`中K线柱的布局来实现动态改变K线柱的宽度。

采用`UITableView`还有一个好处就是可以采用`cell`的重用机制降低内存。

注意：因为`UITableView`默认是上下滑动，而K线柱是左右滑动，Z君这里将`UITableView`做了一个顺时针90°的旋转。 
![tableView旋转90°](https://upload-images.jianshu.io/upload_images/3425250-2b92b7cce0268ee2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

####  2.  K线柱绘制
K线柱采用`CAShapeLayer`配合`UIBezierPath`绘制，内存低，效率高，棒棒哒！

关于CAShapeLayer的使用大家可以看这篇    https://zsisme.gitbooks.io/ios-/content/chapter6/cashapelayer.html
（现在的google、baidu，好文章都搜不到，一搜全是简单调用两个方法就发的博客，还是翻了两年前的收藏才找到这个网站，强烈推荐大家）

####  3.  捏合时保证捏合中心点不变，两边以捏合中间点为中心进行收缩或扩散

因为`UITableView`在改变`cell`的高度时，默认时不会改变偏移量，所以不能保证捏合的中心点不变，这里我们的小学知识就会用上了。
![捏合时状态.png](https://upload-images.jianshu.io/upload_images/3425250-dc74b97e9cc67fc5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

我们可以通过变量定义控件间距离。
![捏合前后.png](https://upload-images.jianshu.io/upload_images/3425250-eef1802efdddcc61.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
 
保证捏合中心点的中K线柱的中心点还在捏合前，就需要`c1 = c2` ，计算出`O2`，在捏合完，设置偏移量为`O2`即可。
![计算偏移量.png](https://upload-images.jianshu.io/upload_images/3425250-1e56905ede398f14.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

####  4.  K线其他线性指标如何绘制

在K线中除了K线柱之外，还有其他`均线指标`，连贯整个数据显示区。
![线性指标](https://upload-images.jianshu.io/upload_images/3425250-fd6d12d2c69a2dbe.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

由图可以看出均线指标由每个`cell`中心点的数据连接相邻的`cell`中心点的数据。我们依旧将绘制放在`cell`中，将相连两个`cell`的线分割成两段，分别在各自所属的`cell`中绘制。

需要我们做的就是就是在cell中传入相邻的`cell`的`soureData`，计算出相邻中点的位置，分为两段绘制。
![分割绘制](https://upload-images.jianshu.io/upload_images/3425250-ae67ab2f0435be14.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

---
大家针对K线有什么问题都可以在下面留言，会第一时间解答。
未完待续
