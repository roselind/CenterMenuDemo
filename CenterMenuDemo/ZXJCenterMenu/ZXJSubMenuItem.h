//
//  ZXJSubMenuItem.h
//  CenterMenuDemo
//
//  Created by zhangxiaojing on 16/1/11.
//  Copyright © 2016年 张小静. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXJSubMenuItem;

@protocol ZXJSubMenuItemDelegate <NSObject>
-(void) subMenuItemPresss:(ZXJSubMenuItem *) button;
-(void) subMenuItemSwipeToRight;
-(void) subMenuItemSwipeToLeft;
@end
@interface ZXJSubMenuItem : UIButton
@property(nonatomic,weak) id <ZXJSubMenuItemDelegate> delegate;
@end
