//
//  BNEventEntity.h
//  Calendar
//
//  Created by Tuan Nguyen on 10/21/12.
//  Copyright (c) 2012 Lifetimetech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNEventEntity : NSObject{
int event_id;
NSString *title;
NSString *timeStart;
NSString *timeEnd;
int repeat;
NSString *timeRepeat;
NSString *local;
NSString *detail;

NSDate *startDate;
NSString *hourStart;
}
@property int event_id;
@property int repeat;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *timeStart;
@property (nonatomic, retain) NSString *timeEnd;
@property (nonatomic, retain) NSString *timeRepeat;
@property (nonatomic, retain) NSString *local;
@property (nonatomic, retain) NSString *detail;
@property (nonatomic, retain)  NSDate *startDate;
@property (nonatomic, retain) NSString *hourStart;

- (id)initWithDictionary:(NSDictionary *)dictionary;


-(NSString *)convertDatetoString:(NSDate *)date;
-(NSDate *)convertStringtoDate:(NSString *)string;
-(NSString *)getHour:(NSDate *)date;
@end
