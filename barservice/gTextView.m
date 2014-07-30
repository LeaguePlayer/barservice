//
//  gTextView.m
//  barservice
//
//  Created by Leonid Minderov on 27.03.14.
//  Copyright (c) 2014 A-Mobile LLC. All rights reserved.
//

#import "gTextView.h"
#import "gToolbar.h"
#import "gBarButtonItem.h"

#define paddingRight 13

@implementation gTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.keyboardType = UIKeyboardAppearanceDefault;
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        self.backgroundColor = [UIColor whiteColor];
    //    self.borderStyle = UITextBorderStyleRoundedRect;
        self.returnKeyType = UIReturnKeyNext;
        self.font = [UIFont systemFontOfSize:15.0];
        self.textColor = [UIColor colorWithRed:0.286 green:0.259 blue:0.227 alpha:1.0];
     //   self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        //To make the border look very close to a UITextField
        [self.layer setBorderColor:[[UIColor whiteColor]CGColor]];
        [self.layer setBorderWidth:1.0];
        
        
        gToolbar *pickerToolbar = [[gToolbar alloc] init];
        
        
        NSMutableArray *tmpItems = [[NSMutableArray alloc] initWithArray:pickerToolbar.items];
        gBarButtonItem* doneButton = [[gBarButtonItem alloc] initWithTitle:@"Свернуть"
                                                                     style:UIBarButtonItemStyleDone target:self
                                                                    action:@selector(doneClicked:)];
        [tmpItems addObject:doneButton];
        [pickerToolbar setItems:tmpItems];
        //set picker view inside the input view of the textfield
        
        self.inputAccessoryView = pickerToolbar;
        
        
        //The rounded corner part, where you specify your view's corner radius:
        //   self.layer.cornerRadius = 5;
        //    self.clipsToBounds = YES;
        
        self.layer.cornerRadius=3.0f;
    }
    return self;
}

-(void)doneClicked:(id) sender
{
    [self resignFirstResponder];
}

-(void)makeDownArrow
{
    UIImageView *downArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down_arrow"]];
    CGRect frame = downArrow.frame;
    frame.origin.x = self.frame.size.width - downArrow.frame.size.width - paddingRight;
    frame.origin.y = (self.frame.size.height - downArrow.frame.size.height)/2;
    downArrow.frame = frame;
    [self addSubview:downArrow];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
