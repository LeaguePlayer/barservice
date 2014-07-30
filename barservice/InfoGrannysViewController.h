//
//  InfoGrannysViewController.h
//  barservice
//
//  Created by Leonid Minderov on 05.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GrannysController.h"

@interface InfoGrannysViewController : GrannysController <UIWebViewDelegate>
{
    float top_postion;
    UITextView *textView;

}

@property (strong, nonatomic) UIScrollView *scrollGallery;

@end
