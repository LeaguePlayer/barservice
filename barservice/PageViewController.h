//
//  PageViewController.h
//  barservice
//
//  Created by Leonid Minderov on 26.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BarserviceViewController.h"

@interface PageViewController : BarserviceViewController <UIWebViewDelegate>
{
    UITextView *textView;
    UIWebView *myBrowser;
}

@property (nonatomic, retain) NSString *id_page;

@end
