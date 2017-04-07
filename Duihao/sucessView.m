//
//  sucessView.m
//  Duihao
//
//  Created by lidongfang on 17/4/6.
//  Copyright © 2017年 lidongfang. All rights reserved.
//

#import "sucessView.h"

@implementation sucessView
{
    UIView *_logoView;
}
//- (void)drawRect:(CGRect)rect
//{
//    [[UIColor blackColor]setFill];
//    UIRectFill(CGRectMake(20, 200, 100, 50));
//}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
      [self drawSuccessLine];
        
    }
    return self;
}

- (void)drawSuccessLine{
    NSMutableArray *pointsArray=[[NSMutableArray alloc]init];
    [_logoView removeFromSuperview];
    _logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    //曲线圆建立开始点和结束点
    /*
    1. 曲线的中心
    2. 曲线半径
    3. 开始角度
    4. 结束角度
    5. 顺/逆时针方向
     */
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_logoView.center.x, _logoView.center.y) radius:_logoView.frame.size.width/2.0 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    //对拐角和中点处理
    path.lineCapStyle  = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    //对号第一部分直线的起始
    /*
     开始起始点的位置
     */
    CGPoint startPoint=CGPointMake(_logoView.frame.size.width/5.0, self.frame.size.width/2.0);
    CGPoint p1 = CGPointMake(self.frame.size.width/5.0*2, self.frame.size.width/2.0*(1.5));
    //对号第二部分起始
    CGPoint p2 = CGPointMake(self.frame.size.width/5.0*5, self.frame.size.width/5.0);
    [pointsArray addObject:[NSValue valueWithCGPoint:p1]];
    [pointsArray addObject:[NSValue valueWithCGPoint:p2]];
    
    [path moveToPoint:startPoint];
    //////// 可以实现多个折线图的构建  ！！！！！！！
    for (int index=0; index<pointsArray.count; index++) {
        NSValue *pointValue=pointsArray[index];
        [path addLineToPoint:pointValue.CGPointValue];
    }
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    //内部填充颜色
    layer.fillColor = [UIColor clearColor].CGColor;
    //线条颜色
    layer.strokeColor = [UIColor whiteColor].CGColor;
    //线条宽度
    layer.lineWidth = 3;
    layer.path = path.CGPath;
    //动画设置
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 2;
    [layer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
    
    [_logoView.layer addSublayer:layer];
    [self addSubview:_logoView];
}

@end
