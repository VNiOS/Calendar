//
//  EventDataSqlite.h
//  CalendarProject1
//
//  Created by Applehouse on 10/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Kal.h"
#import "Event.h"
@interface EventDataSqlite : NSObject<KalDataSource>{
    NSMutableArray *events;
    NSMutableArray *dayEvents;
}
-(id)init;
- (Event *)eventAtIndexPath:(NSIndexPath *)indexPath;
- (NSArray *)eventsFrom:(NSDate *)fromDate to:(NSDate *)toDate;
@end
