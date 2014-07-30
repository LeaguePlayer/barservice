//
//  InitialSlidingViewController.m
//  barservice
//
//  Created by Leonid Minderov on 26.02.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "InitialSlidingViewController.h"
#import "AppDelegate.h"
#import "MWPhotoBrowser.h"

#import "NavigrationController.h"


@implementation InitialSlidingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
   
}


//-(NSUInteger)supportedInterfaceOrientations{
//
//    NSLog(@"%@",self.topViewController);
//    
//    if([self.topViewController isKindOfClass:[SeasonNavigationViewController class]])
//        return UIInterfaceOrientationMaskAll;
//    else return UIInterfaceOrientationMaskPortrait;
//
//    
//}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;

    
   
}



@end
