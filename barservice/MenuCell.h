//
//  MenuCell.h
//  barservice
//
//  Created by Leonid Minderov on 06.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageCell;
@property (strong, nonatomic) IBOutlet UILabel *cellTitle;
@property (strong, nonatomic) IBOutlet UIView *cellLine;

@end
