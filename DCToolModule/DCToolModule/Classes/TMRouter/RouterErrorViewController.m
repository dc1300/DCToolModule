//
//  RouterErrorViewController.m
//  MTRouterDemo
//
//  Created by zhoujunchun on 2018/7/12.
//  Copyright © 2018年 董徐维. All rights reserved.
//

#import "RouterErrorViewController.h"
#import "UIImage+Image.h"

@interface RouterErrorViewController ()

@end

@implementation RouterErrorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *backBt = [[UIButton alloc]initWithFrame:CGRectMake(12, 44, 40, 40)];
    [backBt setImage:[UIImage ff_imagePathWithName:@"close" bundle:@"PRBaseDependBundle" targetClass:[self class]] forState:UIControlStateNormal];
    [backBt addTarget:self action:@selector(leftBarButtonNavBar) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBt];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-100)*0.5, (self.view.frame.size.height-100)*0.5, 100, 100)];
    imageView.image = [UIImage ff_imagePathWithName:@"close" bundle:@"errorFind" targetClass:[self class]];
    [self.view addSubview:imageView];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height-100)*0.5+120, self.view.frame.size.width, 20)];
    label.text = @"未找到当前页面";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}


- (void) leftBarButtonNavBar {
    
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            //push方式
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else{
        //present方式
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}


@end
