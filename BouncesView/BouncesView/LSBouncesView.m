//
//  LSBouncesView.m
//  BouncesView
//
//  Created by liaoshen on 2021/4/8.
//

#import "LSBouncesView.h"

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@implementation LSBouncesView

- (void)setPoint:(CGPoint)point{
    _point = point;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    if (CGPointEqualToPoint(CGPointZero, self.point)) {
        return;
    }
    
    /// 贝塞尔曲线的画法是由起点、终点、控制点三个参数来画的
    CGPoint startPoint = CGPointMake(rect.size.width, 0);
    CGPoint endPoint   = CGPointMake(rect.size.width, self.frame.size.height);
    CGPoint controlPoint   = CGPointMake(rect.size.width+self.point.x, self.point.y);
    if (!_bezierPath) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        _bezierPath = path;
    }
    [_bezierPath removeAllPoints];
    [_bezierPath moveToPoint:startPoint];
    [_bezierPath addQuadCurveToPoint:endPoint controlPoint:controlPoint];
    [_bezierPath closePath];
    //一个不透明类型的Quartz 2D绘画环境, 相当于一个画布 你可以在上面任意绘制
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, _bezierPath.CGPath);
    [RGBACOLOR(210,177,246,1) set];
    CGContextFillPath(context);
}


@end
