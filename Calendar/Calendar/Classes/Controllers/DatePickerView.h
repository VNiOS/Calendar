//
//  DatePickerView.h
//  Calendar
//
//  Created by Applehouse on 10/26/12.
//  Copyright (c) 2012 WD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNEventEditorController.h"

@interface DatePickerView : UIViewController{
    UIDatePicker *datePicker;
    NSString *dateSelected;
    UILabel *dateTypelb;
    UILabel *datelb;
    BNEventEditorController *delegate;
}
-(void)setDateType:(bool)datetype;
-(IBAction)setDate:(id)sender;
@property(nonatomic,strong) BNEventEditorController *delegate;

@property(nonatomic,retain) IBOutlet UIDatePicker *datePicker;
@property(nonatomic,retain) IBOutlet NSString *dateSelected;
@property(nonatomic,retain) IBOutlet UILabel *datelb;
@property(nonatomic,retain) IBOutlet UILabel *dateTypelb;
@end
