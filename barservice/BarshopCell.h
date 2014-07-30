//
//  BarshopCell.h
//  barservice
//
//  Created by Leonid Minderov on 12.05.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarshopCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageCell;
@property (strong, nonatomic) IBOutlet UILabel *titleCell;
@property (strong, nonatomic) IBOutlet UILabel *priceCell;

@end
