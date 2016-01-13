//
//  ZXJCenterMenu.m
//  CenterMenuDemo
//
//  Created by zhangxiaojing on 16/1/11.
//  Copyright © 2016年 张小静. All rights reserved.
//

#import "ZXJCenterMenu.h"

@implementation ZXJCenterMenu
-(BOOL) isExpanded{
    return _expanded;
}
-(instancetype) initCenterMenuWithSubButtons:(CGFloat) totalRadius
                                  centerRadius:(CGFloat) centerRadius
                                     subRadius:(CGFloat) subRadius
                                   centerImage:(NSString *)centerImageName
                                     subImages:(void (^) (ZXJCenterMenu *)) imageBlock
                                     locationX:(CGFloat) xAxis
                                     locationY:(CGFloat) yAxis
                                  toParentView:(UIView *) parentView{
    
    
    self =[self initCenterMenuWithSubButtons:totalRadius centerRadius:centerRadius subRadius:subRadius centerImage:centerImageName subItemCount:3 subImages:imageBlock locationX:xAxis locationY:yAxis toParentView:parentView];
    return self;
}
-(instancetype) initCenterMenuWithSubButtons:(CGFloat) totalRadius
                                  centerRadius:(CGFloat) centerRadius
                                     subRadius:(CGFloat) subRadius
                                   centerImage:(NSString *)centerImageName
                                  subItemCount:(NSInteger) subItemCount
                                     subImages:(void (^) (ZXJCenterMenu *)) imageBlock
                                     locationX:(CGFloat) xAxis
                                     locationY:(CGFloat) yAxis
                                  toParentView:(UIView *) parentView{
    if (self =[super initWithFrame:parentView.bounds]) {
        self.parentView     = parentView;
        (xAxis == 0)?(self.centerLocationX = CURRENT_FRAME_WIDTH/2):(self.centerLocationX= xAxis);
        (yAxis == 0)?(self.centerLocationY = CURRENT_FRAME_HEIGHT/2):(self.centerLocationY= yAxis);
        
        self.totalRadius=totalRadius;
        self.subRadius  =subRadius;
        self.centerRadius=centerRadius;
        self.expanded = NO;
        self.subItemCount =subItemCount;
        mSubButtonBirthLocation =CGPointMake(-CURRENT_FRAME_WIDTH/2, -CURRENT_FRAME_HEIGHT/2);
        mSubButtonFinalLocation =CGPointMake(self.centerLocationX, self.centerLocationY);
        mSubButtonInCenterViewRotationLength = 0 ;
        
        
        //初始化中心按钮
        [self configureCenterButton:centerRadius image:centerImageName];
        [self configureSubButtons:self.subItemCount];
        imageBlock(self);
        [self.parentView addSubview:self];
    }
    return self;

    
}

