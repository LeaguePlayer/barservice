//
//  NavigrationController.m
//  barservice
//
//  Created by Leonid Minderov on 26.02.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "NavigrationController.h"
#import "GrannysController.h"

@interface UIBarButtonItem (NegativeSpacer)
+(UIBarButtonItem*)negativeSpacerWithWidth:(NSInteger)width;
@end
@implementation UIBarButtonItem (NegativeSpacer)
+(UIBarButtonItem*)negativeSpacerWithWidth:(NSInteger)width {
    UIBarButtonItem *item = [[UIBarButtonItem alloc]
                             initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                             target:nil
                             action:nil];
    item.width = (width >= 0 ? -width : width);
    return item;
}
@end

@interface NavigrationController ()

@end

@implementation NavigrationController
@synthesize rightBarButtonItem, leftBarButtonItem;



-(void)transitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL))completion
{
    NSLog(@"YEAH!");
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    
    
     [self makeButtonGoHome:[self.viewControllers count]-1];

}


-(void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated
{
    [super setViewControllers:viewControllers animated:animated];
    
    
    [self makeButtonGoHome:[self.viewControllers count]-1];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    rightBarButtonItem = [[UIBarButtonItem alloc] init];
    leftBarButtonItem = [[UIBarButtonItem alloc] init];
    
}

-(void)makeButtonGoHome:(NSInteger)getIndex
{
    [self.viewControllers enumerateObjectsUsingBlock:^(UINavigationController *navigationController, NSUInteger idx, BOOL *stop) {
        
        
      
        UIViewController *rootViewController = [self.viewControllers objectAtIndex:getIndex];
        
        if([rootViewController isKindOfClass:[GrannysController class]])
        {
            NSLog(@"ITS GRANNYS BE SURE!");
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 0, 21, 21);
            [btn setImage:[UIImage imageNamed:@"black_home"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(goToHome) forControlEvents:UIControlEventTouchUpInside];
            [rightBarButtonItem setCustomView:btn];
            rootViewController.navigationItem.rightBarButtonItem = rightBarButtonItem;
        }
        else
        {
            NSLog(@"here no grannys");
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 0, 21, 21);
            [btn setImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(goToHome) forControlEvents:UIControlEventTouchUpInside];
            [rightBarButtonItem setCustomView:btn];
            rootViewController.navigationItem.rightBarButtonItem = rightBarButtonItem;
        }
       
        
        
        NSLog(@"TT its work too");
        
        
        // работаем с кнопкой МЕНЮ
        
        leftBarButtonItem = rootViewController.navigationItem.leftBarButtonItem;
        
        UIButton *btnMenu = [UIButton buttonWithType:UIButtonTypeCustom];
        btnMenu.frame = CGRectMake(0, 0, 22, 18);
        [btnMenu setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
        [btnMenu addTarget:self action:@selector(showLeftMenu) forControlEvents:UIControlEventTouchUpInside];
        [leftBarButtonItem setCustomView:btnMenu];
       // rootViewController.navigationItem.leftBarButtonItem = leftBarButtonItem;
        
        
    }];

}

-(void)goToHome
{
    [self popToRootViewControllerAnimated:YES];
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
