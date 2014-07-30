//
//  ViewController.m
//  barservice
//
//  Created by Leonid Minderov on 26.02.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "ViewController.h"
#import "NavigrationController.h"
#import "UIImageView+AFNetworking.h"


// НАСТРОЙКИ ДЛЯ ГАЛЕРЕИ
#define offset_X 16
#define offset_Y 21

#define bottom_offset_Y 30

#define sticker_wight 81
#define sticker_height 85

#define space_Y 14
#define space_X 22.5

#define photoW 68.5
#define photoH 68.5

#define photo_offset_x 6.5
#define photo_offset_y 11

#define bottomBorderH 5



@interface ViewController ()

@end

@implementation ViewController

@synthesize viewScroll = _viewScroll;
@synthesize galleryImages;
@synthesize photos;
@synthesize fieldsForSend;

@synthesize apiString;
@synthesize hud;
@synthesize gotDataAPI;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.fieldsForSend = [[NSMutableDictionary alloc] init];
    
    self.gotDataAPI = [[NSDictionary alloc] init];
    
    self.viewScroll = [[GScrollView alloc] initWithFrame:[self.view bounds]];
    self.viewScroll.bounces = NO;
    self.viewScroll.delegate = self;
   // self.viewScroll.scrollEnabled = NO;

    if(IS_IPAD)
    {
        CGRect frame = self.viewScroll.frame;
        frame.origin.y +=64.0f;
        self.viewScroll.frame = frame;
    }
    
    [self.view addSubview:self.viewScroll];
    
    
    
    
    
   hud = [[MBProgressHUD alloc]init];
    
    
   
   
   // hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Загрузка";
    
    
    
    
    	// Do any additional setup after loading the view, typically from a nib.
}

-(void)startAPI
{
    
    if(![self.apiString isEqualToString:@""])
    {
         hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *urlInString =[NSString stringWithFormat:@"%@",self.apiString];
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:urlInString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
           
            if([[responseObject objectForKey:@"result"] integerValue] == 0) // если ошибка
            {
                [hud hide:YES];
                NSLog(@"fucking error");
                
                MBProgressHUD *hud_complete = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud_complete.delegate = self;
                hud_complete.labelText = [responseObject objectForKey:@"error"];
                hud_complete.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cancel"]];
                hud_complete.mode = MBProgressHUDModeCustomView;
                
                [hud_complete show:YES];
                [hud_complete hide:YES afterDelay:2.3f];
            }
            else // если все ок
            {
                self.gotDataAPI = responseObject;
                [self completeApi];
                [hud hide:YES];
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [hud hide:YES];
        }];
        
        
    }
    else NSLog(@"API не указан");
}

-(void)completeApi
{
    NSLog(@"in ViewController");
}


#pragma mark - Gallery methods
-(void)setphotosForGallery:(NSArray*)gotPhotos
{
   
    galleryImages = [[NSArray alloc] initWithArray:gotPhotos];
}

-(UIView *)makeMainBackgroundwithBorder:(BOOL)border andHeightIs:(float)heightGallery andSwitchType:(NSString*)got_type
{
    
     UIView *backgroundGallery = [[UIView alloc] init];
    
    void (^selectedCase)() = @{
                               @"grannys" : ^{
                                   backgroundGallery.frame = CGRectMake(0, 0, self.viewScroll.frame.size.width, heightGallery);
                                   backgroundGallery.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_grannys_gal"]];
                               },
                               @"barservice" : ^{
                                   backgroundGallery.frame = CGRectMake(leftPadding, -borderRadius, self.viewScroll.frame.size.width-(leftPadding*2), heightGallery);
                                   backgroundGallery.backgroundColor = [UIColor whiteColor];
                                   backgroundGallery.layer.cornerRadius = borderRadius;
                                  // backgroundGallery.contentInset = UIEdgeInsetsMake(borderRadius, 0, 0, 0);
                                   
                               },
                               @"iceman" : ^{
                                   backgroundGallery.frame = CGRectMake(0, 0, self.viewScroll.frame.size.width, heightGallery);
                                   backgroundGallery.backgroundColor = [UIColor colorWithRed:0.322 green:0.514 blue:0.949 alpha:1.0];
                                   
                                   
                               },
                               @"barservice_order" : ^{
                                   backgroundGallery.frame = CGRectMake(0, 0, self.viewScroll.frame.size.width, heightGallery);
                                   backgroundGallery.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1];
                                   
                                   
                               },
                               @"partybus" : ^{
                                   backgroundGallery.frame = CGRectMake(0, 0, self.viewScroll.frame.size.width, heightGallery);
                                   backgroundGallery.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
                                   
                                   
                               },
                               
                               }[got_type];
    
    if (selectedCase != nil)
        selectedCase();
    
    
   // int lineGalelry = (int)ceil([galleryImages count]/3.0f);
    //float heightGallery = sticker_height*lineGalelry+(lineGalelry-1)*space_Y;
    
   
    
    
    if(border)
    {
        UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, backgroundGallery.frame.size.height, self.viewScroll.frame.size.width, bottomBorderH)];
        bottomBorder.tag= 99999;
        bottomBorder.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bottom_border_grannys_gal"]];
        [backgroundGallery addSubview:bottomBorder];
    }
    
    return backgroundGallery;
}

