//
//  Event.h
//  CalendarProject1
//
//  Created by Applehouse on 10/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject{
    int event_id;
    NSString *title;
    NSString *timeStart;
    NSString *timeEnd;
    int repeat;
    NSString *timeRepeat;
    NSString *local;
    NSString *detail;
    
    NSDate *startDate;
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

-(id)initWithEvent_id:(int )event_id1 Title:(NSString *)title1 TimeStart:(NSString *)timeStart1 TimeEnd:(NSString *)timeEnd1 Repeat:(int )repeat1 TimeRepeat:(NSString *)timeRepeat1 Local:(NSString *)local1 Detail:(NSString *)detail1;
@end
