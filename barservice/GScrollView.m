//
//  GScrollView.m
//  barservice
//
//  Created by Leonid Minderov on 15.04.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "GScrollView.h"
#import "TopViewMenu.h"

@implementation GScrollView

- (id)initWithFrame:(CGRect)frame
{
    NSLog(@"init CGSCROLLVIEW");
    return [super initWithFrame:frame];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"move scroll");
    [[self.nextResponder nextResponder] touchesMoved:touches withEvent:event];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    
    id a = [super hitTest:point withEvent:event];
   NSLog(@"");
    
    if([a isKindOfClass:[TopViewMenu class]])
    {
        self.scrollEnabled = NO;
    }
    else
    {
        self.scrollEnabled = YES;
    }
    
        return [super hitTest:point withEvent:event];
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
