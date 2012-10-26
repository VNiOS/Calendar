//
//  BNCalendarController.h
//  Calendar
//
//  Created by Tuan Nguyen on 10/21/12.
//  Copyright (c) 2012 Lifetimetech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KalView.h"       // for the KalViewDelegate protocol
#import "KalDataSource.h" // for the KalDataSourceCallbacks protocol

@class KalLogic, KalDate;
@interface BNCalendarController : UIViewController<KalViewDelegate, KalDataSourceCallbacks,UITableViewDelegate>{
    KalLogic *logic;
    UITableView *tableView;
    id <UITableViewDelegate> delegate;
    id <KalDataSource> dataSource;
    NSDate *initialDate;                  
    NSDate *selectedDate;  
}
@property (nonatomic, assign) id<UITableViewDelegate> delegate;
@property (nonatomic, assign) id<KalDataSource> dataSource;
@property (nonatomic, retain, readonly) NSDate *selectedDate;

- (KalView*)calendarView;
- (id)initWithSelectedDate:(NSDate *)selectedDate; 
- (void)reloadData;                                 
- (void)showAndSelectDate:(NSDate *)date;           

@end