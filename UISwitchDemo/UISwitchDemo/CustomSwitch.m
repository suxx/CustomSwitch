//
//  CustomSwitch.m
//  UISwitchDemo
//
//  Created by suxx on 2017/7/27.
//  Copyright © 2017年 suxx. All rights reserved.
//

#import "CustomSwitch.h"


@interface CustomSwitch()
@property (nonatomic,assign) BOOL isON;//标识开关的状态
@end

@implementation CustomSwitch
{
    UIView *round;
    UIImageView *bgImgView;
}



-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        //注册观察者监听isON
        [self addObserver:self forKeyPath:@"isON" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
        [self addTarget:self action:@selector(translateAni) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(scaleAni) forControlEvents:UIControlEventTouchDown];
        [self createView];
    }
    return self;
}

- (void)createView
{
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    self.layer.cornerRadius = self.bounds.size.height/2;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 1;
    
    bgImgView = [[UIImageView alloc]initWithFrame:self.bounds];
    bgImgView.image = self.bgImg?self.bgImg:[UIImage imageNamed:@"switchBg"];//设置背景图片
    bgImgView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:bgImgView];
    
    //圆形滑块
    round = [[UIView alloc]initWithFrame:CGRectMake(0, 1, self.bounds.size.height-2, self.bounds.size.height-2)];
    round.layer.cornerRadius = self.bounds.size.height/2;
    round.backgroundColor = [UIColor whiteColor];
    round.userInteractionEnabled = NO;
    [self addSubview:round];
    round.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    round.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    round.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    round.layer.shadowRadius = 2;//阴影半径，默认3
    
}

//on set与get
-(void)setON:(BOOL)ON
{
    if (ON) {
        self.layer.borderWidth = 0;
        bgImgView.alpha = 1;
        round.frame = CGRectMake(self.bounds.size.width-round.bounds.size.width-1, 1, self.bounds.size.height-2, self.bounds.size.height-2);
    }else{
        self.layer.borderWidth = 1;
        bgImgView.alpha = 0;
        round.frame = CGRectMake(0, 1, self.bounds.size.height-2, self.bounds.size.height-2);
    }
    self.isON = ON;
}

-(BOOL)ON{
    return self.isON;
}

//动画设置
-(void)translateAni{
    
    CGRect rect = round.frame;
    rect.size.width -= 5;
    [UIView animateWithDuration:0.3 animations:^{
        round.frame = rect;
    }];

    CGFloat borderWidth = 0;
    CGFloat alpha = 0;
    if (!self.isON) {
        rect.origin.x = self.bounds.size.width-round.bounds.size.width-1;
        borderWidth = 0;
        alpha = 1;

    }else
    {
        rect.origin.x = 0;
        borderWidth = 1;
        alpha = 0;
    }
    [UIView animateWithDuration:0.3 animations:^{
        round.frame = rect;
        bgImgView.alpha = alpha;
        if (borderWidth==1) {
            self.layer.borderWidth = borderWidth;
        }
    }completion:^(BOOL finished) {
        if (borderWidth==0) {
            self.layer.borderWidth = borderWidth;
        }
    }];
    
    self.isON = !self.isON;

}

-(void)scaleAni
{
    CGRect rect = round.frame;
    rect.size.width += 5;
    
    if(self.isON){
        rect.origin.x -= 5;
    }

    [UIView animateWithDuration:0.3 animations:^{
        round.frame = rect;
    }];

}

//监听isON
//keyPath:属性名称
//object:被观察的对象
//change:变化前后的值都存储在change字典中
//context:注册观察者时，context传过来的值
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"isON"];
}

@end
