//
//  ViewController.h
//  barservice
//
//  Created by Leonid Minderov on 26.02.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+ECSlidingViewController.h"
#import "MenuViewController.h"
#import "Functions.h"
#import "MWPhotoBrowser.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "GScrollView.h"


@interface ViewController : UIViewController <MWPhotoBrowserDelegate, UIScrollViewDelegate, MBProgressHUDDelegate>
{
   // GScrollView *viewScroll;
    NSArray *galleryImages;
  
    
}

@property (nonatomic, retain) GScrollView *viewScroll;



// ГАЛЕРЕЯ
@property (nonatomic, retain) NSArray *galleryImages;

@property (nonatomic, strong) NSMutableArray *photos;
-(UIView*)loadGallery;
-(UIView*)makeReserveButtonByPositionAtY:(float)pos_Y andAction:(NSString*)action withTitle:(NSString *)title;

-(UIView *)makeMainBackgroundwithBorder:(BOOL)border andHeightIs:(float)heightGallery andSwitchType:(NSString*)got_type;
-(void)setphotosForGallery:(NSArray*)gotPhotos;

// формы
@property (nonatomic, retain) NSMutableDictionary *fieldsForSend;
-(void)goToReserveWithSendData;
-(BOOL)validateFields;
-(void)resizeContentWithKeyboard:(BOOL)showKeyboard;

// работа с API
@property (nonatomic, retain) NSString *apiString;
@property (nonatomic, retain) MBProgressHUD *hud;
@property (nonatomic, retain) NSDictionary *gotDataAPI;

-(void)startAPI;
-(void)completeApi;

@end