-(void) configureCenterButton:(CGFloat) centerRadius image:(NSString *) imageName{
    self.centerButton =[[UIButton alloc] init];
    
    //设置中心按钮的尺寸
    self.centerButton.frame = CGRectMake(0, 0, centerRadius*2, centerRadius *2);
    
    //设置中心按钮的位置
    self.centerButton.center= CGPointMake(self.centerLocationX, self.centerLocationY);
    
    //设置中心按钮的图像
    [self.centerButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    //让中心按钮始终在最前面
    self.centerButton.layer.zPosition =1 ;
    [self.centerButton addTarget:self action:@selector(centerButtonPress) forControlEvents:UIControlEventTouchUpInside];
    //将中心按钮添加到容器中
    [self addSubview:self.centerButton];
}
-(void) configureSubButtons:(CGFloat) subButtonsCount{
    
    self.buttons = [NSMutableArray array];
    for (int i =0; i<subButtonsCount; i++) {
        _subButton =[[ZXJSubMenuItem alloc] init];
        _subButton.delegate =self;
        _subButton.frame = CGRectMake(0, 0,
                                      _subRadius*2,_subRadius*2);
        _subButton.center = mSubButtonBirthLocation;
        _subButton.tag = i;
        [self addSubview:_subButton];
        [self.buttons addObject:_subButton];
    }
}
-(void) subButtonImage:(NSString *) imageName title:(NSString *)title withTag:(NSInteger) tag {
    
    [self subButtonImage:imageName title:title color:[UIColor orangeColor] fontSize:12 withTag:tag];

}
-(void) subButtonImage:(NSString *) imageName title:(NSString *)title color:(UIColor *)titleColor fontSize:(CGFloat) titleFont withTag:(NSInteger) tag{
    ZXJSubMenuItem* currentSubButton =[self.buttons objectAtIndex:tag];
    [currentSubButton setTitle:title forState:UIControlStateNormal];
    [currentSubButton setTitleColor:titleColor forState:UIControlStateNormal];
    currentSubButton.titleLabel.font =[UIFont systemFontOfSize:titleFont];
    [currentSubButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];

}
-(void) subButtonImage:(NSString *) imageName withTag:(NSInteger) tag{
    ZXJSubMenuItem* currentSubButton =[self.buttons objectAtIndex:tag];
    [currentSubButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
}
-(CGPoint)subButtonLocationPointWithIndex:(NSInteger) index{
     CGPoint Location = CGPointMake(self.centerLocationX-self.totalRadius*sinf(angleToRadian(360/self.subItemCount*index)), self.centerLocationY-self.totalRadius*cosf(angleToRadian(360/self.subItemCount*index)));
    return Location;
}
//动画方式显示子按钮
-(void)button:(ZXJSubMenuItem *) button appearAt:(CGPoint) location withDelay:(CGFloat) delay duration:(CGFloat) duration{
    button.center =location;
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.duration = duration ;
    
    
    //从0.1 到1.5 再到 1.0
    scaleAnimation.values =@[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5, 1.5, 1)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1)]];
    
    //确定每一段动画的完成时间比例
    
    scaleAnimation.keyTimes = @[[NSNumber numberWithFloat:0.0f],[NSNumber numberWithFloat:delay],[NSNumber numberWithFloat:1.0f]];
    
    //设置缩放的锚点
    button.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
    [button.layer addAnimation:scaleAnimation forKey:@"buttonApear"];
}
//以东航的方式隐藏 子按钮
-(void) button:(ZXJSubMenuItem *) button shrinkAt:(CGPoint) location offsetAxisX:(CGFloat) axisX  offsetAxisY:(CGFloat) axisY withDelay:(CGFloat) delay rotateDirection:(SubButtonRotationOrientation) orientation animationDuration:(CGFloat) duration{
    //旋转动画
    CAKeyframeAnimation* rotation =[CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotation.duration = duration* delay;
    rotation.values = @[[NSNumber numberWithFloat:0.0f],[NSNumber numberWithFloat:[self matchRotationOrientation:orientation]],[NSNumber numberWithFloat:0.0f]];
    rotation.keyTimes =@[[NSNumber numberWithFloat:0.0f],[NSNumber numberWithFloat:delay],[NSNumber numberWithFloat:1.0f]];
    
    
    //收缩动画
    CAKeyframeAnimation *shrink =[CAKeyframeAnimation animationWithKeyPath:@"position"];
    shrink.duration = duration *(1-delay);
    CGMutablePathRef path  =CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, location.x, location.y);

    //往外移动
    CGPathAddLineToPoint(path, NULL, location.x+axisX , location.y+axisY);
    //往里面移动
    CGPathAddLineToPoint(path, NULL, mSubButtonFinalLocation.x, mSubButtonFinalLocation.y);
    shrink.path = path;
    CGPathRelease(path);
    
    //组合动画
    CAAnimationGroup *totalAnimation =[CAAnimationGroup animation];
    totalAnimation.duration =1.0f;
    totalAnimation.animations =@[rotation,shrink];
    
    //加速运动
    totalAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    totalAnimation.delegate =self;
    
    button.layer.anchorPoint  = CGPointMake(0.5f, 0.5f);
    button.center =mSubButtonBirthLocation;
    [button.layer addAnimation:totalAnimation forKey:@"buttonDismiss"];
}


