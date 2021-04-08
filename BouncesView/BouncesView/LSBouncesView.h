//
//  LSBouncesView.h
//  BouncesView
//
//  Created by liaoshen on 2021/4/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSBouncesView : UIView
@property (nonatomic, assign) CGPoint point;

@property (nonatomic, strong) UIBezierPath *bezierPath;
@end

NS_ASSUME_NONNULL_END
