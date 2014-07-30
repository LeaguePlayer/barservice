//
//  InventoryViewController.h
//  barservice
//
//  Created by Leonid Minderov on 25.04.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BarserviceViewController.h"

@interface InventoryViewController : BarserviceViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *dataRows;
}

@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic,retain) NSMutableArray *photos;

@property (nonatomic, retain) NSString *id_category;



@end
