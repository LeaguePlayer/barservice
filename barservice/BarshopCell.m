//
//  BarshopCell.m
//  barservice
//
//  Created by Leonid Minderov on 12.05.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "BarshopCell.h"

@implementation BarshopCell

- (void)awakeFromNib
{
    // Initialization code
    //self.backgroundColor = [UIColor clearColor];
    self.priceCell.textColor = [UIColor colorWithRed:0.106 green:0.694 blue:0.122 alpha:1];
    self.titleCell.textColor = [UIColor colorWithRed:0.259 green:0.259 blue:0.259 alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
