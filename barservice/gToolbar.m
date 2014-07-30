//
//  gToolbar.m
//  barservice
//
//  Created by Leonid Minderov on 13.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "gToolbar.h"
#import "OrderGrannysController.h"

@implementation gToolbar

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        self.barStyle = UIBarStyleBlackTranslucent;
        [self sizeToFit];
        CGRect frame = self.frame;
        frame.size.height=30;
        self.frame = frame;
        //to make the done button(to hide the picker view) aligned to the right
        UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        
        
        
        
        [self setItems:[NSArray arrayWithObjects:flexibleSpaceLeft, nil]];
        
    }
    return self;
}

-(void)doneClicked:(id)sender
{
    [delegate doneClicked:sender];
    NSLog(@"in toolbar");
   
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
