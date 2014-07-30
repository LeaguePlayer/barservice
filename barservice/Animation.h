//
//  Animation.h
//  barservice
//
//  Created by Leonid Minderov on 05.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Animation : NSObject
{
    UIView *view;
    NSArray *galleryImages;
    
    int index_for_image_1;
    int index_for_image_2;
    
    int ticks;
}

@property (nonatomic, retain) UIView *view;

-(void)fadeView:(UIView *)thisView fadeOut:(BOOL)fadeOut;
-(void)startAnimation;

@end
