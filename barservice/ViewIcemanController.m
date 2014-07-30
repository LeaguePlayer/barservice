//
//  ViewIcemanController.m
//  barservice
//
//  Created by Leonid Minderov on 27.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "ViewIcemanController.h"

@interface ViewIcemanController ()

@end

@implementation ViewIcemanController
@synthesize apiValue, apiType;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.322 green:0.514 blue:0.949 alpha:1.0];
    
    // получаем доступ к меню контроллеру и меняем пунты меню
    MenuViewController *tVC = ((MenuViewController *)self.slidingViewController.underLeftViewController);
    [tVC.menuNames setArray:menuIceman];
    [tVC.menuLinks setArray:menuIcemanLinks];
    [tVC.menuImages setArray:menuIcemanImages];
    [tVC.tableView reloadData];
	// Do any additional setup after loading the view.
    
    // меняем навигационный бар
    [self.navigationController.navigationBar setBackgroundImage:[Functions imageWithColor:[UIColor colorWithRed:0.078 green:0.188 blue:0.392 alpha:1.0]] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0], NSFontAttributeName : [UIFont systemFontOfSize:21.0]};
    
    
    // работаем с API
    self.apiString = [NSString stringWithFormat:@"%@/json/getinfo/site/%@/type/%@",domain_server_api, apiValue, apiType];
    [self startAPI];
    
}


-(void)resizeTable
{
    
    
    //  scrollView
    self.viewScroll.contentSize = CGSizeMake(self.viewScroll.frame.size.width, textView.frame.size.height+topPadding+bottomPadding+bottomMargin);
}

-(void)completeApi
{
    //   NSLog(@"%@",[[self.gotDataAPI objectForKey:@"response"] objectForKey:@"childs"]);
    //dataRows = ;
    
   // NSLog(@"%@",self.gotDataAPI);
    
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    textView.contentInset = UIEdgeInsetsMake(0, 15, 15, 15);
    textView.editable = NO;
    textView.dataDetectorTypes = UIDataDetectorTypeAll;
    
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
    frame.size.width = self.view.frame.size.width;
    textView.frame = frame;
    
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
