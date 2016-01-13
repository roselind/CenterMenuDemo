//
//  ZXJSubMenuItem.m
//  CenterMenuDemo
//
//  Created by zhangxiaojing on 16/1/11.
//  Copyright © 2016年 张小静. All rights reserved.
//

#import "ZXJSubMenuItem.h"

static const CGFloat tabBarTextFontSize =13.0f;
@interface ZXJSubMenuItem ()
@property (nonatomic,strong) UIFont *myFont;
@end
@implementation ZXJSubMenuItem

-(instancetype) initWithCoder:(NSCoder *)aDecoder{
    if (self =[super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}
-(instancetype) initWithFrame:(CGRect)frame{
    if (self= [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void) setUp{
    self.myFont =[UIFont systemFontOfSize:tabBarTextFontSize];
    self.titleLabel.font =self.myFont;
    [self addTarget:self action:@selector(buttonOnClicked:) forControlEvents:UIControlEventTouchUpInside];
 
    
    //向右轻扫手势
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    recognizer.direction = UISwipeGestureRecognizerDirectionRight; //设置轻扫方向；默认是 UISwipeGestureRecognizerDirectionRight，即向右轻扫
    [self addGestureRecognizer:recognizer];
    //向左轻扫手势
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    recognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:recognizer];
    
}
- (void) buttonOnClicked:(ZXJSubMenuItem *) menuIten{
    if ([_delegate respondsToSelector:@selector(subMenuItemPresss:)]) {
        [_delegate subMenuItemPresss:self];
    }
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)recognizer {
    //根据轻扫方向，进行不同控制 实现旋转
    switch (recognizer.direction) {
        case UISwipeGestureRecognizerDirectionRight: {
            if ([_delegate respondsToSelector:@selector(subMenuItemSwipeToRight)]) {
                [_delegate subMenuItemSwipeToRight];
            }
            break;
        }
        case UISwipeGestureRecognizerDirectionLeft: {
            if ([_delegate respondsToSelector:@selector(subMenuItemSwipeToLeft)]) {
                [_delegate subMenuItemSwipeToLeft];
            }
            break;
        }
        case UISwipeGestureRecognizerDirectionUp: {
            break;
        }
        case UISwipeGestureRecognizerDirectionDown: {
            break;
        }
    }
}
- (CGSize)getTitleSize{
    NSString *title =self.currentTitle;
    CGSize maxSize =CGSizeMake(MAXFLOAT, MAXFLOAT);
    CGSize titleSize ;
    NSMutableDictionary *muDic =[NSMutableDictionary dictionary];
    muDic[NSFontAttributeName] =self.myFont;
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    
    CGRect titleRect =[title boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:muDic context:nil];
    titleSize =titleRect.size;
#else
    titleSize =[title sizeWithFont:self.myFont];
    
#endif
    return titleSize;
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGSize  titleSize =[self getTitleSize];
    CGFloat titleX =0;
    CGFloat titleY =0.0f;
    CGFloat titleH =titleSize.height;
    CGFloat titleW =titleSize.width;
    titleY =contentRect.size.height -titleH-2;
    titleX =(contentRect.size.width- titleW)*0.5;
    return CGRectMake(titleX, titleY,titleW, titleH);
    
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGSize  titleSize =[self getTitleSize];
    CGFloat imageY =4;
    CGFloat imageH =contentRect.size.height-titleSize.height-8.5;
    CGFloat imageW=contentRect.size.height-titleSize.height-8.5;
    CGFloat imageX=(contentRect.size.width-imageW)*0.5;
    return CGRectMake(imageX, imageY, imageW, imageH);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
