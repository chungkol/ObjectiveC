//
//  PopupView.m
//  DemoObjectiveC
//
//  Created by ChungVT on 9/1/17.
//  Copyright © 2017 ChungVT. All rights reserved.
//

#import "PopupView.h"

@implementation PopupView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)actionDimiss:(UIButton *)sender {
    [self.delegate dimiss:sender];
}

@end
