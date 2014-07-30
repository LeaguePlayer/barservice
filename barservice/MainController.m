//
//  MainController.m
//  barservice
//
//  Created by Leonid Minderov on 05.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "MainController.h"
#import "Animation.h"

@interface MainController ()

@end

@implementation MainController
@synthesize galleryView;
@synthesize buttonToIceMan, buttonToBarService, buttonToGrannys, buttonToPartyBus;

- (void)viewWillAppear:(BOOL)animated
{
    NSString *navigationBarImageName = [[NSString alloc] init];
    
    // меняем навигационный бар
    if(IS_IPAD)
    {
        navigationBarImageName = @"big_navbar";
    }
    else
    {
        navigationBarImageName = @"navbar";
    }
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:navigationBarImageName] forBarMetrics:UIBarMetricsDefault];
    
    
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:0.286 green:0.259 blue:0.227 alpha:1], NSFontAttributeName : [UIFont systemFontOfSize:21.0]};

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // запускаем анимацию центральной картинки
    Animation *gallery = [[Animation alloc] init];
    gallery.view = galleryView;
    [gallery startAnimation];
    
    
    //// кидаем событие для перехода по направлениям
    
    
    // для grannys
    UITapGestureRecognizer *singleFingerTap1 =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(goToGrannys)];
    [buttonToGrannys addGestureRecognizer:singleFingerTap1];
    
    // для bar service
    UITapGestureRecognizer *singleFingerTap2 =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(goToBarservice)];
    [buttonToBarService addGestureRecognizer:singleFingerTap2];
    
    // для partybus
    UITapGestureRecognizer *singleFingerTap3 =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(goToPartybus)];
    [buttonToPartyBus addGestureRecognizer:singleFingerTap3];
    
    // для iceman
    UITapGestureRecognizer *singleFingerTap4 =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(goToIceMan)];
    [buttonToIceMan addGestureRecognizer:singleFingerTap4];
    
    
    
}


- (void)goToGrannys
{
    NSString *identifier = @"grannys";
    UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    [self.navigationController pushViewController:newTopViewController animated:YES];
}

- (void)goToBarservice
{
    NSString *identifier = @"barservice";
    UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    [self.navigationController pushViewController:newTopViewController animated:YES];
}

- (void)goToPartybus
{
    NSString *identifier = @"partybus";
    UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    [self.navigationController pushViewController:newTopViewController animated:YES];
}

- (void)goToIceMan
{
    NSString *identifier = @"iceman";
    UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    [self.navigationController pushViewController:newTopViewController animated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
