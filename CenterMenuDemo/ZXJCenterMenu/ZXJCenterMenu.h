//
//  ZXJCenterMenu.h
//  CenterMenuDemo
//
//  Created by zhangxiaojing on 16/1/11.
//  Copyright © 2016年 张小静. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXJSubMenuItem.h"
#define PARENT_VIEW self.parentView
#define CURRENT_FRAME_WIDTH PARENT_VIEW.frame.size.width
#define CURRENT_FRAME_HEIGHT PARENT_VIEW.frame.size.height
#define angleToRadian(x) (((x)*M_PI)/180)

typedef enum{
    SubButtonRotationNormal = 0,
    SubButtonRotationReverse = 1,

}SubButtonRotationOrientation;

@protocol ZXJCenterMenuDelegate <NSObject>
@optional

-(void)centerMenuDidSelectedItemIndex:(NSInteger) index;
-(void)centerMenuDidSelectedItemIndex:(NSInteger) index title:(NSString *)title;
@end
@protocol ButtonDataSource
-(NSInteger)centerButtonMenuSubButtonItemsCount;
@end
@interface ZXJCenterMenu : UIView<ZXJSubMenuItemDelegate>{
    //子按钮默认位置
    CGPoint mSubButtonBirthLocation;
    //子按钮的最终位置
    CGPoint mSubButtonFinalLocation;
    
    CGFloat mSubButtonInCenterViewRotationLength;
}

// 用来初始化中心按钮
// 1. 总的半径 totalRadius
// 2. 中心按钮半径 centerRadius
// 3. 子按钮半径 subRadius
// 4. 中心按钮图像 centerImage
// 5. 子按钮图像 subImage
// 6. 中心按钮坐标 （xAxis yAxis）
// 7. 中心按钮的Parent view

-(instancetype) initCenterMenuWithSubButtons:(CGFloat) totalRadius
                                  centerRadius:(CGFloat) centerRadius
                                     subRadius:(CGFloat) subRadius
                                   centerImage:(NSString *)centerImageName
                                     subImages:(void (^) (ZXJCenterMenu *)) imageBlock
                                     locationX:(CGFloat) xAxis
                                     locationY:(CGFloat) yAxis
                                  toParentView:(UIView *) parentView;


-(instancetype) initCenterMenuWithSubButtons:(CGFloat) totalRadius
                                  centerRadius:(CGFloat) centerRadius
                                     subRadius:(CGFloat) subRadius
                                   centerImage:(NSString *)centerImageName
                                  subItemCount:(NSInteger) subItemCount
                                     subImages:(void (^) (ZXJCenterMenu *)) imageBlock
                                     locationX:(CGFloat) xAxis
                                     locationY:(CGFloat) yAxis
                                  toParentView:(UIView *) parentView;


-(void) subButtonImage:(NSString *) imageName withTag:(NSInteger) tag;
-(void) subButtonImage:(NSString *) imageName title:(NSString *)title  withTag:(NSInteger) tag;
-(void) subButtonImage:(NSString *) imageName title:(NSString *)title color:(UIColor *)titleColor fontSize:(CGFloat) titleFont withTag:(NSInteger) tag;
//属性
@property(nonatomic,weak) id <ZXJCenterMenuDelegate>delegate;
@property(nonatomic ,strong)  UIView* parentView;
@property(nonatomic) CGFloat centerLocationX;
@property(nonatomic) CGFloat centerLocationY;
@property(nonatomic) CGFloat totalRadius;
@property(nonatomic) CGFloat centerRadius;
@property(nonatomic) CGFloat subRadius;
@property(nonatomic) NSInteger subItemCount;
@property(nonatomic, getter=isExpanded) BOOL expanded;
 //中心按钮
@property(nonatomic,strong) UIButton *centerButton;
//子按钮集合
@property(nonatomic,strong) NSMutableArray *buttons;

@property(nonatomic,strong) ZXJSubMenuItem* subButton;
@end
