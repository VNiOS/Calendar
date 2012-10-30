//
//  BNEventListController.h
//  Calendar
//
//  Created by Applehouse on 10/25/12.
//  Copyright (c) 2012 WD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNEventEditorController.h"
#import "BNEventCell.h"
@interface BNEventListController : UITableViewController<EditEventDelegate,UITableViewDelegate,UITableViewDataSource,BNEventCellDelegate>{
    NSArray *eventDay;
    BNEventCell *cell;
    NSInteger test;
    UILabel *titlelb;
    NSDate *dateEvent ;
    UILabel *dayLabel;
}
-(IBAction)addEvent:(id)sender;
- (BNEventEntity *)eventAtIndexPath:(NSIndexPath *)indexPath;
-(CGFloat)heightofCell:(BNEventEntity *)event2;
-(IBAction)done:(id)sender;
-(void)addContentToHeadView:(UIView *)view;
- (void)bnEventCellDidClickedAtCell:(BNEventCell *)cell;
- (void)updateContentDate:(NSDate *)withdate;
- (IBAction)eventNextDay:(id)sender;
- (IBAction)eventPrevDay:(id)sender;
-(NSString *)conVertDateToStringDay:(NSDate *)date2;
-(NSString *)conVertDateToStringDate:(NSDate *)date1;
//- (void)initWithDate:(NSDate *)date1;
//- (IBAction)EventNextDay:(id)sender;
//- (IBAction)EventPrevDay:(id)sender;

@end