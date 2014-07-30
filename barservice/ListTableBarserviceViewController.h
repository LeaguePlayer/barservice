//
//  ListTableBarserviceViewController.h
//  barservice
//
//  Created by Leonid Minderov on 26.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BarserviceViewController.h"

@interface ListTableBarserviceViewController : BarserviceViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *dataRows;
}

@property (strong, nonatomic) UITableView *tableView;


@property (nonatomic, strong) NSString *apiValue;


@end
