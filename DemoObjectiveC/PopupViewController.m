//
//  PopupViewController.m
//  DemoObjectiveC
//
//  Created by ChungVT on 9/1/17.
//  Copyright © 2017 ChungVT. All rights reserved.
//

#import "PopupViewController.h"
#import "PopupView.h"
const CGFloat AVPopupViewMaxSize = 0.9;
const CGFloat constantHeightMultiple = 0.8;
const CGFloat constantWidthMultiple = 0.8;
//#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
@interface PopupViewController () <PopupDelegate>

@end
@implementation PopupViewController

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame: [UIScreen mainScreen].bounds])) {
    }
    return self;
}
- (instancetype)initWithNib{
    PopupViewController *popup = [[PopupViewController alloc] init];
    [popup setupViewWithNib];
    
    return popup;
}
- (void) setupViewWithNib{
    self.containerView = [self loadViewFromNib];
    [self initBackgroundColorTriggerView];
    [self addSubview:self.containerView];
}

- (UIView *)loadViewFromNib {
    PopupView *view = [[NSBundle mainBundle] loadNibNamed:@"PopupView" owner:self options:nil].firstObject;
    view.delegate = self;
    [view layoutIfNeeded];
    view.frame = [self calculatingViewFrame:self.frame sourceFrame: view.contentView.frame];
    view.center = CGPointMake(self.center.x, self.center.y - self.frame.size.height);
    view.layer.cornerRadius = 6.0;
    view.clipsToBounds = true;
    return view;
}

- (CGRect)calculatingViewFrame:(CGRect)viewFrame sourceFrame:(CGRect)sourceFrame {
    CGRect newRect = CGRectZero;
    CGFloat transformWidthValue = 1.0;
    CGFloat transformHeightValue = 1.0;
    CGFloat heightValue  = sourceFrame.size.height;
    CGFloat widthValue = sourceFrame.size.width;
    
    
    if(heightValue >= viewFrame.size.height * constantHeightMultiple) {
        transformHeightValue = AVPopupViewMaxSize;
        heightValue = viewFrame.size.height;
    }
    if(widthValue >= viewFrame.size.width * constantWidthMultiple) {
        transformWidthValue = AVPopupViewMaxSize;
        widthValue = viewFrame.size.width;
    }
    CGAffineTransform transform = CGAffineTransformMake(transformWidthValue, 0, 0, transformHeightValue, 0, 0);
    return CGRectApplyAffineTransform(CGRectMake(0, 0, widthValue, heightValue), transform);

}
-(void)initBackgroundColorTriggerView {
    self.viewBackgroundColor = [[UIView alloc] initWithFrame:self.frame];
    self.viewBackgroundColor.backgroundColor = [UIColor darkGrayColor];
    self.viewBackgroundColor.alpha = 0.3;
    [self.viewBackgroundColor addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)]];
}
//init blur effect view
-(UIView *)initBlurView {
    self.viewBlurView = [[FXBlurView alloc] initWithFrame: [UIScreen mainScreen].bounds];
    self.viewBlurView.tintColor = [UIColor darkGrayColor];
    self.viewBlurView.blurRadius = 35.0;
    return self.viewBlurView;
}

-(void)show {
    UIWindow *window = UIApplication.sharedApplication.delegate.window;
    self.frame = [UIScreen mainScreen].bounds;
    [window addSubview:[self initBlurView]];
    [window addSubview:self];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.containerView.center = self.center;
    } completion:nil];
}
-(void)dismissView {
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.containerView.center = CGPointMake(self.center.x, self.center.y + self.frame.size.height);
    } completion:nil];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.viewBlurView.alpha = 0.0;

    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.viewBlurView removeFromSuperview];
    }];
}
- (void)dismissViewWithObject:(NSObject *)objetc {
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.containerView.center = CGPointMake(self.center.x, self.center.y + self.frame.size.height);
    } completion:nil];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.viewBlurView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.viewBlurView removeFromSuperview];
        [self.delegate popupViewDidCallBack:objetc];
    }];

}
//MARK: PopupDelegate
-(void)dimiss:(UIButton *)sender {
    [self dismissView];
}
@end

