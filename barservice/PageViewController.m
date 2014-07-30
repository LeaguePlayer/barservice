//
//  PageViewController.m
//  barservice
//
//  Created by Leonid Minderov on 26.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "PageViewController.h"



@interface PageViewController ()

@end

@implementation PageViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_IPAD)
    {
        CGRect frame = self.viewScroll.frame;
        frame.origin.y -=65.0;
        self.viewScroll.frame = frame;
    }
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
   
    
    // работаем с API
    self.apiString = [NSString stringWithFormat:@"%@/json/getpage/page/%@",domain_server_api, self.id_page];
    [self startAPI];
    
    
    
}


-(void)resizeTable
{
    
    
    //  scrollView
    self.viewScroll.contentSize = CGSizeMake(self.viewScroll.frame.size.width, myBrowser.frame.size.height+topPadding+bottomPadding+bottomMargin);
}

- (void)removeKeyBoard:(NSNotification *)notify {
    // web is your UIWebView
    [myBrowser stringByEvaluatingJavaScriptFromString:@"document.activeElement.blur()"];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return nil;
}



-(void)completeApi
{
   
    
    

    
    myBrowser = [[UIWebView alloc] initWithFrame:CGRectMake(leftPadding, 0, self.viewScroll.frame.size.width-(2*leftPadding), 0)];
    myBrowser.delegate = self;
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeKeyBoard:) name:UIKeyboardDidShowNotification object:nil];
    myBrowser.scrollView.delegate = self;
    
//    NSURL *imaladecLink = [NSURL URLWithString:@"http://auto.amobile-studio.ru/test/test.php"];
//    [myBrowser loadRequest:[NSURLRequest requestWithURL:imaladecLink]];
    [myBrowser loadHTMLString:[[self.gotDataAPI objectForKey:@"response"] objectForKey:@"text"] baseURL:nil];
    myBrowser.scalesPageToFit = NO;
    myBrowser.scrollView.scrollEnabled = NO;
    
    
    
    //[myBrowser sizeToFit];
    
    [self.viewScroll addSubview:myBrowser];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView {
      CGFloat height = [[aWebView stringByEvaluatingJavaScriptFromString:@"document.documentElement.scrollHeight"] floatValue];

    NSLog(@"content size from js: %f",height);
    CGRect frame = aWebView.frame;
    frame.size.height = 1;
    aWebView.frame = frame;
    CGSize fittingSize = [aWebView sizeThatFits:CGSizeZero];
    fittingSize.width = frame.size.width;
    frame.size = fittingSize;
    aWebView.frame = frame;
    [self resizeTable];
    
    UIView *bottomBorderRadius = [[UIView alloc ]initWithFrame:CGRectMake(aWebView.frame.origin.x, aWebView.frame.size.height+aWebView.frame.origin.y-borderRadius, aWebView.frame.size.width, borderRadius*2)];
    bottomBorderRadius.layer.cornerRadius = borderRadius;
    bottomBorderRadius.backgroundColor = [UIColor whiteColor];
    [self.viewScroll addSubview:bottomBorderRadius];
    
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
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
