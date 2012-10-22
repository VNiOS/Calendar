//
//  Event.m
//  CalendarProject1
//
//  Created by Applehouse on 10/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Event.h"

@implementation Event
@synthesize event_id,title,timeEnd,timeStart,timeRepeat,repeat,local,detail,startDate;
-(id)initWithEvent_id:(int )event_id1 Title:(NSString *)title1 TimeStart:(NSString *)timeStart1 TimeEnd:(NSString *)timeEnd1 Repeat:(int )repeat1 TimeRepeat:(NSString *)timeRepeat1 Local:(NSString *)local1 Detail:(NSString *)detail1
{
    self.event_id = event_id1;
    self.title = title1;
    self.timeStart = timeStart1;
    self.timeEnd = timeEnd1;
    self.timeRepeat = timeRepeat1;
    self.repeat = repeat1;
    self.local = local1;
    self.detail = detail1;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    self.startDate = [df dateFromString:timeStart];

    
    
    
    return  self;
    
}
@end
