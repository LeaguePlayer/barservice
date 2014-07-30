//
//  GalleryBarserviceController.m
//  barservice
//
//  Created by Leonid Minderov on 26.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "GalleryBarserviceController.h"

@interface GalleryBarserviceController ()

@end

@implementation GalleryBarserviceController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // работаем с API
    self.apiString = [NSString stringWithFormat:@"%@/json/getgallery/site/barservice",domain_server_api];
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
    CGRect frame = photosInView.frame;
    frame.origin.x = 6;
    photosInView.frame = frame;
    
    UIView *backgroundGrannys = [self makeMainBackgroundwithBorder:NO andHeightIs:photosInView.frame.size.height+(photosInView.frame.origin.y*2) andSwitchType:@"barservice"];
    
    
    
    [backgroundGrannys addSubview:photosInView];
    
    [self.viewScroll addSubview:backgroundGrannys];
    
    
    
    [self.viewScroll setContentSize:CGSizeMake(self.viewScroll.frame.size.width, backgroundGrannys.frame.size.height+60)];

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
