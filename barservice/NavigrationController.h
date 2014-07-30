//
//  NavigrationController.h
//  barservice
//
//  Created by Leonid Minderov on 26.02.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+ECSlidingViewController.h"


@interface NavigrationController : UINavigationController
{
    UIBarButtonItem *rightBarButtonItem;
    UIBarButtonItem *leftBarButtonItem;
}

@property (nonatomic, retain) UIBarButtonItem *rightBarButtonItem;
@property (nonatomic, retain) UIBarButtonItem *leftBarButtonItem;



@end
