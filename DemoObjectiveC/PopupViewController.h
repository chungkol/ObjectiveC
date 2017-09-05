//
//  PopupViewController.h
//  DemoObjectiveC
//
//  Created by ChungVT on 9/1/17.
//  Copyright © 2017 ChungVT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXBlurView.h"
@protocol AVPopupViewControllerDelegate <NSObject>
- (void) popupViewDidCallBack: (id)sender ;
@end
@interface PopupViewController : UIView
@property (nonatomic, strong) id<AVPopupViewControllerDelegate> delegate;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) FXBlurView *viewBlurView;
@property (nonatomic, strong) UIView *viewBackgroundColor;
- (instancetype)initWithCoder:(NSCoder *)aDecoder;
- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype) initWithNib;

- (UIView *) loadViewFromNib;

- (void) setupViewWithNib;

- (CGRect) calculatingViewFrame: (CGRect)viewFrame sourceFrame: (CGRect) sourceFrame;

- (void) initBackgroundColorTriggerView;
- (UIView *) initBlurView;
- (void) show;
- (void) dismissView;
- (void) dismissViewWithObject: (NSObject *) objetc;
//data
@end
