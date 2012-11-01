//
//  DatePickerView.h
//  Calendar
//
//  Created by Applehouse on 10/26/12.
//  Copyright (c) 2012 WD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNEventEditorController.h"

@interface DatePickerView : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *tableView1;
    UIDatePicker *datePicker;
    UILabel *dateStartlb;
    UILabel *dateEndlb;
    BNEventEditorController *delegate;
    NSString *dateInput;
    bool dateType;
    bool succes;
    bool NewEvent;
}
-(void)addContentToHeadView:(UIView *)view;
-(IBAction)setDate:(id)sender;
-(IBAction)done:(id)sender;
-(void)checkDate;


@property(nonatomic,retain) IBOutlet UITableView *tableView1;
@property(nonatomic,strong) BNEventEditorController *delegate;

@property(nonatomic,retain) IBOutlet UIDatePicker *datePicker;

@property(nonatomic,retain) IBOutlet UILabel *dateStartlb;
@property(nonatomic,retain) IBOutlet UILabel *dateEndlb;

@end
