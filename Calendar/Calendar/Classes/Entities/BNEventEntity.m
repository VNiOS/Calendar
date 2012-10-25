//
//  BNEventEntity.m
//  Calendar
//
//  Created by Tuan Nguyen on 10/21/12.
//  Copyright (c) 2012 Lifetimetech. All rights reserved.
//

#import "BNEventEntity.h"

NSString *const BNEventProperiesEventId = @"event_id";
NSString *const BNEventProperiesEventTitle = @"title";
NSString *const BNEventProperiesEventTimeStart = @"timeStart";
NSString *const BNEventProperiesEventTimeEnd = @"timeEnd";
NSString *const BNEventProperiesEventRepeat = @"repeat";
NSString *const BNEventProperiesEventTimeRepeat = @"timeRepeat";
NSString *const BNEventProperiesEventLocal = @"local";
NSString *const BNEventProperiesEventDetail = @"detail";



@implementation BNEventEntity
@synthesize event_id,title,timeEnd,timeStart,timeRepeat,repeat,local,detail,startDate,hourStart;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self.event_id = [[dictionary objectForKey:BNEventProperiesEventId] intValue];
    self.title = [dictionary objectForKey:BNEventProperiesEventTitle];
    self.timeStart = [dictionary objectForKey:BNEventProperiesEventTimeStart];
    self.timeEnd = [dictionary objectForKey:BNEventProperiesEventTimeEnd];
    self.repeat = [[dictionary objectForKey:BNEventProperiesEventRepeat]intValue];
    self.timeRepeat = [dictionary objectForKey:BNEventProperiesEventTimeRepeat];
    self.local = [dictionary objectForKey:BNEventProperiesEventLocal];
    self.detail = [dictionary objectForKey:BNEventProperiesEventDetail];
    
    
    self.startDate = [self convertStringtoDate:self.timeStart];
    self.hourStart=[self getHour:startDate];
    return  self;
    
}
-(NSString *)convertDatetoString:(NSDate *)date{
    NSDateFormatter *df = [[[NSDateFormatter alloc] init]autorelease];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *string=[df stringFromDate:date];
    
    return string;
}
-(NSDate *)convertStringtoDate:(NSString *)string{
    NSDate *result;
    NSDateFormatter *df = [[[NSDateFormatter alloc] init]autorelease];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    result=[df dateFromString:string];
    return result;
}
-(NSString *)getHour:(NSDate *)date{
    NSDateFormatter *df = [[[NSDateFormatter alloc] init]autorelease];
    [df setDateFormat:@"HH:mm a"];
    NSString *string=[df stringFromDate:date];
    
    return string;
}
@end
