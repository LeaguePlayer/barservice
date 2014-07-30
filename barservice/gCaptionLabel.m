//
//  gCaptionLabel.m
//  barservice
//
//  Created by Leonid Minderov on 17.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "gCaptionLabel.h"

@implementation gCaptionLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.textColor = [UIColor colorWithRed:0.757 green:0.216 blue:0.11 alpha:1.0];
        self.font = [UIFont boldSystemFontOfSize:14.0];
        self.backgroundColor = [UIColor clearColor];
        self.lineBreakMode = NSLineBreakByWordWrapping;
        self.numberOfLines = 0;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
