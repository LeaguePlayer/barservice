//
//  gBarButtonItem.m
//  barservice
//
//  Created by Leonid Minderov on 13.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "gBarButtonItem.h"

@implementation gBarButtonItem

-(id)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action
{
    self = [super initWithTitle:title style:style target:target action:action];
    if(self){
        [self setTitleTextAttributes:@{
                                       NSFontAttributeName: [UIFont systemFontOfSize:13.0f],
                                       NSForegroundColorAttributeName: [UIColor blackColor]
                                       } forState:UIControlStateNormal];
        
       
    }
    return self;
}

@end
