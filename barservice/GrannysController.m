//
//  GrannysController.m
//  barservice
//
//  Created by Leonid Minderov on 06.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "GrannysController.h"
#import "NavigrationController.h"

@interface GrannysController ()

@end

@implementation GrannysController
@synthesize myBrowser;



- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"WORK!");
    
    [super viewWillAppear:animated];
    
    NavigrationController *navCon = (NavigrationController *)self.navigationController;

    
    // работаем с кнопкой МЕНЮ
    UIButton *btnMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    btnMenu.frame = CGRectMake(0, 0, 22, 18);
    [btnMenu setImage:[UIImage imageNamed:@"menu_button"] forState:UIControlStateNormal];
    [btnMenu addTarget:self action:@selector(showLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    [navCon.leftBarButtonItem setCustomView:btnMenu];

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
	// Do any additional setup after loading the view.
}

-(void)goToHome
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)showLeftMenu
{
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
