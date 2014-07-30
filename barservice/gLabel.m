//
//  gLabel.m
//  barservice
//
//  Created by Leonid Minderov on 13.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "gLabel.h"

@implementation gLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
       
        self.font = [UIFont systemFontOfSize:14.0f];
        self.backgroundColor = [UIColor clearColor];
        
        self.textColor = [UIColor colorWithRed:0.286 green:0.259 blue:0.227 alpha:1.0];
        
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
