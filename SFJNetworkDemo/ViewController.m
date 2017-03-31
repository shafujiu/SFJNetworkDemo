//
//  ViewController.m
//  SFJNetworkDemo
//
//  Created by 沙缚柩 on 2017/3/30.
//  Copyright © 2017年 沙缚柩. All rights reserved.
//

#import "ViewController.h"
#import "SFJNetworkingTool.h"
#import "MBProgressHUD+Add.h"

@interface ViewController ()


@property (nonatomic, strong) MBProgressHUD *hud;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.hud = [MBProgressHUD showWaittingHUDWithMeessage:@"shafujiu..."];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.hud dismissAnimated:NO];
        
    });
}

- (IBAction)download:(id)sender {
    NSString *url = @"http://dldir1.qq.com/qqfile/QQforMac/QQ_V4.1.1.dmg";
    MBProgressHUD *hud = [MBProgressHUD showProgressWithMessage:@"loading..."];
    [SFJNetworkingTool downloadFileWithUrl:url Parameter:nil SavedPath:nil Complete:^(NSData *data, NSError *error) {
        [hud dismissAnimated:YES];
    } Progress:^(id downloadProgress, double currentValue) {
        dispatch_async(dispatch_get_main_queue(), ^{
            hud.progress = currentValue;
        });
        NSLog(@"%@",[NSThread currentThread]);
    }];
}



@end
