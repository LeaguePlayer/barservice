//
//  VideoPartyBusController.h
//  barservice
//
//  Created by Leonid Minderov on 15.05.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PartyBusController.h"


@interface VideoPartyBusController : PartyBusController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *tableMenu;
    
    NSMutableArray *dataTable;
    
    UIView *backgroundPlace;
    
    
    
}

@end
