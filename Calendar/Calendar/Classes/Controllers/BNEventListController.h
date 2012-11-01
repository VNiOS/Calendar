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
@protocol BNEventListDelegate
-(void)reloadDataList;


@end


@interface BNEventListController : UIViewController<EditEventDelegate,UITableViewDelegate,UITableViewDataSource,BNEventCellDelegate,EditEventDelegate>{
    NSArray *eventDay;
    BNEventCell *cell;
    UILabel *titlelb;
    NSDate *dateEvent ;
    UILabel *dayLabel;    
}
@property(nonatomic,retain) id<BNEventListDelegate> delegate;
@property (nonatomic, retain) UITableView *tableView;
- (IBAction)addEvent:(id)sender;
- (BNEventEntity *)eventAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)heightofCell:(BNEventEntity *)event2;
- (IBAction)backToCalendar:(id)sender;
- (void)addContentToHeadView:(UIView *)view;
- (void)bnEventCellDidClickedAtCell:(BNEventCell *)cell;
- (void)updateContentDate:(NSDate *)withdate;
- (IBAction)eventNextDay:(id)sender;
- (IBAction)eventPrevDay:(id)sender;
- (NSString *)conVertDateToStringDay:(NSDate *)date2;
- (NSString *)conVertDateToStringDate:(NSDate *)date1;



@end
