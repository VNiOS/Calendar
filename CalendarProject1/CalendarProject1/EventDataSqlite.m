//
//  EventDataSqlite.m
//  CalendarProject1
//
//  Created by Applehouse on 10/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define Kdaytime 60*60*24


#import "EventDataSqlite.h"
#import "Event.h"
@implementation EventDataSqlite
-(id)init{
    if ((self = [super init])) {
        events=[[NSMutableArray alloc]init];
        dayEvents=[[NSMutableArray alloc]init];
        
        
        
        
        //tao du lieu mau
        NSDateFormatter *format=[[NSDateFormatter alloc]init];
        [format setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
        for (int i=0; i<5; i++) {
            NSString *title=[NSString stringWithFormat:@"Event %d",i];
            NSDate *dateStart=[NSDate dateWithTimeIntervalSinceNow:Kdaytime*(3*i)];
            NSDate *dateEnd=[NSDate dateWithTimeIntervalSinceNow:Kdaytime*(3*i)+7200];
            NSString *startTime=[format stringFromDate:dateStart];
            NSString *EndTime=[format stringFromDate:dateEnd];
            NSString *local=[NSString stringWithFormat:@"local %d",i];
            NSString *detail=[NSString stringWithFormat:@"Day la event thu %d",i];
            
            Event *ev=[[Event alloc]initWithEvent_id:i Title:title TimeStart:startTime TimeEnd:EndTime Repeat:0 TimeRepeat:@"0" Local:local Detail:detail];
            [events addObject:ev];
            
        }
             
     }
    return self;
    
    
    
    
}



#pragma mark UITableViewDataSource protocol conformance
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    Event *event=[self eventAtIndexPath:indexPath];
    cell.textLabel.text=event.title;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [dayEvents count];
}

#pragma mark KalDataSource protocol conformance
- (void)presentingDatesFrom:(NSDate *)fromDate to:(NSDate *)toDate delegate:(id<KalDataSourceCallbacks>)delegate
{
    
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:fromDate];
     NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:toDate];
    NSLog(@"get event data from database , from day %d month %d  to day %d of month %d",[components1 day],[components1 month],[components2 day],[components2 month]);
    
    
    //ham lay du lieu tu event tu database  cho month dang hien thi 
    
    [delegate loadedDataSource:self];//load datasource cho KalviewControl de cap nhat view
    
}

- (NSArray *)markedDatesFrom:(NSDate *)fromDate to:(NSDate *)toDate
{
    // tra ve mang gom nhung phan tu startDate cua Event tuong ung
    
    return [[self eventsFrom:fromDate to:toDate] valueForKeyPath:@"startDate"];
}

- (void)loadItemsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate 
   // ham load event from date , truyen vao 2 tham so fromDate va toDate de ham eventsFrom: su dung , tra ve 1 mang cac event luu vao 1 mang global
{
    
    
    NSDateFormatter *format=[[NSDateFormatter alloc]init];
    [format setDateFormat:@"dd/MM/YYYY"];
    NSString *string=[format stringFromDate:fromDate];
    NSLog(@"load event from date : %@",string);
    [dayEvents addObjectsFromArray:[self eventsFrom:fromDate to:toDate]];

}

- (void)removeAllItems
{
    [dayEvents removeAllObjects];
}
- (NSArray *)eventsFrom:(NSDate *)fromDate to:(NSDate *)toDate
{
    // ham nay lay event from date , tra ve 1 mang cac event , duoc ham loadItemsFromDate su dung;
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    for (Event *ev in events) {
        if ([ev.startDate compare:fromDate] ==NSOrderedDescending && [ev.startDate compare:toDate]==NSOrderedAscending) {
            [arr addObject:ev];
        }
    }
    
    return arr;
    
}
- (Event *)eventAtIndexPath:(NSIndexPath *)indexPath{
   return  [dayEvents objectAtIndex:indexPath.row];
}
@end
