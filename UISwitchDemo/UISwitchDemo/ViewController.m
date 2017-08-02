//
//  ViewController.m
//  UISwitchDemo
//
//  Created by suxx on 2017/7/27.
//  Copyright © 2017年 suxx. All rights reserved.
//

#import "ViewController.h"
#import "CustomSwitch.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CustomSwitch *swi = [[CustomSwitch alloc]initWithFrame:CGRectMake(100, 200, 60, 30)];
    swi.ON = YES;
    swi.bgImg = [UIImage imageNamed:@"switchBg"];
    [self.view addSubview:swi];
    [swi addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)valueChanged:(CustomSwitch *)sender{
    NSLog(@"%d",sender.ON);
}

@end
