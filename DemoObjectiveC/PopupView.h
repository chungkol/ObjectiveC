//
//  PopupView.h
//  DemoObjectiveC
//
//  Created by ChungVT on 9/1/17.
//  Copyright © 2017 ChungVT. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PopupDelegate <NSObject>
- (void) dimiss: (UIButton *)sender ;
@end
@interface PopupView : UIView
@property (nonatomic, strong) id<PopupDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *contentView;

-(instancetype)initWithCoder:(NSCoder *)aDecoder;
-(instancetype)init;
@end
