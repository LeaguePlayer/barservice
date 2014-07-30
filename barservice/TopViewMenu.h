//
//  TopViewMenu.h
//  barservice
//
//  Created by Leonid Minderov on 15.04.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopViewMenu : UIView
{
    float begin_height;
    
    float start_y;
    
    CGPoint windowPoint;
    UIImageView *tick;
    
   
}


@property (nonatomic) float max_height;
@property (nonatomic) float min_height;
@property (nonatomic, retain) UILabel *selectedCategory;


-(void)retagsViews;

-(void)slideUp;

@end
