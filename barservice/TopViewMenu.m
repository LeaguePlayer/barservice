//
//  TopViewMenu.m
//  barservice
//
//  Created by Leonid Minderov on 15.04.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "TopViewMenu.h"

@implementation TopViewMenu
@synthesize min_height, max_height;
@synthesize selectedCategory;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        
        
        self.min_height = self.frame.size.height;
        //self.max_height += self.min_height;
        
        
        self.backgroundColor = [UIColor colorWithRed:0.969 green:0.969 blue:0.965 alpha:1.0];
        begin_height = self.min_height;
        
        
        UIImageView *bottomBorder=  [[UIImageView alloc] initWithFrame:CGRectMake(0, self.min_height, self.frame.size.width, 5)];
        [bottomBorder setImage:[UIImage imageNamed:@"sb"]];
        [self addSubview:bottomBorder];
        
        tick = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ellipse"]];
        
        tick.frame = CGRectMake((self.frame.size.width-tick.frame.size.width)/2, self.min_height, tick.frame.size.width, tick.frame.size.height);
        tick.userInteractionEnabled = NO;
        
        [self addSubview:tick];
        
        
        self.selectedCategory = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.frame.size.width, 16)];
        self.selectedCategory.text = @"Алкогольные напитки";
        self.selectedCategory.textColor = [UIColor colorWithRed:0.757 green:0.216 blue:0.11 alpha:1.0];
        self.selectedCategory.font = [UIFont systemFontOfSize:14.0f];
        self.selectedCategory.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.selectedCategory];
        
        
        
    }
    return self;
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    windowPoint = [tick convertPoint:tick.bounds.origin toView:self];
    
    if( (windowPoint.x <= point.x &&  point.x <= (windowPoint.x + tick.frame.size.width)) && (windowPoint.y <= point.y && point.y <= (windowPoint.y + tick.frame.size.height) ) )
    {
       
        return self;
    }
    
    
    return [super hitTest:point withEvent:event];
}

-(void)slideUp
{
    [UIView animateWithDuration:0.3 animations:^ {
        
        CGRect frame = self.frame;
        
        frame.size.height = begin_height;
        
        
        for( UIView *view in [self subviews] )
        {
            CGRect tmp_frame = view.frame;
            //tmp_frame.origin.y = self.max_height - tmp_frame.size.height - self.min_height;
            tmp_frame.origin.y = view.tag + frame.size.height - self.min_height;
            view.frame = tmp_frame;
            
        }
        
        
        
        self.frame = frame;
        
        
        
    }];
    
    [UIView animateWithDuration:0.3 animations:^ {
        
        
        [self.selectedCategory setAlpha:1.0f];
        
        
    }];
}

-(void)retagsViews
{
    for( UIView *view in [self subviews] )
    {
        view.tag = view.frame.origin.y;
        NSLog(@"%li",(long)view.tag);
    }
}



-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
   
    [super touchesMoved:touches withEvent:event];
    
    
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
    NSLog(@"%@",allTouches.description);
    CGPoint touchLocation = [touch locationInView:self];
    
    if(touchLocation.y > self.min_height)
    {
    
        CGRect frame = self.frame;
        
        
        if(touchLocation.y > self.max_height)
        {
            frame.size.height = self.max_height + ((touchLocation.y-self.max_height)/2);
            
    //        for( UIView *view in [self subviews] )
    //        {
    //            CGRect tmp_frame = view.frame;
    //            tmp_frame.origin.y -= touchLocation.y;
    //        }

        }
        else
        {
            frame.size.height = touchLocation.y;
            
            
        }
        
        
        
        self.frame = frame;
        
        for( UIView *view in [self subviews] )
        {
            CGRect tmp_frame = view.frame;
            
           // tmp_frame.origin.y = frame.size.height - self.min_height - tmp_frame.size.height;
            tmp_frame.origin.y = view.tag + frame.size.height - self.min_height;
           
            view.frame = tmp_frame;
            
        }
    }
    
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    start_y = self.frame.size.height;
    
    [UIView animateWithDuration:0.35 animations:^ {
        
        
        self.selectedCategory.alpha = 0;
        
        
    }];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
   
    
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
    CGPoint touchLocation = [touch locationInView:self];
    
    if( touchLocation.y > self.max_height )
    {
        [UIView animateWithDuration:0.3 animations:^ {
            
            CGRect frame = self.frame;
            
            if(touchLocation.y < start_y)
            {
                frame.size.height = begin_height;
                
                
            }
            else
            {
                frame.size.height = self.max_height;
            }
            
            for( UIView *view in [self subviews] )
            {
                CGRect tmp_frame = view.frame;
                //tmp_frame.origin.y = self.max_height - tmp_frame.size.height - self.min_height;
                 tmp_frame.origin.y = view.tag + frame.size.height - self.min_height;
                view.frame = tmp_frame;
                
            }
            
            
            
            self.frame = frame;
            
           
            
        }];
        
        
        if(begin_height == self.frame.size.height)
        {
            [UIView animateWithDuration:0.3 animations:^ {
                
                
                self.selectedCategory.alpha = 1;
                
                
            }];
        }
        
    }
    else{
        
        [UIView animateWithDuration:0.3 animations:^ {
            
             CGRect frame = self.frame;
            
            if(touchLocation.y > start_y)
            {
                frame.size.height = self.max_height;
            }
            else
            {
                frame.size.height = begin_height;
            }
            
            for( UIView *view in [self subviews] )
            {
                CGRect tmp_frame = view.frame;
               // tmp_frame.origin.y = frame.size.height - tmp_frame.size.height - self.min_height;
                
                tmp_frame.origin.y = view.tag + frame.size.height - self.min_height;
                view.frame = tmp_frame;
                
            }
            
           
            
            self.frame = frame;
            
        }];
        
        if(begin_height == self.frame.size.height)
        {
            [UIView animateWithDuration:0.3 animations:^ {
                
                
                self.selectedCategory.alpha = 1;
                
                
            }];
        }
        
    }
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
