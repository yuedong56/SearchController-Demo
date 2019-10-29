//
//  ViewController.m
//  SearchController-Demo
//
//  Created by yuedongkui on 2019/10/29.
//  Copyright © 2019 LY. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"点击弹出";
    [self.view addSubview:label];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[TableViewController new]];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