-(UIView*)makeReserveButtonByPositionAtY:(float)pos_Y andAction:(NSString*)action withTitle:(NSString *)title
{
    UIView *placeForButton = [[UIView alloc] initWithFrame:CGRectMake(0, pos_Y, self.viewScroll.frame.size.width, 138)];
    
    
    // добавляем тень, которая будет под кнопкой забронировать
      UIImageView *shadowForButton = [[UIImageView alloc ]initWithImage:[UIImage imageNamed:@"shadow"]];
      shadowForButton.frame =  CGRectMake((self.viewScroll.frame.size.width-290)/2, 0, 290, 138);
    // backgroundGallery.frame.size.height-50 = its was
    [placeForButton addSubview:shadowForButton];
    
    // добавляем кнопку забронировать
        UIButton *reserveButton = [[UIButton alloc] init];
        reserveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        reserveButton.frame = CGRectMake((self.viewScroll.frame.size.width-261)/2, 0, 261, 98);
    
        [reserveButton setTitle:title forState:UIControlStateNormal];
        [reserveButton setTitleEdgeInsets:UIEdgeInsetsMake(42.0f, 46.0f, 0.0f, 0.0f)];
        reserveButton.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        [reserveButton setBackgroundImage:[UIImage imageNamed:@"gray_button"]
                            forState:UIControlStateNormal];
    
        [reserveButton addTarget:self action:NSSelectorFromString(action) forControlEvents:UIControlEventTouchUpInside];
    
    // лейбл на кнопку
        UIImageView *labelOnButton = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reserve_button"]];
       CGRect frameLabel = labelOnButton.frame;
        frameLabel.origin.x = 40;
        frameLabel.origin.y = 60;
        labelOnButton.frame = frameLabel;
        [reserveButton addSubview:labelOnButton];
    
    
    [placeForButton addSubview:reserveButton];
      //  [self.viewScroll addSubview:reserveButton];
    
    return placeForButton;
}