//旋转动画
-(void) button:(ZXJSubMenuItem *) button rotateAt:(CGPoint) location offsetAxisX:(CGFloat) axisX  offsetAxisY:(CGFloat) axisY withDelay:(CGFloat) delay rotateDirection:(SubButtonRotationOrientation) orientation animationDuration:(CGFloat) duration{
    
}

-(CGFloat)matchRotationOrientation:(SubButtonRotationOrientation) orientation{
    if (orientation ==SubButtonRotationNormal) {
        return M_PI*2;
    }
    return -M_PI*2;
}
-(CGFloat) offsetAxisY:(CGFloat) axisY withAngle:(CGFloat)angle{
    return (axisY / tanf(angleToRadian(angle)));
}
//中心按钮的点击事件 方法
-(void) centerButtonPress{
    //判断收缩 还是展开状态
    
    if (![self isExpanded]) {//收缩状态
        
        //展现子按钮
        for (NSInteger i=0; i<self.buttons.count; i++) {
            [self button:[self.buttons objectAtIndex:i] appearAt:[self subButtonLocationPointWithIndex:i] withDelay:0.5+i*0.025 duration:0.35+i*0.025];
        }
        self.expanded = YES;
    }else  //扩展状态
    {
        //收缩 子按钮
        
        for (NSInteger i=0; i<self.buttons.count; i++) {
            [self button:[self.buttons objectAtIndex:i] shrinkAt:[self subButtonLocationPointWithIndex:i] offsetAxisX:i<self.subItemCount/2?-20:20 offsetAxisY:[self offsetAxisY:i<self.subItemCount/2?-20:20   withAngle:60] withDelay:0.4 rotateDirection:SubButtonRotationNormal animationDuration:1];
        }

        self.expanded = NO;

    }
}
//响应子按钮的事件方法
-(void) subMenuItemPresss:(ZXJSubMenuItem *) button{
   
    if ([self.delegate respondsToSelector:@selector(centerMenuDidSelectedItemIndex:)]) {
        [self.delegate centerMenuDidSelectedItemIndex:button.tag];
    }
    if ([self.delegate respondsToSelector:@selector(centerMenuDidSelectedItemIndex:title:)]) {
        [self.delegate centerMenuDidSelectedItemIndex:button.tag title:button.currentTitle];
    }
 }

-(void) subMenuItemSwipeToRight{
    NSLog(@"%s",__FUNCTION__);
    mSubButtonInCenterViewRotationLength -= 20;
    if ([self isExpanded]) {
        for (NSInteger i=0; i<self.buttons.count; i++) {
            [self button:[self.buttons objectAtIndex:i] rotateAt:[self subButtonLocationPointWithIndex:i] offsetAxisX:i<self.subItemCount/2?-20:20 offsetAxisY:[self offsetAxisY:i<self.subItemCount/2?-20:20   withAngle:60] withDelay:0.4 rotateDirection:SubButtonRotationNormal animationDuration:1];
        }

    }
}
-(void) subMenuItemSwipeToLeft{
    NSLog(@"%s",__FUNCTION__);
     mSubButtonInCenterViewRotationLength+= 20;
    if ([self isExpanded]) {
        for (NSInteger i=0; i<self.buttons.count; i++) {
            [self button:[self.buttons objectAtIndex:i] rotateAt:[self subButtonLocationPointWithIndex:i] offsetAxisX:i<self.subItemCount/2?-20:20 offsetAxisY:[self offsetAxisY:i<self.subItemCount/2?-20:20   withAngle:60] withDelay:0.4 rotateDirection:SubButtonRotationNormal animationDuration:1];
        }
        
    }
}
 

@end
