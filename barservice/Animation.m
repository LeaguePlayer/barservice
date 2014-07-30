//
//  Animation.m
//  barservice
//
//  Created by Leonid Minderov on 05.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "Animation.h"

#define imagesForGallery @[@"i1.jpg", @"i2.jpg", @"i3.jpg", @"i4.jpg", @"i5.jpg"]
#define interval_for_wait 8.0
#define interval_animate 0.90

@implementation Animation
@synthesize view;

static int index_for_hide = 1;
static int index_for_show = 0;

-(void)fadeView:(UIView *)thisView fadeOut:(BOOL)fadeOut {
    //   self.ReviewViewController.view.alpha = 1;
    
    
  
    
    [UIView beginAnimations:@"fadeOut" context:nil];
    [UIView setAnimationDuration:interval_animate];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(afterAnimationStops)];
    
    if (fadeOut) {
        thisView.alpha = 0;
    } else {
        thisView.alpha = 1;
    }
    
    [UIView commitAnimations];
}

-(void)afterAnimationStops{
    int index_for_new_image = [self generateRandomIndex];
    
    UIImageView *getImageViewForShow = [self.view.subviews objectAtIndex:index_for_show];
    UIImageView *getImageViewForHide = [self.view.subviews objectAtIndex:index_for_hide];
    getImageViewForHide.image = [UIImage imageNamed:[imagesForGallery objectAtIndex:index_for_new_image]];
   
    
    
    if(ticks%2==0)
        index_for_image_2 = index_for_new_image;
    else
        index_for_image_1 = index_for_new_image;
    
    [self.view bringSubviewToFront:getImageViewForShow];
}

-(void)buildImageView
{
    index_for_image_1 = [self generateRandomIndex];
   
    index_for_image_2 = [self generateRandomIndex];
   
    
    UIImageView *firstLayout = [[UIImageView alloc] initWithFrame:[self.view bounds]];
    UIImageView *secondLayout = [[UIImageView alloc] initWithFrame:[self.view bounds]];
    secondLayout.alpha = 0;
    
    firstLayout.image = [UIImage imageNamed:[imagesForGallery objectAtIndex:index_for_image_1]];
    secondLayout.image = [UIImage imageNamed:[imagesForGallery objectAtIndex:index_for_image_2]];
    
    [self.view addSubview:secondLayout];
    [self.view addSubview:firstLayout];
   
}

-(float) randFloatBetween:(float)low and:(float)high
{
    float diff = high - low;
    return (((float) rand() / RAND_MAX) * diff) + low;
}

-(int)generateRandomIndex
{
    int used_index_1 = index_for_image_1;
    int used_index_2 = index_for_image_2;
    
   
    
    int smallest = 1;
    int largest = (int)[imagesForGallery count];
    int random = (smallest + arc4random() %(largest+1-smallest))-1;
    
    //NSLog(@"work function");
    
    if(random==used_index_1 || random==used_index_2)
        return [self generateRandomIndex];
    else
        return random;
    
    
    
  
}

-(void)startAnimation
{
    ticks = 0;
    if([self.view.subviews count] == 0)
    {
        [self buildImageView];
    }
    
    [NSTimer scheduledTimerWithTimeInterval:interval_for_wait
                                     target:self
                                   selector:@selector(nextSlide)
                                   userInfo:nil
                                    repeats:YES];
    
}

-(void)nextSlide
{
   
    
    UIImageView *getImageViewForHide;
    UIImageView *getImageViewForShow;
   
    
   
    
    getImageViewForShow = [self.view.subviews objectAtIndex:index_for_show];
    getImageViewForShow.alpha = 1;
    
    getImageViewForHide = [self.view.subviews objectAtIndex:index_for_hide];
    [self fadeView:getImageViewForHide fadeOut:YES];
//    getImageViewForHide.alpha = 0;
//    int index_for_new_image = [self generateRandomIndex];
//    
//   
//    getImageViewForShow.image = [UIImage imageNamed:[imagesForGallery objectAtIndex:index_for_new_image]];
//    if(ticks%2==0)
//        index_for_image_2 = index_for_new_image;
//    else
//        index_for_image_1 = index_for_new_image;
//    
//    [self.view bringSubviewToFront:getImageViewForShow];
    
    ticks++;
}

@end
