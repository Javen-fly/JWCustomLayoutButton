//
//  ViewController.m
//  JWCustomLayoutButtonDemo
//
//  Created by 吴建文 on 2018/1/10.
//  Copyright © 2018年 Javen. All rights reserved.
//

#import "ViewController.h"
#import "JWCustomLayoutButton.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    JWCustomLayoutButton *button = [JWCustomLayoutButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"icon_tabbar_home~iphone"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitle:@"a" forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 100, 200, 200);
    [button setBackgroundColor:[UIColor orangeColor]];
    [button setIconInTopWithSpacing:10];
    button.imageView.backgroundColor = [UIColor whiteColor];
    button.titleLabel.backgroundColor = [UIColor greenColor];
    button.textOverflowHidden = YES;
    [self.view addSubview:button];
    
    UIView *verticalLine = [[UIView alloc]init];
    verticalLine.backgroundColor = [UIColor whiteColor];
    verticalLine.bounds = CGRectMake(0, 0, 1, 300);
    verticalLine.center = button.center;
    [self.view addSubview:verticalLine];
    
    UIView *verticalLine2 = [[UIView alloc]init];
    verticalLine2.backgroundColor = [UIColor whiteColor];
    verticalLine2.bounds = CGRectMake(0, 0, 300, 1);
    verticalLine2.center = button.center;
    [self.view addSubview:verticalLine2];}


@end
