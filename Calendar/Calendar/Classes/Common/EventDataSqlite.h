//
//  EventDataSqlite.h
//  CalendarProject1
//
//  Created by Applehouse on 10/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Kal.h"
#import "BNEventEntity.h"
#import "FMDatabase.h"


@interface EventDataSqlite : NSObject<KalDataSource>{
    NSMutableArray *events;
    NSMutableArray *dayEvents;
    FMDatabase *database;
}

-(id)init;
- (BNEventEntity *)eventAtIndexPath:(NSIndexPath *)indexPath;
- (NSArray *)eventsFrom:(NSDate *)fromDate to:(NSDate *)toDate;
- (NSArray *)getEventListFromDate:(NSDate *)fromdate toDate:(NSDate *)toDate;
- (NSArray *)EventListIntoDate:(NSDate *)intoDate;
- (BOOL)updateDatabase:(BNEventEntity *)event;
- (BOOL)insertDatabase:(BNEventEntity *)event;
- (BOOL)deleteDatabase:(BNEventEntity *)event;
-(NSString *)convertDatetoString:(NSDate *)date;
-(NSDate *)convertStringtoDate:(NSString *)string;


@end
