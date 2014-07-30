//
//  InfoPartyBusController.m
//  barservice
//
//  Created by Leonid Minderov on 05.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "InfoPartyBusController.h"

@interface InfoPartyBusController ()

@end

@implementation InfoPartyBusController



- (void)viewDidLoad
{
    [super viewDidLoad];
    top_postion = 0;
    // получаем доступ к меню контроллеру и меняем пунты меню
    MenuViewController *tVC = ((MenuViewController *)self.slidingViewController.underLeftViewController);
    [tVC.menuNames setArray:menuPartybus];
    [tVC.menuLinks setArray:menuPartybusLinks];
    [tVC.menuImages setArray:menuPartybusImages];
    [tVC.tableView reloadData];
	// Do any additional setup after loading the view.
    
    
    // меняем навигационный бар
    [self.navigationController.navigationBar setBackgroundImage:[Functions imageWithColor:[UIColor colorWithRed:0.161 green:0.165 blue:0.18 alpha:1.0]] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0], NSFontAttributeName : [UIFont systemFontOfSize:21.0]};
    
    
    // работаем с API
    self.apiString = [NSString stringWithFormat:@"%@/json/getinfo/site/%@/",domain_server_api, @"partybus"];
    [self startAPI];
    
    
    float height_gallery;
    
    if(IS_IPAD)
    {
        height_gallery = 512.0f;
    }
    else
    {
        height_gallery = 200.0f;
    }
    
    // добавляем слайдер в шапку
    scrollGallery = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.viewScroll.frame.size.width, height_gallery)];
    scrollGallery.pagingEnabled = YES;
    
    
    
    
    CGFloat scrollWidth = 0.f;
    
    NSArray *someNSArrayWithImages = @[
                                       
                                    [UIImage imageNamed:@"ibus1.jpg"],
                                    [UIImage imageNamed:@"ibus2.jpg"],
    [UIImage imageNamed:@"ibus3.jpg"],
    [UIImage imageNamed:@"ibus4.jpg"],
    [UIImage imageNamed:@"ibus5.jpg"]
                                       ];
    
    for (UIImage *someImage in someNSArrayWithImages) {
        UIImageView *theView = [[UIImageView alloc] initWithFrame:
                                CGRectMake(scrollWidth, 0, self.viewScroll.frame.size.width, height_gallery)];
        theView.image = someImage;
        [scrollGallery addSubview:theView];
        
        scrollWidth += self.viewScroll.frame.size.width;
    }
    scrollGallery.contentSize = CGSizeMake(scrollWidth, height_gallery);
    scrollGallery.bounces = NO;
    top_postion+= scrollGallery.frame.size.height + top_padding_beetwen_objects;
    [self.viewScroll  addSubview:scrollGallery];


    
}

-(void)resizeTable
{
    
    
    //  scrollView
    self.viewScroll.contentSize = CGSizeMake(self.viewScroll.frame.size.width, top_postion);
}

-(void)completeApi
{
    //   NSLog(@"%@",[[self.gotDataAPI objectForKey:@"response"] objectForKey:@"childs"]);
    //dataRows = ;
    
    // NSLog(@"%@",self.gotDataAPI);
    
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(paddingLeft, top_postion, self.view.frame.size.width-(2*paddingLeft), 0)];
    // textView.contentInset = UIEdgeInsetsMake(35, 15, 15, 15);
    
    
    textView.translatesAutoresizingMaskIntoConstraints = YES;
    textView.scrollEnabled = NO;
    //  textView.bounces = NO;
    [self.viewScroll addSubview:textView];
   
    //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[textView]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(textView)]];
    //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[textView]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(textView)]];
    
    NSString *htmlString = [[self.gotDataAPI objectForKey:@"response"] objectForKey:@"text"];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    textView.attributedText = attributedString;
    
    
    
    [textView sizeToFit];
    
    CGRect frame = textView.frame;
    frame.size.width = self.view.frame.size.width-(2*paddingLeft);
    textView.frame = frame;
    
    //   NSLog(@"new: %f",textView.frame.size.height);
     top_postion += textView.frame.size.height + top_padding_beetwen_objects;
    [self resizeTable];
    
    //    UIWebView *myBrowser = [[UIWebView alloc] initWithFrame:CGRectMake(leftPadding, 0, self.viewScroll.frame.size.width-(2*leftPadding), 400)];
    //    myBrowser.delegate = self;
    //    NSURL *imaladecLink = [NSURL URLWithString:@"http://auto.amobile-studio.ru/test/test.php"];
    //    [myBrowser loadRequest:[NSURLRequest requestWithURL:imaladecLink]];
    //    myBrowser.scalesPageToFit = NO;
    //    myBrowser.scrollView.scrollEnabled = NO;
    //
    //    [myBrowser sizeToFit];
    //    [self.viewScroll addSubview:myBrowser];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
