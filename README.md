# 欢迎使用CenterMenu

@(示例)

![Gif](https://github.com/roselind/CenterMenuDemo/blob/master/demo.png)

**CenterMenu**主要实现的是 点击中间按钮，以中间按钮为圆心显示一圈的菜单选项，再次点击菜单选项消失。特点概述：
 
- **菜单选项的数量可以自定义**  
- **菜单选项的图片可以自定义**  
- **菜单项的 文字可以自定义**  

-------------------

[TOC]

## CenterMenu简介

> **CenterMenu** 是使用OC 编写的简单的库，主要实现的是 点击中间按钮，以中间按钮为圆心显示一圈的菜单选项，再次点击菜单选项消失 。如果哪里写的不好，希望大家多多指证。    —— [下载地址](https://github.com/roselind/CenterMenuDemo.git)

## 使用说明
下载[CenterMenuDemo](https://github.com/roselind/CenterMenuDemo.git)，将ZXJCenterMenu 文件夹拖入你的工程。然后在你要添加ViewController 里 导入头文件。

### 代码块
``` 
    ZXJCenterMenu * centerButton =[[ZXJCenterMenu alloc] initCenterMenuWithSubButtons:100
                                                                         centerRadius:40
                                                                            subRadius:30
                                                                          centerImage:@"clock"
                                                                         subItemCount:10
                                                                            subImages:^(ZXJCenterMenu * cb)
                                   {
                                       [cb subButtonImage:@"happy-minion-icon.png"
                                                    title:@"happy"
                                                    color:[UIColor blueColor]
                                                 fontSize:12
                                                  withTag:0];
                                       [cb subButtonImage:@"agnes-overjoyed-icon.png"
                                                    title:@"agnes"
                                                    color:[UIColor purpleColor]
                                                 fontSize:12
                                                  withTag:1];
                                       [cb subButtonImage:@"girl-minion-icon.png"
                                                     title:@"girl"
                                                    color:[UIColor orangeColor]
                                                 fontSize:13
                                                  withTag:2];
                                       [cb subButtonImage:@"superman-minion-icon.png"
                                                    title:@"superman"
                                                    color:[UIColor cyanColor]
                                                 fontSize:12
                                                  withTag:3];
                                       [cb subButtonImage:@"despicable-me-2-Minion-icon-7.png"
                                                    title:@"agnes"
                                                    color:[UIColor brownColor]
                                                 fontSize:12
                                                  withTag:4];
                                       [cb subButtonImage:@"shy-minion-icon.png"
                                                    title:@"shy"
                                                    color:[UIColor redColor]
                                                 fontSize:13
                                                  withTag:5];                                       
                                       [cb subButtonImage:@"happy-minion-icon.png"
                                                    title:@"happy2"
                                                    color:[UIColor blueColor]
                                                 fontSize:12
                                                  withTag:6];
                                       [cb subButtonImage:@"agnes-overjoyed-icon.png"
                                                    title:@"agnes2"
                                                    color:[UIColor purpleColor]
                                                 fontSize:12
                                                  withTag:7];
                                       [cb subButtonImage:@"girl-minion-icon.png"
                                                    title:@"girl2"
                                                    color:[UIColor orangeColor]
                                                 fontSize:13
                                                  withTag:8];
                                       [cb subButtonImage:@"superman-minion-icon.png"
                                                    title:@"superman2"
                                                    color:[UIColor cyanColor]
                                                 fontSize:12
                                                  withTag:9];                                       
                                   } locationX: self.view.center.x locationY:200 toParentView:self.view];
    centerButton.delegate =self;



```


## 反馈与建议
- QQ ：**roselind**<1198795485>
- 邮箱：<roselind_119@163.com>

---------
感谢阅读这份帮助文档,如果您发现写错或是有更好的建议请反馈给我。

 
