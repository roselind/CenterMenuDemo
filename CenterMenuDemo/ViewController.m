//
//  ViewController.m
//  CenterMenuDemo
//
//  Created by zhangxiaojing on 16/1/12.
//  Copyright © 2016年 张小静. All rights reserved.
//

#import "ViewController.h"

#import "ZXJCenterMenu.h"
@interface ViewController ()<ZXJCenterMenuDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
}
-(void)centerMenuDidSelectedItemIndex:(NSInteger) index title:(NSString *)title{
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"%ld----%@",index,title);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:@"被选中" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
