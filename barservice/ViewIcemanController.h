//
//  ViewIcemanController.h
//  barservice
//
//  Created by Leonid Minderov on 27.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IceManController.h"

@interface ViewIcemanController : IceManController
{
    UITextView *textView;
    
}

@property (nonatomic, strong) NSString *apiValue;
@property (nonatomic, strong) NSString *apiType;


@end
