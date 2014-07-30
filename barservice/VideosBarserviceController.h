//
//  VideosBarserviceController.h
//  barservice
//
//  Created by Leonid Minderov on 15.05.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BarserviceViewController.h"
#import "XCDYouTubeVideoPlayerViewController.h"

@interface VideosBarserviceController : BarserviceViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *dataRows;
}

@property (strong, nonatomic) UITableView *tableView;


@property (nonatomic, strong) NSString *apiValue;

@end
