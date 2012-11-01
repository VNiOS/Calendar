//
//  EventDataSqlite.m
//  CalendarProject1
//
//  Created by Applehouse on 10/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define Kdaytime 60*60*24
#define KHourtime 60*60

#import "EventDataSqlite.h"
#import "BNEventEntity.h"
#import "EventCellView.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "BNAppDelegate.h"

NSString *const BNEventProperiesEventId1 = @"event_id";
NSString *const BNEventProperiesEventTitle1 = @"title";
NSString *const BNEventProperiesEventTimeStart1 = @"timeStart";
NSString *const BNEventProperiesEventTimeEnd1 = @"timeEnd";
NSString *const BNEventProperiesEventRepeat1 = @"repeat";
NSString *const BNEventProperiesEventTimeRepeat1 = @"timeRepeat";
NSString *const BNEventProperiesEventLocal1 = @"local";
NSString *const BNEventProperiesEventDetail1 = @"detail";

@implementation EventDataSqlite

-(id)init{
    if ((self = [super init])) {
        events=[[NSMutableArray alloc]init];
        dayEvents=[[NSMutableArray alloc]init];
          //tao du lieu mau
         
       BNAppDelegate  *appDelegate = (BNAppDelegate *)[[UIApplication sharedApplication] delegate];
        NSString *databasePath = appDelegate.databasePath;
        NSLog(@"Init sqlite database");
        database = [[FMDatabase databaseWithPath:databasePath]retain];        
        
     }
    return self;
 }



#pragma mark UITableViewDataSource protocol conformance


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MyCell";
    EventCellView *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[EventCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    BNEventEntity *event=[self eventAtIndexPath:indexPath];
    cell.titlelb.text=event.title;
    cell.timelb.text=event.hourStart;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([dayEvents count]==0) {
        [tableView.tableFooterView setHidden:NO];
    }
    else{
        [tableView.tableFooterView setHidden:YES];
    }
    return [dayEvents count];
}

#pragma mark KalDataSource protocol conformance
- (void)presentingDatesFrom:(NSDate *)fromDate to:(NSDate *)toDate delegate:(id<KalDataSourceCallbacks>)delegate
{
    
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:fromDate];
     NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:toDate];
    NSLog(@"get event data from database , from day %d month %d  to day %d of month %d",[components1 day],[components1 month],[components2 day],[components2 month]);
    [events removeAllObjects];
    [events addObjectsFromArray:[self getEventListFromDate:fromDate toDate:toDate]];
    //ham lay du lieu tu event tu database  cho month dang hien thi 
    
    [delegate loadedDataSource:self];//load datasource cho KalviewControl de cap nhat view
    
}

- (NSArray *)markedDatesFrom:(NSDate *)fromDate to:(NSDate *)toDate
{
    // tra ve mang gom nhung phan tu startDate cua Event tuong ung
    NSArray *result=(NSArray *)[[self eventsFrom:fromDate to:toDate] valueForKeyPath:@"startDate"];
    NSLog(@"Data is maked : %d", result.count);
//    NSDateFormatter *format=[[NSDateFormatter alloc]init];
//    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    for (NSDate *date in result) {
//        NSString *string=[format stringFromDate:date];
//        NSLog(@" %@ is marked",string);
//    }
    return result;
}

