//
//  BoardCell.m
//  barservice
//
//  Created by Leonid Minderov on 31.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "BoardCell.h"

@implementation BoardCell



- (void)awakeFromNib
{
    // Initialization code
    self.compositionMenu.textColor = [UIColor colorWithRed:0.757 green:0.216 blue:0.11 alpha:1.0];
    self.backgroundColor = [UIColor clearColor];
    [self.compositionMenu sizeToFit];
//    self.compositionMenu.lineBreakMode = NSLineBreakByWordWrapping;
//    self.compositionMenu.numberOfLines = 0;
   // NSLog(@"%f",self.frame.size.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
