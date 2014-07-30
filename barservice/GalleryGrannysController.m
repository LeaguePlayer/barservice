//
//  GalleryGrannysController.m
//  barservice
//
//  Created by Leonid Minderov on 07.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "GalleryGrannysController.h"
#import "NavigrationController.h"



@interface GalleryGrannysController ()

@end

@implementation GalleryGrannysController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NavigrationController *navCon = (NavigrationController *)self.navigationController;
    UIButton *btnMenu = (UIButton*)[navCon.rightBarButtonItem customView];
    UIImageView *ivv = (UIImageView*)[btnMenu imageView];
    [ivv setImage:[UIImage imageNamed:@"black_home"]];
    
    
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // работаем с API
    self.apiString = [NSString stringWithFormat:@"%@/json/getgallery/site/grannys",domain_server_api];
    [self startAPI];
    
    
    
    
    
   // [self.navigationItem setHidesBackButton:YES animated:YES];
	// Do any additional setup after loading the view.
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
    
    UIView *backgroundGrannys = [self makeMainBackgroundwithBorder:YES andHeightIs:photosInView.frame.size.height+(photosInView.frame.origin.y*2) andSwitchType:@"grannys"];
    UIView *buttonReserve = [self makeReserveButtonByPositionAtY:backgroundGrannys.frame.size.height-50 andAction:@"goToReserveController" withTitle:@"Заказать столик"];
    
    [backgroundGrannys addSubview:photosInView];
    [self.viewScroll addSubview:buttonReserve];
    [self.viewScroll addSubview:backgroundGrannys];
    
    
    
    [self.viewScroll setContentSize:CGSizeMake(self.viewScroll.frame.size.width, backgroundGrannys.frame.size.height+60)];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