-(UIView*)loadGallery
{
    self.photos = [[NSMutableArray alloc] init];
    
   
    
//   galleryImages = @[[UIImage imageNamed:@"i1.jpg"], [UIImage imageNamed:@"i2.jpg"], [UIImage imageNamed:@"i3.jpg"], [UIImage imageNamed:@"i4.jpg"], [UIImage imageNamed:@"i2.jpg"], [UIImage imageNamed:@"i3.jpg"], [UIImage imageNamed:@"i4.jpg"], [UIImage imageNamed:@"i2.jpg"], [UIImage imageNamed:@"i3.jpg"], [UIImage imageNamed:@"i4.jpg"], [UIImage imageNamed:@"i2.jpg"], [UIImage imageNamed:@"i3.jpg"], [UIImage imageNamed:@"i4.jpg"], [UIImage imageNamed:@"i2.jpg"], [UIImage imageNamed:@"i3.jpg"], [UIImage imageNamed:@"i4.jpg"], [UIImage imageNamed:@"i2.jpg"], [UIImage imageNamed:@"i3.jpg"], [UIImage imageNamed:@"i4.jpg"]];
    
    float photosInRow;
  
    if(IS_IPAD)
    {
        photosInRow = 7.0;
    }
    else
    {
        photosInRow = 3.0;
    }
    
   
    int lineGalelry = (int)ceil([galleryImages count]/photosInRow);
    float heightGallery = sticker_height*lineGalelry+(lineGalelry-1)*space_Y;
    
    
    float wigthGallery = self.viewScroll.frame.size.width-(offset_X*2);
    
    UIView *placeForGallery = [[UIView alloc] initWithFrame:CGRectMake(offset_X, offset_Y, wigthGallery, heightGallery)];
    
    // форма с основынм фоновым цветом и нижний бордер
  //  [self makeMainBackground:heightGallery+offset_Y+bottom_offset_Y andWithBorder:YES];
    
    
    // добавляем бордер
    
    
    

    
    
    
    float x = 0;
    float y = 0;
    int n = 0;
    for(NSDictionary *photo in galleryImages)
    {
        n++;
        
        // добавляем фото в глобальный массив для просмотра галереи
        //[self.photos addObject:[MWPhoto photoWithImage:photo]];
        
        NSString *thumb_prefix;
        
        if(IS_IPAD)
        {
            if(IS_RETINA)
            {
                thumb_prefix = @"ipad_retina";
            }
            else
            {
                thumb_prefix = @"ipad";
            }
        }
        else
        {
            if(IS_RETINA)
            {
                thumb_prefix = @"iphone_retina";
            }
            else
            {
                thumb_prefix = @"iphone";
            }
        }
        
        MWPhoto *gotPhoto = [MWPhoto photoWithURL:[NSURL URLWithString:[photo objectForKey:thumb_prefix]]];
        
        
        [self.photos addObject:gotPhoto];
        
        UIImageView *sticker = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sticker"]];
        sticker.frame = CGRectMake(x, y, sticker_wight, sticker_height);
        
        
        sticker.userInteractionEnabled = YES;
        sticker.tag = n;
        
        UITapGestureRecognizer *pgr = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self action:@selector(showPhotoFullScreen:)];
      //  pgr.delegate = self;
        [sticker addGestureRecognizer:pgr];
        
        
        
        
        
        
        UIImageView *photoForSticker = [[UIImageView alloc ] init];
        
        
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[photo objectForKey:@"thumb"]]];
        
        [photoForSticker setImageWithURLRequest:urlRequest placeholderImage:[UIImage imageNamed:@"holder_gallery"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
           photoForSticker.image = image;
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            NSLog(@"Request failed with error: %@", error);
        }];
        
        photoForSticker.frame = CGRectMake(photo_offset_x, photo_offset_y, photoW, photoH);
        [sticker addSubview:photoForSticker];
        
        
        
        x += sticker_wight + space_X;
        if(n%(int)photosInRow==0)
        {
            x = 0;
            y += sticker_height + space_Y;
        }
        
        [placeForGallery addSubview:sticker];
    }
    
  //  [self.viewScroll setContentSize:CGSizeMake(self.viewScroll.frame.size.width, heightGallery+offset_Y+bottom_offset_Y+bottomBorderH+bottomPadding)];
    
 //   [backgroundGallery addSubview:placeForGallery];
   // [self.viewScroll addSubview:backgroundGallery];
    return placeForGallery;
}


-(BOOL)validateFields
{
    BOOL errors = NO;
    for(UITextField *field in [self.fieldsForSend allValues])
    {
        NSLog(@"%@",field.text);
        if([field isKindOfClass:[UITextField class]])
        {
            if([field.text isEqualToString:@""])
            {
                // поле пустое - ошибку показываем
                [field.layer setBorderColor:[[UIColor redColor]CGColor]];
                errors = YES;
            }
            else
            {
                // поля заполнены - все гуд
                [field.layer setBorderColor:[[UIColor whiteColor]CGColor]];
            }
        }
        
    }
    return errors;
}


