//
//  GalleryPartybusController.m
//  barservice
//
//  Created by Leonid Minderov on 27.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "GalleryPartybusController.h"
#import "NavigrationController.h"

@interface GalleryPartybusController ()

@end

@implementation GalleryPartybusController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // работаем с API
    self.apiString = [NSString stringWithFormat:@"%@/json/getgallery/site/partybus",domain_server_api];
    [self startAPI];
}


-(void)completeApi
{
    // NSLog(@"%@",[[self.gotDataAPI objectForKey:@"response"] objectForKey:@"thumb"]);
    
    [self buildContent];
}

-(void)buildContent
{
    // [self setGalleryImages:[self.gotDataAPI objectForKey:@"response"]];
    [self setphotosForGallery:[self.gotDataAPI objectForKey:@"response"]];
    
    
    UIView *photosInView = [self loadGallery];
    
    UIView *backgroundGrannys = [self makeMainBackgroundwithBorder:NO andHeightIs:photosInView.frame.size.height+(photosInView.frame.origin.y*2) andSwitchType:@"partybus"];
    UIView *buttonReserve = [self makeReserveButtonByPositionAtY:backgroundGrannys.frame.size.height-50 andAction:@"goToReserveController" withTitle:@"Заказать Party Bus"];
    
    [backgroundGrannys addSubview:photosInView];
    [self.viewScroll addSubview:buttonReserve];
    [self.viewScroll addSubview:backgroundGrannys];
    
    
    
    [self.viewScroll setContentSize:CGSizeMake(self.viewScroll.frame.size.width, backgroundGrannys.frame.size.height+60)];
}


-(void)goToReserveController
{
    NSString *identifier = @"p_order";
    
    
    
    
    UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    
    NavigrationController *tVC = ((NavigrationController *)self.slidingViewController.topViewController);
    NSArray * viewControllers = [tVC viewControllers];
    NSArray * newViewControllers = [NSArray arrayWithObjects:[viewControllers objectAtIndex:0],
                                    newTopViewController,nil];
    [tVC setViewControllers:newViewControllers animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