- (void)loadItemsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate 
{
       // ham load event from date , truyen vao 2 tham so fromDate va toDate de ham eventsFrom: su dung , tra ve 1 mang cac event luu vao 1 mang global
    
    NSDateFormatter *format=[[NSDateFormatter alloc]init];
    [format setDateFormat:@"dd/MM/YYYY"];
    NSString *string=[format stringFromDate:fromDate];
    [dayEvents removeAllObjects];
    [dayEvents addObjectsFromArray:[self eventsFrom:fromDate to:toDate]];
    NSLog(@"Date %@ have %d events  ",string,[dayEvents count]);
}
- (NSArray *)getEventListFromDate:(NSDate *)fromdate toDate:(NSDate *)toDate{
    [database open];
    NSMutableArray *eventList = [[NSMutableArray alloc] init];
    
    NSLog(@"Get events list from database :");
    
    NSDateFormatter *df = [[[NSDateFormatter alloc] init]autorelease];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *from=[df stringFromDate:fromdate];
    NSString *to=[df stringFromDate:toDate];
    NSString *sql=[NSString stringWithFormat:@"select *from Events where timeStart > '%@' and timeStart < '%@'",from,to];

    
    FMResultSet *results = [database executeQuery:sql];
    while ([results next]) {
        NSMutableDictionary *event = [[NSMutableDictionary alloc] init];
        NSString *event_id=[[NSString stringWithFormat:@"%d",[results intForColumn:BNEventProperiesEventId1]]retain];
        NSString *repeat = [[NSString stringWithFormat:@"%d",[results intForColumn:BNEventProperiesEventRepeat1]]retain];
        NSString *title = [NSString stringWithFormat:@"%@",[results stringForColumn:BNEventProperiesEventTitle1]];
        NSString *timeStart = [NSString stringWithFormat:@"%@",[results stringForColumn:BNEventProperiesEventTimeStart1]];
        NSString *timeEnd = [NSString stringWithFormat:@"%@",[results stringForColumn:BNEventProperiesEventTimeEnd1]];
        NSString *timeRepeat = [NSString stringWithFormat:@"%@",[results stringForColumn:BNEventProperiesEventTimeRepeat1]];
        NSString *local = [NSString stringWithFormat:@"%@",[results stringForColumn:BNEventProperiesEventLocal1]];
        NSString *detail = [NSString stringWithFormat:@"%@",[results stringForColumn:BNEventProperiesEventDetail1]];
        
        
        [event setObject:event_id forKey:BNEventProperiesEventId1];
        [event setObject:title forKey:BNEventProperiesEventTitle1];
        [event setObject:timeStart forKey:BNEventProperiesEventTimeStart1];
        [event setObject:timeEnd forKey:BNEventProperiesEventTimeEnd1];
        [event setObject:repeat forKey:BNEventProperiesEventRepeat1];
        [event setObject:timeRepeat forKey:BNEventProperiesEventTimeRepeat1];
        [event setObject:local forKey:BNEventProperiesEventLocal1];
        [event setObject:detail forKey:BNEventProperiesEventDetail1];
        
         BNEventEntity *newEvent = [[BNEventEntity alloc] initWithDictionary:event];
        [eventList addObject:newEvent];
        [newEvent release];
        
        //NSLog(@"Event id %@ title = %@ timeStart = %@ ",[event objectForKey:BNEventProperiesEventId1],[event objectForKey:BNEventProperiesEventTitle1],[event objectForKey:BNEventProperiesEventTimeStart1]);
     }
    NSLog(@"Event list count %d",eventList.count);
    return [NSArray arrayWithArray:eventList];
    [database close];
}

- (void)removeAllItems
{
    [dayEvents removeAllObjects];
}
- (NSArray *)eventsFrom:(NSDate *)fromDate to:(NSDate *)toDate
{

    
//    NSDateFormatter *df = [[[NSDateFormatter alloc] init]autorelease];
//    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSString *from=[df stringFromDate:fromDate];
//    NSString *to=[df stringFromDate:toDate];
//    
//    NSLog(@"Get event from %@ to %@",from,to);
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    for (BNEventEntity *ev in events) {
        if (([ev.startDate compare:fromDate] ==NSOrderedDescending||[ev.startDate compare:fromDate] ==NSOrderedSame )&& ([ev.startDate compare:toDate] ==NSOrderedAscending||[ev.startDate compare:toDate] ==NSOrderedSame )) {
            [arr addObject:ev];
        }
    }
    
    return arr;
    
}
#pragma mark database
- (BOOL)updateDatabase:(BNEventEntity *)event
{
    
    
    [database open];
    BOOL success = [database executeUpdate:[NSString stringWithFormat:@"update Events set title = '%@',timeStart ='%@',timeEnd = '%@',repeat = '%d',timeRepeat = '%@',local ='%@',detail ='%@'  where event_id = %d",event.title,event.timeStart,event.timeEnd,event.repeat,event.timeRepeat,event.local,event.detail,event.event_id]];
    return success;
    [database close];
}

- (BOOL)insertDatabase:(BNEventEntity *)event
{
    NSLog(@"title %@",event.title);
    NSLog(@"location %@",event.local);
    NSLog(@"timestart %@",event.timeStart);
    NSLog(@"timeEnd%@",event.timeEnd);
    NSLog(@"time repeat %@",event.timeRepeat);
    NSLog(@"repeat %d",event.repeat);
    NSLog(@"Detail %@",event.detail);
    
    [database open];
    bool success = [database executeUpdate:@"insert into Events(title,timeStart,timeEnd,repeat,timeRepeat,local,detail) values(?,?,?,?,?,?,?)",event.title,event.timeStart,event.timeEnd,[NSNumber numberWithInt:event.repeat],event.timeRepeat,event.local,event.detail,nil];
    return success;
    [database close];
    
}
- (BOOL)deleteDatabase:(BNEventEntity *)event
{
    
    [database open];
    bool success = [database executeUpdate:[NSString stringWithFormat:@"delete from Events where event_id ='%d'",event.event_id]];
    [database close];
    return success;
}

- (BNEventEntity *)eventAtIndexPath:(NSIndexPath *)indexPath{
   return  [dayEvents objectAtIndex:indexPath.row];
}
-(void)dealloc{
    
    [super dealloc];
    [events release];
    [dayEvents release];
}
@end
