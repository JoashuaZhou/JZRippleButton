//
//  JZRippleButton.m
//  JZRippleButton
//
//  Created by Joshua Zhou on 14/11/4.
//  Copyright (c) 2014年 Joshua Zhou. All rights reserved.
//

#import "JZRippleButton.h"

@interface JZRippleButton ()

@property (nonatomic, weak) NSTimer *timer;

@end

@implementation JZRippleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self addGestureRecognizers];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupUI];
        [self addGestureRecognizers];
    }
    return self;
}

- (void)setupUI
{
    self.borderColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.7];
    self.borderWidth = 5.0;
    
    self.rippleRadius = 2.5;
    [self updateUI];
}

- (void)updateUI
{
    self.layer.borderColor = self.borderColor.CGColor;
    self.layer.borderWidth = self.borderWidth;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.cornerRadius = self.bounds.size.width / 2;
}

- (void)addGestureRecognizers
{
    /* 类微信讲话按钮 */
    [self addTarget:self action:@selector(touchButtonBegin) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(touchButtonEnd) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(touchButtonEnd) forControlEvents:UIControlEventTouchUpOutside];
}

- (void)touchButtonBegin{
    self.timer = [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                  target: self
                                                selector: @selector(handleTimer)
                                                userInfo: nil
                                                 repeats: YES];
    [self.timer fire];
}

- (void)touchButtonEnd{
    [self.timer invalidate];
}

- (void)handleTimer{
    [self generateRipples];
    [self performSelector:@selector(generateRipples) withObject:nil afterDelay:0.25];
}

- (void)generateRipples
{
    CGRect pathFrame = CGRectMake(-CGRectGetMidX(self.bounds), -CGRectGetMidY(self.bounds), self.bounds.size.width, self.bounds.size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathFrame cornerRadius:self.layer.cornerRadius];
    CAShapeLayer *circleShape = [[CAShapeLayer alloc] init];
    circleShape.path = path.CGPath;
    circleShape.position = self.center;
    circleShape.opacity = 0;
    circleShape.fillColor = [UIColor clearColor].CGColor;
    circleShape.strokeColor = self.borderColor.CGColor;
    circleShape.lineWidth = self.borderWidth;
    
    //    CAShapeLayer *circleShape = [CAShapeLayer layer];
    //    circleShape.path = path.CGPath;
    //    circleShape.position = shapePosition;       // circleShape放在self.center，其实这里不需要shapePosition转换也行
    //    circleShape.fillColor = [UIColor clearColor].CGColor;
    //    circleShape.opacity = 0;
    //    circleShape.strokeColor = self.borderColor.CGColor;
    //    circleShape.lineWidth = 2.0;    // CAShapeLayer的@property，这里设置borderWidth无效
    
    [self.superview.layer addSublayer:circleShape];
    
    CABasicAnimation *scaleAnimation = [[CABasicAnimation alloc] init];
    scaleAnimation.keyPath = @"transform.scale";
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(self.rippleRadius, self.rippleRadius, 1.0)];
    
    CABasicAnimation *alphaAnimation = [[CABasicAnimation alloc] init];
    alphaAnimation.keyPath = @"opacity";
    alphaAnimation.fromValue = @(1);
    alphaAnimation.toValue = @(0);
    
    CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc] init];
    animationGroup.duration = 1.0;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animationGroup.animations = @[scaleAnimation, alphaAnimation];
    [circleShape addAnimation:animationGroup forKey:nil];
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    [self updateUI];
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    [self updateUI];
}

@end
