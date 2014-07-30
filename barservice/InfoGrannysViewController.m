//
//  InfoGrannysViewController.m
//  barservice
//
//  Created by Leonid Minderov on 05.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "InfoGrannysViewController.h"
#import "gCaptionLabel.h"



@interface InfoGrannysViewController ()

@end

@implementation InfoGrannysViewController
@synthesize scrollGallery;
@synthesize myBrowser;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    top_postion = 0;
    
    float height_gallery;
    
    if(IS_IPAD)
    {
        height_gallery = 512.0f;
    }
    else
    {
        height_gallery = 200.0f;
    }
    
    // получаем доступ к меню контроллеру и меняем пунты меню
    MenuViewController *tVC = ((MenuViewController *)self.slidingViewController.underLeftViewController);
    [tVC.menuNames setArray:menuGrannys];
    [tVC.menuLinks setArray:menuGrannysLinks];
    [tVC.menuImages setArray:menuGrannysImages];
    [tVC.tableView reloadData];
    
    // добавляем слайдер в шапку
    scrollGallery = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.viewScroll.frame.size.width, height_gallery)];
    scrollGallery.pagingEnabled = YES;
    
    
    
    // работаем с API
    self.apiString = [NSString stringWithFormat:@"%@/json/getinfo/site/grannys",domain_server_api];
    [self startAPI];

    CGFloat scrollWidth = 0.f;
    
    NSArray *someNSArrayWithImages = @[[UIImage imageNamed:@"i1.jpg"], [UIImage imageNamed:@"i2.jpg"],[UIImage imageNamed:@"i3.jpg"],[UIImage imageNamed:@"i4.jpg"],[UIImage imageNamed:@"i5.jpg"]];
    
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
   
    
    
//    // добавляем HTML контент
//    myBrowser = [[UIWebView alloc] initWithFrame:CGRectMake(padding_left, top_postion, self.viewScroll.frame.size.width-(2*padding_left), 400)];
//    myBrowser.delegate = self;
//    NSURL *imaladecLink = [NSURL URLWithString:@"http://auto.amobile-studio.ru/test/test.php"];
//    [myBrowser loadRequest:[NSURLRequest requestWithURL:imaladecLink]];
//    myBrowser.scalesPageToFit = NO;
//    myBrowser.scrollView.scrollEnabled = NO;
//    
//    [myBrowser sizeToFit];
//     [self.viewScroll addSubview:myBrowser];
    
//    [self.viewScroll setContentSize:CGSizeMake(320, 1200)];
    
    
    
   
}


-(void)resizeTable
{
    
    
    //  scrollView
    self.viewScroll.contentSize = CGSizeMake(self.viewScroll.frame.size.width, top_postion);
}

-(void)completeApi
{
  
    
    // добавляем заголовок
    gCaptionLabel *caption = [[gCaptionLabel alloc] initWithFrame:CGRectMake(padding_left, top_postion, self.viewScroll.frame.size.width-(2*padding_left), 15)];
    NSLog(@"was height: %f",caption.frame.size.height);
    caption.text = [[self.gotDataAPI objectForKey:@"response"] objectForKey:@"title"];
    
    [caption sizeToFit];
    [self.viewScroll addSubview:caption];
    top_postion+= caption.frame.size.height + top_padding_beetwen_objects;
    
    
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(padding_left, top_postion, self.view.frame.size.width-(padding_left*2), 0)];
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
    frame.size.width = self.view.frame.size.width-(2*padding_left);
    textView.frame = frame;
    top_postion+= textView.frame.size.height + top_padding_beetwen_objects;
    //   NSLog(@"new: %f",textView.frame.size.height);
    
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

//- (void)webViewDidFinishLoad:(UIWebView *)aWebView {
//      CGFloat height = [[aWebView stringByEvaluatingJavaScriptFromString:@"document.documentElement.scrollHeight"] floatValue];
//    
//    NSLog(@"content size from js: %f",height);
//    CGRect frame = aWebView.frame;
//    frame.size.height = 1;
//    aWebView.frame = frame;
//    CGSize fittingSize = [aWebView sizeThatFits:CGSizeZero];
//    fittingSize.width = frame.size.width;
//    frame.size = fittingSize;
//    aWebView.frame = frame;
//    
//    NSLog(@"size from obj c: %f", fittingSize.height);
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
