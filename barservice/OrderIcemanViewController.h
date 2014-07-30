//
//  OrderIcemanViewController.h
//  barservice
//
//  Created by Leonid Minderov on 27.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IceManController.h"
#import "gTextField.h"
#import "gLabel.h"
#import "gToolbar.h"
#import "gBarButtonItem.h"
#import "gTextView.h"

@interface OrderIcemanViewController : IceManController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate>
{
    float content_height;
    
    gTextView *commentArea;
    gTextField *phoneField;
    
    gToolbar *pickerToolbar;
    UIPickerView *monthPickerView;
    
    
}

@property (nonatomic, retain)  gTextField *type_order;



@end