-(void)resizeContentWithKeyboard:(BOOL)showKeyboard
{
    float height_keyboard = 246.0f;
    if(showKeyboard)
    {
       //self.viewScroll.contentSize.height
        self.viewScroll.contentSize = CGSizeMake(self.viewScroll.frame.size.width, self.viewScroll.contentSize.height+height_keyboard);
    }
    else
    {
        self.viewScroll.contentSize = CGSizeMake(self.viewScroll.frame.size.width, self.viewScroll.contentSize.height-height_keyboard);
    }
}



-(void)showPhotoFullScreen:(UITapGestureRecognizer *)sender
{
    //NSLog(@"tag: %i",);
    // Create array of MWPhoto objects
    
    
  //  [gallery addObject:[MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"photo2l" ofType:@"jpg"]]]];
 //   [gallery addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3629/3339128908_7aecabc34b.jpg"]]];
//    [gallery addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3590/3329114220_5fbc5bc92b.jpg"]]];
    
    // Create browser (must be done each time photo browser is
    // displayed. Photo browser objects cannot be re-used)
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    
    
    // Set options
    browser.displayActionButton = YES; // Show action button to allow sharing, copying, etc (defaults to YES)
    browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    browser.alwaysShowControls = NO; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    browser.enableGrid = NO;
    browser.startOnGrid = NO; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
//    browser.wantsFullScreenLayout = YES; // iOS 5 & 6 only: Decide if you want the photo browser full screen, i.e. whether the status bar is affected (defaults to YES)
    
    // Optionally set the current visible photo before displaying
    [browser setCurrentPhotoIndex:sender.view.tag-1];
    
   //browser.de
    
    // Present
  //  [self.navigationController presentViewController:browser animated:YES completion:nil];
    [self.navigationController pushViewController:browser animated:YES];
   // [self presentViewController:browser animated:YES completion:nil];
    
  
}

-(void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser
{
    NSLog(@"work finish");
}


-(void)goToReserveWithSendData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // получаем строку для POST запроса
    NSString *post = [self getRequestPostString];
   
    //prepar request
    NSString *urlString = [NSString stringWithFormat:@"%@/orders/insertorder?key=%@",domain_server_api,application_key_value];
    
    
    
    
    
    
   
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", (int)[postData length]];
    
    //post
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //get response
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"Response Code: %d", (int)[urlResponse statusCode]);
    if ([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300) {
        NSLog(@"Response: %@", result);

        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            // Do something...
          
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                
                MBProgressHUD *hud_complete = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud_complete.delegate = self;
                hud_complete.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
                hud_complete.mode = MBProgressHUDModeCustomView;
                
                [hud_complete show:YES];
                [hud_complete hide:YES afterDelay:2.3f];
                
                
            });
        });
        
    }
    else
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"Неизвестная ошибка"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        //        get_errors = YES;
//        message = @"Необходимо подключиться к интернету!";
    }
    
    
    
    // final animation
    
    
    
    
    
    
 
}
-(void)hudWasHidden:(MBProgressHUD *)hud
{
     [self.navigationController popToRootViewControllerAnimated:YES];
}

-(NSString *)getRequestPostString
{
    NSString *result = @"";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    int n = 1;
    for(NSString *key in [self.fieldsForSend allKeys])
    {
        if(n!=1)
            result = [NSString stringWithFormat:@"%@&", result];
        
        
        UITextField *tmpField = [self.fieldsForSend objectForKey:key];
        result = [NSString stringWithFormat:@"%@%@=%@", result, key, tmpField.text];
        
        // записываем в сеттингс
        
        [userDefaults setObject:tmpField.text forKey:key];
        
        n++;
    }
    [userDefaults synchronize];
    
    return result;
}

-(void)goToReserveController
{
    NSString *identifier = @"g_order";
    
    
    
    
    UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    
    NavigrationController *tVC = ((NavigrationController *)self.slidingViewController.topViewController);
    NSArray * viewControllers = [tVC viewControllers];
    NSArray * newViewControllers = [NSArray arrayWithObjects:[viewControllers objectAtIndex:0],
                                    newTopViewController,nil];
    [tVC setViewControllers:newViewControllers animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    
    
    [super viewWillAppear:animated];
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    
    return [self.photos count];
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count)
        return [self.photos objectAtIndex:index];
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    
    return nil;
}



@end
